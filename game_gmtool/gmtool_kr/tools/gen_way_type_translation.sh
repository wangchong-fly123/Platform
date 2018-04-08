#!/bin/bash

script_name=`basename $0`
script_abs_name=`readlink -f $0`
script_path=`dirname $script_abs_name`
gm_tool_path=$script_path/..
output_file=$gm_tool_path/bin/sgzj-gmserver/app/lib/WayTypeTranslation.php

if [ $# -eq 0 ]
then
    input_file=$gm_tool_path/../server2/src/common/define/way_type.h
elif [ $# -eq 1 ]
then
    input_file=$1
else
    echo "usage: `basename $0` [<input_file>]"
    exit 1
fi

if [ ! -f $input_file ]
then
    echo "$input_file missing"
    exit 1
fi

awk --re-interval '
BEGIN {
    printf(\
"<?php\n\n" \
"final class WayTypeTranslation\n" \
"{\n" \
"    private static $translation_ = array(\n" \
    );
}
match($0, /.*= +([0-9]+),.*\/\/ +([^ ]*)/, m) {
    printf("        %s => \"%s\",\n", m[1], m[2]);
}
END {
    printf(\
"    );\n\n" \
"    public static function get($id)\n" \
"    {\n" \
"        if (isset(self::$translation_[$id])) {\n" \
"            return self::$translation_[$id];\n" \
"        } else {\n" \
"            return $id;\n" \
"        }\n" \
"    }\n" \
"}\n" \
    );
}
' $input_file > $output_file
