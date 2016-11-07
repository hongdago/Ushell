#!/bin/sh
#validAlphaNum--ensures that input consists only of alphabetical
#and numeric characters.

validAlphaNum()
{
    compressed="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

    if [ "$compressed" != "$1" ]
    then
        return 1
    else
        return 0
    fi
}

echo -n "Enter input:"
read input

if ! validAlphaNum $input
then
    echo "You input must consist of only letters and numbers." >&2
    exit 1
else
    echo "Input is valid."
fi
