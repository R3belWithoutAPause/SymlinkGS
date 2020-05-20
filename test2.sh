#!/usr/bin/ksh

#  Set select construct prompts for each menu level.
typeset -r MAINPROMPT="Select a main option: "
typeset -r INSTALLPROMPT="Select an install option: "
typeset -r GSINSTALLPROMPT="Please select a gameserver top: "
#  Loop main menu until user exits explicitly.
while :; do
   printf "\nTop-level Menu Title Goes Here\n"
   PS3=$MAINPROMPT # PS3 is the prompt for the select construct.

   OPTIONS=("Install" "Update" "Remove" "Quit")
   select OPTION in "${OPTIONS[@]}"; do
      case $REPLY in # REPLY is set by the select construct, and is the number of the selection.
      Install)       # mango (has a sub-menu)
         #  Loop mango menu until user exits explicitly.
         while :; do
            printf "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            OPTIONS=("Gameserver" "Masterserver" "Maps" "Mods" "Back" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
               case $REPLY2 in
               Gameserver) # add
                  while :; do
                     printf "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Left 4 Dead 2" "Left 4 Dead " "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY3 in
                        "Left 4 Dead 2") # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        "Left 4 Dead") # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        "Maps") # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        "Mods") # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        "Back")      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        "Quit")      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           printf "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Masterserver) # subtract
                  while :; do
                     printf "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           printf "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Maps) # add
                  while :; do
                     printf "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           printf "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Mods) # subtract
                  while :; do
                     printf "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           printf "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           printf "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           printf "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Back)      # exit
                  break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                  ;;
               *) # always allow for the unexpected
                  printf "\nUnknown mango operation [${REPLY}]"
                  break
                  ;;
               esac
            done
         done
         break
         ;;
      Update) # Update
         #  Loop Update till user breaks out
         while :; do
            printf "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            OPTIONS=("Install" "Update" "Remove" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
               case $REPLY in
               1) # add
                  printf "\nYou picked [add]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               2) # subtract
                  printf "\nYou picked [subtract]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               3)         # exit
                  break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                  ;;
               *) # always allow for the unexpected
                  printf "\nUnknown mango operation [${REPLY}]"
                  break
                  ;;
               esac
            done
         done
         break
         ;;
      Remove) # Remove
         #  Loop mango menu until user exits explicitly.
         while :; do
            printf "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            select option1 in add substract exit; do
               case $REPLY in
               1) # add
                  printf "\nYou picked [add]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               2) # subtract
                  printf "\nYou picked [subtract]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               3)         # exit
                  break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                  ;;
               *) # always allow for the unexpected
                  printf "\nUnknown mango operation [${REPLY}]"
                  break
                  ;;
               esac
            done
         done
         break
         ;;
      Quit)      # exit
         break 2 #  Break out 2 levels, out of the select and the main loop.
         ;;
      *) # Always code for the unexpected.
         printf "\nUnknown option [${REPLY}]"
         break
         ;;
      esac
   done
done

exit 0
$
