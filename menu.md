shell脚本文本菜单demo

```
#!/bin/bash
# simple script menu

function diskspace {
        #clear
        echo
        df -k
}

function whoseon {
        #clear
        echo
        who
}

function memusage {
        #clear
        echo
        cat /proc/meminfo
}

draw_title() {
        local str width height length

        width=$(tput cols)
        height=$(tput lines)
        #str="Width = $width Height = $height"
        str="System Admin Menu"
        length=${#str}
        clear
        #tput cup $((height / 2)) $(((width / 2) - (length / 2)))
        tput cup $((height / 4)) $(((width / 2) - (length / 2)))
        echo "$str"
}

function menu {
        #clear
        #echo
        #echo -e "\t\t\tSys Admin Menu\n"
        #draw_title
        echo
        echo
        echo -e "1. Display disk space"
        echo -e "2. Display logged on users"
        echo -e "3. Display memory usage"
        echo -e "4. Exit menu\n"
        echo
        echo -en "Enter an option: "
        read -n 1 option
}

## MAIN

draw_title

while [ 1 ]
do
        menu
        case $option in
                4)
                        break ;;
                1)
                        diskspace ;;
                2)
                        whoseon ;;
                3)
                        memusage ;;
                *)
                        #clear
                        echo -e "\n\tSorry, wrong selection" ;;
        esac
        echo -en "\n\tHit any key to continue"
        read -n 1 line
done
clear

```

select命令实现

```
#!/bin/bash
# using select in the menu

IFS=$'\n'

options=(
        "Display disk space"
        "Display logged on users"
        "Display memory usage"
        "Exit program"
        )

function diskspace {
        #clear
        df -k
}

function whoseon {
        #clear
        who
}

function memusage {
        #clear
        cat /proc/meminfo
}

function draw_title() {
        local str width height length

        width=$(tput cols)
        height=$(tput lines)
        #str="Width = $width Height = $height"
        str="System Admin Menu"
        length=${#str}
        clear
        #tput cup $((height / 2)) $(((width / 2) - (length / 2)))
        tput cup $((height / 8)) $(((width / 2) - (length / 2)))
        echo "$str"
}

## MAIN

draw_title
echo
PS3="Enter an option: "
#select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"
select option in ${options[@]}
do
        case $option in
        "Exit program")
                break ;;
        "Display disk space")
                diskspace ;;
        "Display logged on users")
                memusage ;;
        "Display memory usage")
                memusage ;;
        *)
                #clear
                echo "Sorry, wrong selection";;
        esac
done
#clear

```
