#!/bin/bash

script_name=`basename $0`
script_abs_name=`readlink -f $0`
script_path=`dirname $script_abs_name`
gm_tool_path=$script_path/..
output_file=$gm_tool_path/bin/sgzj-gmserver/public/data/pay_product_suggest.json

if [ $# -eq 0 ]
then
    input_file=$gm_tool_path/../server2/settings/gamedata/tbdata/kr/vippay.txt
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

iconv -f 'UCS-2LE' -t 'UTF-8' $input_file | \
tail -n +3 | \
awk -F '\t' '
BEGIN {
    printf("[\n");
}
{
    if ($3 == 2) {
        desc = $2 "K";
    } else {
        desc = $2 "K";
    }

    printf("{\"id\": \"%s\", \"desc\": \"%s\"},\n", $1, desc);
}' | \
sed '$s/},/}\n]/g' > $output_file
