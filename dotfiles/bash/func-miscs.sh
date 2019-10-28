#!/usr/bin/env bash

function whereispylib()
{
    for lib in "$@"
    do
        python3 -c "
try:
    import $lib
    try:
        if len($lib.__path__) == 1:
            print($lib.__path__[0])
        else:
            print($lib.__path__)
    except AttributeError:
        print('$lib is a built-in module')
except ImportError:
    print('$lib is not installed')
"

    done
}

function prettyjson()
{
    python -m json.tool "$@" | pygmentize -l javascript
}

function airdroid_proxy()
{
    mitmproxy -s test_mtimproxy.py -R https://192.168.87.101:8890/ -b 127.0.0.1 -p 8080
}

function how_to_screengif()
{
    echo "gtk-recordmydesktop"
    echo "mplayer -ao null <VIDEO> -vo jpeg:outdir=output"
    echo "convert output/* output.gif"
    echo ""
    echo "convert output.gif -fuzz 10% -layers Optimize optimised.gif"
    echo "gifsicle -O in.gif -o out.gif"
}

function _swapusage()
{
    for file in /proc/*/status
    do
        NAME="$(awk '/^Name:/{printf $2}' $file)"
        PID="$(awk '/^Pid:/{printf $2}' $file)"
        SWAP="$(awk '/^VmSwap:/{printf $2}' $file)"

        if [[ -n "${SWAP}" ]] && [[ "${SWAP}" != "0" ]]
        then
            echo "${NAME} ${PID} ${SWAP}"
        fi
    done
}

function swapusage()
{
    echo "Name             Pid    Swap"
    _swapusage | column -t | sort -k 3 -n
    echo "Name             Pid    Swap"
}
