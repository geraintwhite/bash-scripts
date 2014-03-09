#!/bin/sh

output="~/Pictures/screenshots"
mode="entire"

show_help() {
cat << EOF
Usage: $(basename $0) [-wsh] [-o OUTPUT]

Options:
    -w    take screenshot of current window
    -s    select an area or window to screenshot
    -o    specify output directory of screenshots - defaults to $output
    -h    show this help text
EOF
}

arg_err() {
cat << EOF
$(basename $0): missing or unknown argument
Try $(basename $0) --help for usage information
EOF
}

OPTIND=1

while getopts ":wso:h" opt; do
    case "$opt" in
        w)  mode="window"
            ;;
        s)  mode="select"
            ;;
        o)  output=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        ?)
            arg_err
            exit 0
            ;;
    esac
done

shift "$((OPTIND-1))"

case "$mode" in
    "entire")
        scrot -e "mv \$f $output"
        ;;
    "window")
        scrot -u -e "mv \$f $output"
        ;;
    "select")
        sleep 0.2
        scrot -s -e "mv \$f $output"
        ;;
esac
