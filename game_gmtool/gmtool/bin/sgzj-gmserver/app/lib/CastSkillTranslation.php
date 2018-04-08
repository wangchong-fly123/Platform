<?php

final class CastSkillTranslation
{
    private static $translation_ = array(
        1  => "技能一",
        2  => "技能二",
        3  => "技能三",
        4  => "技能四",
        5  => "大招",
        6  => "跳",
        7  => "冲刺",
        8  => "暴气",
        9  => "切换武将一",
        10 => "切换武将二",
        11 => "使用道具一",
        12 => "使用道具二",
        13 => "使用道具三",
        14 => "托管",
        15 => "暂停游戏",
    );

    public static function get($id)
    {
        if (isset(self::$translation_[$id])) {
            return self::$translation_[$id];
        } else {
            return $id;
        }
    }
}
