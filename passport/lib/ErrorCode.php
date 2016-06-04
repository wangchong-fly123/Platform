<?php

final class ErrorCode
{
    const UNKNOWN                     = -1; // 未知错误
    const SUCCESS                     = 0;  // 成功
    // 账号类错误
    const ACCOUNT_DUPLICATED          = 1;  // 账号重复
    const GENERATE_ACCOUNT_FAILED     = 2;  // 生成账号失败
    const ACCOUNT_OR_PASSWORD_INVALID = 3;  // 账号或密码无效
    const ACCOUNT_NOT_EXIST           = 4;  // 账号不存在
    // 手机错误
    const MOBILE_PHONE_DUPLICATED     = 21; // 手机号重复
    const ALREADY_BIND_MOBILE_PHONE   = 22; // 已绑定手机号
    const MESSAGE_CODE_INVALID        = 23; // 短信验证码无效
    const NOT_BIND_MOBILE_PHONE       = 24; // 没有绑定手机号
    // 邮箱错误
    const EMAIL_DUPLICATED            = 31; // 邮箱重复
    const ALREADY_BIND_EMAIL          = 32; // 已绑定邮箱
    // 图形验证码
    const CAPTCHA_TEXT_INVALID        = 41; // 图形验证码无效
}
