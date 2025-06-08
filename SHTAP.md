## 交互式shell脚本框架

拆分交互式主体框架供学习使用

```
#!/usr/bin/env bash

# Minimal template for making a text adventure in pure Bash 4.
# See homepage at <https://notimetoplay.org/engines/shtap/>.

typeset -A verb

TITLE='An Interactive Fiction'
HEADLINE=''
AUTHOR='Anonymous'
DATE='2024'
INFO='' # Any additional information: version, license, help verbs and so on.

MAX_SCORE=0

BANNER="Welcome to the SHTAP game engine, a.k.a. the Shell Text Adventure Player."

function quit {
        local -l answer
        echo -n "Really quit? (yes/no) "
        read answer
        if [ "${answer:0:1}" = "y" ]; then
                exit
        fi
}

function look {
        echo "天太黑了，什么也看不见。"
}

function verbs {
        echo "This adventure understands the following verbs: ${!verb[*]}."
}

verb[verbs]=verbs
verb[quit]=quit
verb[look]=look

# Main loop

echo "$BANNER"
echo
echo "$TITLE"
echo "$HEADLINE by $AUTHOR, $DATE"
if [ -n "$INFO" ]; then
        echo "$INFO"
fi
echo

look

echo
echo '(Enter a verb and at most one noun. Type VERBS to see a list.)'

typeset -l cmdverb

while true; do
        echo
        echo -n "> "
        read cmdverb
        echo

        if [ -z "${verb[$cmdverb]}" ]; then
                echo "I don't know how to $cmdverb."
        else
                ${verb[$cmdverb]}
        fi
done
```
