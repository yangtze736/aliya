shell脚本实现，按照一定的速度在屏幕打印文字内容。

```
#!/bin/bash
# Salute to Ivan Marov, Awesome shell.
# Source: https://github.com/vaniacer/piu-piu-SH

BLK='\e[30m'; blk='\e[90m'; BBLK='\e[40m'; bblk='\e[100m' #| Black
RED='\e[31m'; red='\e[91m'; BRED='\e[41m'; bred='\e[101m' #| Red
GRN='\e[32m'; grn='\e[92m'; BGRN='\e[42m'; bgrn='\e[102m' #| Green
YLW='\e[33m'; ylw='\e[93m'; BYLW='\e[43m'; bylw='\e[103m' #| Yellow
BLU='\e[34m'; blu='\e[94m'; BBLU='\e[44m'; bblu='\e[104m' #| Blue
MGN='\e[35m'; mgn='\e[95m'; BMGN='\e[45m'; bmgn='\e[105m' #| Magenta
CYN='\e[36m'; cyn='\e[96m'; BCYN='\e[46m'; bcyn='\e[106m' #| Cyan
WHT='\e[37m'; wht='\e[97m'; BWHT='\e[47m'; bwht='\e[107m' #| White

DEF='\e[0m'   #Default color and effects
BLD='\e[1m'   #Bold\brighter
DIM='\e[2m'   #Dim\darker

XY () { printf "\e[$2;${1}H$3"; }

# story texting speed
storyspd=0.05
storyspd2=0.1


the_story(){
    color="$DEF$BLD$GRN" # main color
    story=(
        "$DEF${RED}Our ${color}research team started to observe the debris of alien mothership."
        "${color}But it's already clear that they are came from $DEF${red}Mars.$DEF${RED}.$DEF$DIM${red}."
        ''
        "${color}The research will be continued but we must act quickly."
        "${color}Lets start our $DEF${red}Mars $DEF${RED}mission $DEF$DIM${red}immediately."
        "${color}One famous $DEF${RED}ornithologist ${color}agree to help us with the transport."
        "${color}Prepare all what is needed for this mission at once."
        "${color}The fait of whole $DEF${RED}mankind ${color}is at $DEF${red}stake!$DEF${RED}.$DEF$DIM${red}."
        "${color}Be brave, it could be a one way ticket."
        ''
        ''
        "${color}Go$DEF${red}od $DEF${RED}lu$DEF$DIM${red}ck!.."
        ''
        ''
        "${color}end of transmission"
        "${color}press any $DEF${red}key $DEF${RED}to $DEF$DIM${red}continue "
    )

        story2=(
            "洞庭青草，近中秋、更无一点风色。"
                "玉鉴琼田三万顷，著我扁舟一叶。"
                "素月分辉，明河共影，表里俱澄澈。悠然心会，妙处难与君说。"
                "应念岭海经年，孤光自照，肝胆皆冰雪。"
                "短发萧骚襟袖冷，稳泛沧浪空阔。"
                "尽挹西江，细斟北斗，万象为宾客。"
                "扣舷独啸，不知今夕何夕。"
    )


    clear
    x=3 y=2
    for line in "${story2[@]}"; do
        size=${#line}
        for ((i=1; i<=size; i++)); {
            [[ ${line:$((i-1)):3} =~ \\e\[ ]] && ((i+=6))
            XY $x $y "${line:0:i}"
            sleep $storyspd2
        }
        ((y++))
    done
    printf "$DEF"
    read   -srn1
    clear
}

the_story
```
