<?php

final class AccountService
{
    private $server_app_ = null;

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public static function getPasswordHash($account, $password)
    {
        return sha1($account.'enjoymi'.$password.'passport');
    }

    public function checkAccountExist($account)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select 1 from `tbl_account` where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            Util::error('db check account exist failed');
        }

        return $sth->rowCount() > 0;
    }

    public function checkPassword($account, $password)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `password` from `tbl_account` where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            Util::error('db check password failed');
        }

        $db_password = $sth->fetchColumn();
        if ($db_password === false) {
            return false;
        }

        return $db_password === $this->getPasswordHash($account, $password);
    }

    public function getAccountInfo($account, $password)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `uid`, `account`, `password`, `account_type`, '.
            '`register_type`, `mobile_phone`, `email`, `create_time` '.
            'from `tbl_account` where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            Util::error('db check password failed');
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }
        $db_password = $ret['password'];
        if ($db_password !== $this->getPasswordHash($account, $password)) {
            return false;
        }

        return $ret;
    }

    public function createAccount(
        $account, $password, $account_type, $register_type)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_account`'.
            '(`account`, `password`, `account_type`, `register_type`, '.
            '`mobile_phone`, `email`, `create_time`) '.
            'values'.
            '(:account, :password, :account_type, :register_type, '.
            ':mobile_phone, :email, :create_time)');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':password',
            $this->getPasswordHash($account, $password), PDO::PARAM_STR);
        $sth->bindValue(':account_type', $account_type, PDO::PARAM_INT);
        $sth->bindValue(':register_type', $register_type, PDO::PARAM_INT);
        if ($register_type === RegisterType::MOBILE) {
            $sth->bindValue(':mobile_phone', $account, PDO::PARAM_STR);
        } else {
            $sth->bindValue(':mobile_phone', null, PDO::PARAM_INT);
        }
        $sth->bindValue(':email', null, PDO::PARAM_INT);
        $sth->bindValue(':create_time', time(), PDO::PARAM_INT);

        if (@$sth->execute() === false) {
            return false;
        }

        $uid = $dbh->lastInsertId();

        return $uid;
    }

    public function convertGuest($account, $new_account, $new_password)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'update `tbl_account` set '.
            '`account` = :new_account, '.
            '`password` = :new_password, '.
            '`account_type` = :new_account_type '.
            'where `account` = :account and '.
            '`account_type` = :account_type');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':account_type', AccountType::GUEST, PDO::PARAM_INT);
        $sth->bindValue(':new_account', $new_account, PDO::PARAM_STR);
        $sth->bindValue(':new_password',
            $this->getPasswordHash($new_account, $new_password),
            PDO::PARAM_STR);
        $sth->bindValue(':new_account_type',
            AccountType::NORMAL, PDO::PARAM_INT);

        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function changePassword($account, $new_password)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'update `tbl_account` set `password` = :password '.
            'where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':password',
            $this->getPasswordHash($account, $new_password), PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            return false;
        }

        // clear login token
        $this->server_app_->getAuthService()->clearLoginToken($account);

        return true;
    }

    public function bindMobilePhone($account, $mobile_phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'update `tbl_account` set `mobile_phone` = :mobile_phone '.
            'where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':mobile_phone', $mobile_phone, PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function getAccountInfoByPhone($mobile_phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `uid`, `account`, `password`, `account_type`, '.
            '`register_type`, `mobile_phone`, `email`, `create_time` '.
            'from `tbl_account` where `mobile_phone` = :mobile_phone');
        $sth->bindValue(':mobile_phone', $mobile_phone, PDO::PARAM_STR);

        if (@$sth->execute() === false) {
            Util::error('db get account by phone failed');
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return $ret;
    }
}
