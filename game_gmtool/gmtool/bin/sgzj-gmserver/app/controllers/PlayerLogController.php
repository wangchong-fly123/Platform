<?php

final class PlayerLogController extends ControllerBase
{
    public function resItemLogAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function actionLogAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function getResItemLogAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/res_item_log.php', array(
                'player_id' => $player_id,
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $log_list = array();
        foreach ($ret as $log_string) {
            $parts = explode(',', $log_string);
            $log_type = $parts[0];
            $timestamp = DataFormatter::timestamp($parts[1]);
            $way = DataFormatter::wayType($parts[2]);
            $way_desc = $parts[3];

            if ($log_type === 'RES') {
                $log_type = '资源';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::resourceId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];

            } else if ($log_type === 'ITEM') {
                $log_type = '道具';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];

            } else if ($log_type === 'JEWELRY') {
                $log_type = '饰品';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';

            } else if ($log_type === 'FASHION') {
                $log_type = '时装';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];
                if ($new_value > 0) {
                    $new_value = DataFormatter::timestamp($new_value);
                }

            } else if ($log_type === 'ITEMOVERFLOW') {
                $log_type = '溢出';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = '-';

            } else if ($log_type === 'FIGHT_SOUL') {
                $log_type = '战魂';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';
            } else if ($log_type === 'TOPSTONE') {
                $log_type = '符石';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';
            } else if ($log_type === 'ACCESSORY') {
                $log_type = '军械';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';
            }


            $log = array(
                'log_type' => $log_type,
                'timestamp' => $timestamp,
                'way' => $way,
                'way_desc' => $way_desc,
                'res_item_id' => $res_item_id,
                'res_item_name' => $res_item_name,
                'change_value' => $change_value,
                'new_value' => $new_value,
            );

            array_push($log_list, $log);
        }

        return $this->success(array(
            'log_list' => $log_list,
        ));
    }

    public function getActionLogAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/action_log.php', array(
                'player_id' => $player_id,
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $log_list = array();
        foreach ($ret as $log_string) {
            $parts = explode(',', $log_string);
            $log_type = $parts[0];
            $timestamp = DataFormatter::timestamp($parts[1]);
            $log_info = $this->formatActionLogInfo($log_type, $parts);

            $log = array(
                'log_type' => $log_type,
                'timestamp' => $timestamp,
                'log_info' => $log_info,
            );

            array_push($log_list, $log);
        }

        return $this->success(array(
            'log_list' => $log_list,
        ));
    }

    private function getBuddyInfo($log_parts, $start_index)
    {
        $buddy_info = '';
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $buddy_info_parts = explode('&', $log_parts[$i]);
            if (count($buddy_info_parts) > 7) {
                $buddy_info .= '<br/>'.
                    '武将名: '.DataFormatter::buddyId($buddy_info_parts[0]).' '.
                    '等级: '.$buddy_info_parts[1].' '.
                    '普通攻击: '.$buddy_info_parts[2].' '.
                    '技能攻击: '.$buddy_info_parts[3].' '.
                    '普通防御: '.$buddy_info_parts[4].' '.
                    '技能防御: '.$buddy_info_parts[5].' '.
                    '血量: '.$buddy_info_parts[6].' '.
                    '战斗力: '.$buddy_info_parts[7];
            }
        }

        return $buddy_info;
    }

    private function getSkillInfo($log_parts, $start_index)
    {
        $skills = array();
        $skill_info = '';

        // sort skill
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $skill_info_parts = explode('&', $log_parts[$i]);
            $skill_id = $skill_info_parts[0];
            $skill_count = $skill_info_parts[1];
            $skills[$skill_id] = $skill_count;
        }
        ksort($skills);
        // get skill info
        foreach ($skills as $skill_id => $skill_count) {
            $skill_info .= ' '.
                DataFormatter::castSkillId($skill_id).": ".
                $skill_count;
        }

        return $skill_info;
    }

    private function getSkillLevelInfo($log_parts, $start_index)
    {
        $skills = array();
        $skill_info = '';

        // sort skill
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $skill_info_parts = explode('&', $log_parts[$i]);
            $skill_id = $skill_info_parts[0];
            $skill_level = $skill_info_parts[1];
            $skill_info .= ' 技能:'.
                $skill_id.',等级: '.
                $skill_level.' ';
        }

        return $skill_info;
    }

    private function formatActionLogInfo(&$log_type, $log_parts)
    {
        if ($log_type === 'LOGIN') {
            $log_type = '登录';
            return '建号时间: '.DataFormatter::timestamp($log_parts[2]).' '.
                   '帐号: '.$log_parts[3].' '.
                   '玩家名: '.$log_parts[4].' '.
                   'VIP等级: '.$log_parts[5].' '.
                   '玩家等级: '.$log_parts[6].' '.
                   '玩家经验: '.$log_parts[7].' '.
                   '武将数量: '.$log_parts[8].' '.
                   '官职等级: '.$log_parts[9].' '.
                   '官职经验: '.$log_parts[10].' '.
                   '段位积分: '.$log_parts[11];
        } else if ($log_type === 'IP' || $log_type === 'LOGINIP') {
            $log_type = '登录IP';
            return '帐号: '.$log_parts[2].' '.
                   'IP: '.$log_parts[3];

        } else if ($log_type === 'LOGOUT') {
            $log_type = '登出';
            return '帐号: '.$log_parts[2].' '.
                   '玩家名: '.$log_parts[3].' '.
                   'VIP等级: '.$log_parts[4].' '.
                   '玩家等级: '.$log_parts[5].' '.
                   '玩家经验: '.$log_parts[6].' '.
                   '武将数量: '.$log_parts[7].' '.
                   '官职等级: '.$log_parts[8].' '.
                   '官职经验: '.$log_parts[9].' '.
                   '段位积分: '.$log_parts[10];

        } else if ($log_type === 'CREATEROLE') {
            $log_type = '创角';
            return '帐号: '.$log_parts[2].' '.
                   '玩家名: '.$log_parts[3].' '.
                   'VIP等级: '.$log_parts[4].' '.
                   '玩家等级: '.$log_parts[5].' '.
                   '玩家经验: '.$log_parts[6].' '.
                   '武将数量: '.$log_parts[7].' '.
                   '官职等级: '.$log_parts[8].' '.
                   '官职经验: '.$log_parts[9].' '.
                   '段位积分: '.$log_parts[10];

        } else if ($log_type === 'BUDDY') {
            $log_type = '武将';
            return '位置: '.$log_parts[2].' '.
                   '武将名: '.DataFormatter::buddyId($log_parts[3]).' '.
                   '等级: '.$log_parts[4].' '.
                   '品质: '.$log_parts[5].' '.
                   '星数: '.$log_parts[6].' '.
                   '突破: '.$log_parts[7].' '.
                   '觉醒: '.$log_parts[8].' '.
                   $this->getSkillLevelInfo($log_parts, 9);

        } else if ($log_type === 'ONLINE') {
            $log_type = '在线时间';
            return '帐号: '.$log_parts[2].' '.
                   '玩家名: '.$log_parts[3].' '.
                   '日累计在线时间: '.(int)($log_parts[4] / 60).'(分) '.
                   '周累计在线时间: '.(int)($log_parts[5] / 60).'(分) '.
                   '累计在线时间: '.(int)($log_parts[6] / 60).'(分)';

        } else if ($log_type === 'COPY') {
            $log_type = '单人副本';
            return '帐号: '.$log_parts[2].' '.
                   '玩家名: '.$log_parts[3].' '.
                   '副本ID: '.$log_parts[4].' '.
                   '副本难度: '.$log_parts[5].' '.
                   '耗时: '.$log_parts[6].'(秒) '.
                   '复活次数: '.$log_parts[7].' '.
                   '是否胜利: '.$log_parts[8].' '.
                   '星数: '.$log_parts[9].' '.
                   '武将阵亡: '.$log_parts[10].
                   $this->getBuddyInfo($log_parts, 11).
                   '是否使用加速挂: '.$log_parts[count($log_parts)-1];

        } else if ($log_type === 'DYNAMIC') {
            $log_type = '多人副本';
            return '帐号: '.$log_parts[2].' '.
                   '玩家名: '.$log_parts[3].' '.
                   '副本ID: '.$log_parts[4].' '.
                   '副本难度: '.$log_parts[5].' '.
                   '耗时: '.$log_parts[6].'(秒) '.
                   '复活次数: '.$log_parts[7].' '.
                   '是否胜利: '.$log_parts[8].' '.
                   '类型: '.$log_parts[9].' '.
                   '武将阵亡: '.$log_parts[10].
                   $this->getBuddyInfo($log_parts, 11).
                   '是否使用加速挂: '.$log_parts[count($log_parts)-1];

        } else if ($log_type === 'CASTSKILL') {
            $log_type = '使用技能';
            return '武将名: '.DataFormatter::buddyId($log_parts[2]).' '.
                   $this->getSkillInfo($log_parts, 3);

        } else if ($log_type === 'BATTLECOMMON') {
            $log_type = '使用技能';
            return $this->getSkillInfo($log_parts, 2);

        } else if ($log_type === 'MASTEREQUIP') {
            $log_type = '主公装备';
            return '装备ID: '.$log_parts[2].' '.
                   '强化等级: '.$log_parts[3].' '.
                   '装备品阶: '.$log_parts[4].' '.
                   '宝石1: '.$log_parts[5].' '.
                   '宝石2: '.$log_parts[6].' '.
                   '星数: '.$log_parts[7];

        } else if ($log_type === 'STORE') {
            $log_type = '商店购买';
            return '商店ID: '.$log_parts[2].' '.
                   '商品格子: '.$log_parts[3].' '.
                   '购买数量: '.$log_parts[4].' '.
                   '物品ID: '.$log_parts[5].' '.
                   '物品数量: '.$log_parts[6];

        } else if ($log_type === 'EXERCISESKILL') {
            $log_type = '军团锻炼技能';
            return $this->getSkillLevelInfo($log_parts, 3);

        } else if ($log_type === 'GUILDDAMAGEBOOS') {
            $log_type = '军团对boss伤害';
            return '副本ID: '.$log_parts[2].' '.
                   '对boss造成的伤害: '.$log_parts[3].' '.
                   '军团ID: '.$log_parts[4].' '.
                   '军团名称: '.$log_parts[5].' '.
                   '耗时: '.$log_parts[6];

        } else if ($log_type === 'GUILDDAMAGEKILL') {
            $log_type = '军团玩家杀死BOOS';
            return '副本ID: '.$log_parts[2].' '.
                   '对boss造成的伤害: '.$log_parts[3].' '.
                   '军团ID: '.$log_parts[4].' '.
                   '军团名称: '.$log_parts[5].' '.
                   '耗时: '.$log_parts[6];

        } else if ($log_type === 'GUILDBOOSSURPLUSBLOOD') {
            $log_type = '军团BOOS剩余血量';
            return '副本ID: '.$log_parts[2].' '.
                   'boss剩余血量: '.$log_parts[3];

        }
    }
}
