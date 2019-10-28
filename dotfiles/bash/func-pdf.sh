#!/usr/bin/env bash

function grepdf()
{
    if [ $# -ne 2 ] && [ $# -ne 3 ]; then
        echo "Usage: grepdf <pattern> <path> [<grep opt>]"
        return 0
    fi

    pattern=$1
    path=$2
    grepopt=""
    if [ $# -eq 3 ]; then
        grepopt=$3
    fi

    find_cmd="pdftotext -q '{}' - | grep $grepopt --with-filename --label='{}' --color \"$pattern\""
    find "$path" -name "*.pdf" -exec sh -c "$find_cmd" \;
}

function pdf_extract_page()
{
    if [ $# -ne 4 ]
    then
        echo "usage: ./script infile outfile start(including ; 0-indexed) stop(including ; 0-indexed)"
        return 1
    fi

    INFILE=$1
    OUTFILE=$2
    START=$3
    STOP=$4

    gs -sDEVICE=pdfwrite -dNOPAUSE -dSAFER -dFirstPage="$START" -dLastPage="$STOP" -sOutputFile="$OUTFILE" "$INFILE"
}

function pdf_diff()
{
    echo 'compare -verbose -debug coder $PDF_1 $PDF_2 -compose src $OUT_FILE.pdf'
}
