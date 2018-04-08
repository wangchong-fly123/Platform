<?php

final class DataFormatter
{
    public static function timestamp($unix_time)
    {
        if ($unix_time == 0) {
            return "0";
        } else {
            return strftime("%Y:%m:%d-%H:%M:%S", $unix_time);
        }
    }

    public static function wayType($way_type)
    {
        return WayTypeTranslation::get($way_type);
    }

    public static function resourceId($resource_id)
    {
        return ResourceIdTranslation::get($resource_id);
    }

    public static function itemId($item_id)
    {
        return ItemIdTranslation::get($item_id);
    }

    public static function buddyId($buddy_id)
    {
        return BuddyIdTranslation::get($buddy_id);
    }

    public static function channelId($channel_id)
    {
        return ChannelIdTranslation::get($channel_id);
    }

    public static function castSkillId($cast_skill_id)
    {
        return CastSkillTranslation::get($cast_skill_id);
    }

}
