## Cursor control capnames

We can modify our previous script to use cursor positioning and to place the window dimensions in the center as the terminal is resized:

```
    #!/bin/bash
    # term_size3 - Dynamically display terminal window size
    #              with text centering

    redraw() {
        local str width height length
        
        width=$(tput cols)
        height=$(tput lines)
        str="Width = $width Height = $height"
        length=${#str}
        clear
        tput cup $((height / 2)) $(((width / 2) - (length / 2)))
        echo "$str"
    }

    trap redraw WINCH

    redraw
    while true; do
        :
    done
```

## Text colors

The following script uses the setaf and setab capabilities to display the available foreground/background color combinations:

```
#!/bin/bash

    # tput_colors - Demonstrate color combinations.

    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done

```

## Screen erasure capnames

Using some of these terminal capabilities, we can construct a script with a menu and a separate output area to display some system information:

```
#!/bin/bash

    # tput_menu: a menu driven system information program

    BG_BLUE="$(tput setab 4)"
    BG_BLACK="$(tput setab 0)"
    FG_GREEN="$(tput setaf 2)"
    FG_WHITE="$(tput setaf 7)"

    # Save screen
    tput smcup

    # Display menu until selection == 0
    while [[ $REPLY != 0 ]]; do
      echo -n ${BG_BLUE}${FG_WHITE}
      clear
      cat <<- _EOF_
        Please Select:

        1. Display Hostname and Uptime
        2. Display Disk Space
        3. Display Home Space Utilization
        0. Quit

_EOF_

      read -p "Enter selection [0-3] > " selection
      
      # Clear area beneath menu
      tput cup 10 0
      echo -n ${BG_BLACK}${FG_GREEN}
      tput ed
      tput cup 11 0

      # Act on selection
      case $selection in
        1)  echo "Hostname: $HOSTNAME"
            uptime
            ;;
        2)  df -h
            ;;
        3)  if [[ $(id -u) -eq 0 ]]; then
              echo "Home Space Utilization (All Users)"
              du -sh /home/* 2> /dev/null
            else
              echo "Home Space Utilization ($USER)"
              du -s $HOME/* 2> /dev/null | sort -nr
            fi
            ;;
        0)  break
            ;;
        *)  echo "Invalid entry."
            ;;
      esac
      printf "\n\nPress any key to continue."
      read -n 1
    done

    # Restore screen
    tput rmcup
    echo "Program terminated."
```



from url: https://linuxcommand.org/lc3_adv_tput.php
