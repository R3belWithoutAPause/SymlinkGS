#!/usr/bin/ksh

#  Set select construct prompts for each menu level.
typeset -r MAINPROMPT="Select a main option: "
typeset -r MANGOPROMPT="Select mango option: "

#  Loop main menu until user exits explicitly.
while :; do
   print "\nTop-level Menu Title Goes Here\n"
   PS3=$MAINPROMPT # PS3 is the prompt for the select construct.

   OPTIONS=("Install" "Update" "Remove" "Quit")
   select OPTION in "${OPTIONS[@]}"; do
      case $REPLY in # REPLY is set by the select construct, and is the number of the selection.
      Install)       # mango (has a sub-menu)
         #  Loop mango menu until user exits explicitly.
         while :; do
            print "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            OPTIONS=("Gameserver" "Masterserver" "Maps" "Mods" "Back" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
               case $REPLY in
               Gameserver) # add
                  while :; do
                     print "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           print "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Masterserver) # subtract
                  while :; do
                     print "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           print "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Maps) # add
                  while :; do
                     print "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           print "\nUnknown mango operation [${REPLY}]"
                           break
                           ;;
                        esac
                     done
                  done
                  ;;
               Mods) # subtract
                  while :; do
                     print "\nmango sub-menu title\n"
                     PS3=$MANGOPROMPT
                     OPTIONS=("Install" "Update" "Maps" "Mods" "Back" "Quit")
                     select OPTION in "${OPTIONS[@]}"; do
                        case $REPLY in
                        Gameserver) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Masterserver) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Maps) # add
                           print "\nYou picked [add]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Mods) # subtract
                           print "\nYou picked [subtract]"
                           break #  Breaks out of the select, back to the mango loop.
                           ;;
                        Back)      # exit
                           break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                           ;;
                        *) # always allow for the unexpected
                           print "\nUnknown mango operation [${REPLY}]"
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
                  print "\nUnknown mango operation [${REPLY}]"
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
            print "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            OPTIONS=("Install" "Update" "Remove" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
               case $REPLY in
               1) # add
                  print "\nYou picked [add]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               2) # subtract
                  print "\nYou picked [subtract]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               3)         # exit
                  break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                  ;;
               *) # always allow for the unexpected
                  print "\nUnknown mango operation [${REPLY}]"
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
            print "\nmango sub-menu title\n"
            PS3=$MANGOPROMPT
            select option1 in add substract exit; do
               case $REPLY in
               1) # add
                  print "\nYou picked [add]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               2) # subtract
                  print "\nYou picked [subtract]"
                  break #  Breaks out of the select, back to the mango loop.
                  ;;
               3)         # exit
                  break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                  ;;
               *) # always allow for the unexpected
                  print "\nUnknown mango operation [${REPLY}]"
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
         print "\nUnknown option [${REPLY}]"
         break
         ;;
      esac
   done
done

exit 0
$
