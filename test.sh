#!/bin/bash
## Debugging
#set -o nounset
#set -o errexit
#set -x

## Check that we are root user

if [ $(id -u) != "0" ]; then
    echo "You must be the superuser to run this script" >&2
    exit 1
fi

## Declare functions

function redMessage() {
    echo -e "\\033[31;1m${@}\033[0m"
}

function errorAndQuit() {
    errorAndExit "Exit now!"
}

function errorAndExit() {
    redMessage ${@}
    exit 0
}

function getTask() {

    ## First lets find out what the user wants to do
    OPTIONS=("Install Gameserver" "Update Gameserver" "Remove Gameserver" "Install/Update Maps" "Install/Update Mods" "Install Master" "Update Master" "Remove Master" "Quit")
    select OPTION in "${OPTIONS[@]}"; do
        case "$REPLY" in
        1 | 2 | 3 | 4 | 5 | 6 | 7 | 8) break ;;
        9) errorAndQuit ;;
        *) errorAndContinue ;;
        esac
        #export $INSTALL_TYPE
    done

    if [ "$OPTION" == "Install Gameserver" ]; then
        INSTALL_TYPE="INSTALL_GS"
    elif [ "$OPTION" == "Update Gameserver" ]; then
        INSTALL_TYPE="UPDATE_GS"
    elif [ "$OPTION" == "Remove Gameserver" ]; then
        INSTALL_TYPE="REMOVE_GS"
    elif [ "$OPTION" == "Install/Update Maps" ]; then
        INSTALL_TYPE="INSTALL_MODS"
    elif [ "$OPTION" == "Install/Update Mods" ]; then
        INSTALL_TYPE="INSTALL_MAPS"
    elif [ "$OPTION" == "Install Master" ]; then
        INSTALL_TYPE="INSTALL_MS"
    elif [ "$OPTION" == "Update Master" ]; then
        INSTALL_TYPE="UPDATE_MS"
    elif [ "$OPTION" == "Remove Master" ]; then
        INSTALL_TYPE="REMOVE_MS"
    fi

    OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
    select OPTION in "${OPTIONS[@]}"; do
        case "$REPLY" in
        1 | 2 | 3) break ;;
        4) errorAndQuit ;;
        *) errorAndContinue ;;
        esac
    done

    if [ "$OPTION" == "Left 4 Dead 2" ]; then
        GAME="L4D2"
        MASTER_DIR="/home/servers/master/left4dead2"
        INSTALL_DIR="/home/servers/servers/left4dead2"
        ADDON_DIR="/home/servers/addons/l4d2"
        GAMETYPE="left4dead2"

    elif [ "$OPTION" == "Left 4 Dead" ]; then
        GAME="L4D"
        MASTER_DIR="/home/servers/master/left4dead"
        INSTALL_DIR="/home/servers/servers/left4dead"
        ADDON_DIR="/home/servers/addons/l4d"
        GAMETYPE="left4dead"

    elif [ "$OPTION" == "Killing Floor 2" ]; then
        GAME="KF2"
        MASTER_DIR="/home/servers/master/kf2"
        INSTALL_DIR="/home/servers/servers/kf2"
        ADDON_DIR="/home/servers/addons/kf2"
        GAMETYPE="kf2"
    fi

}

function msTasks() {
    ## function to install/update/remove
    ## masterserver for a particular game
    #  Set select construct prompts for each menu level.
    typeset -r MAINPROMPT="Select a main option: "
    typeset -r INSTALLPROMPT="Select an install option: "
    typeset -r GSPROMPT="Select a gameserver option: "
    typeset -r GSINSTALLPROMPT="Which Gameserver would you like to install?: "
    typeset -r MSINSTALLPROMPT="Which Masterserver would you like to install?: "
    #  Loop main menu until user exits explicitly.
    while :; do
        printf "\nMain Menu\n"
        PS3=$MAINPROMPT # PS3 is the prompt for the select construct.
        select option in Install Update Remove exit; do
            case $REPLY in # REPLY is set by the select construct, and is the number of the selection.
            1)             # Install
                #  Loop mango menu until user exits explicitly.
                while :; do
                    printf "\nInstall Sub-menu\n"
                    echo ""
                    PS3=$INSTALLPROMPT
                    select option in Gameserver Masterserver Maps Mods Exit; do
                        case $REPLY in
                        1) # Gameserver
                            while :; do
                                printf "\nGameserver Sub-menu\n"
                                echo ""
                                PS3=$GSPROMPT
                                select option in Install Update Remove Exit; do
                                    case $REPLY in
                                    1) # Install
                                        while :; do
                                            printf "\n Install Gameserver Sub-menu\n"
                                            echo ""
                                            PS3=$GSINSTALLPROMPT
                                            select option in "Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" Exit; do
                                                case $REPLY in
                                                1) # Left 4 Dead 2 Install menu
                                                    echo "\nYou picked Left 4 Dead 2 Install menu"
                                                    #break #  Breaks out of the select, back to the mango loop.

                                                    ## Choose a map for when we install the server
                                                    OPTIONS=("Dead Center" "Dark Carnival" "Swamp Fever" "Hard Rain" "The Parish" "The Passing" "The Sacrifice" "No Mercy" "Death Toll" "Dead Air" "Blood Harvest" "Cold Stream" "Crash Course" "Quit")
                                                    select OPTION in "${OPTIONS[@]}"; do
                                                        case "$REPLY" in
                                                        1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13) break ;;
                                                        14) errorAndQuit ;;
                                                        *) errorAndContinue ;;
                                                        esac
                                                    done

                                                    ## Setting map variable for when we install the server
                                                    if [ "$OPTION" == "Dead Center" ]; then
                                                        MAP="c1m1_hotel"
                                                    elif [ "$OPTION" == "Dark Carnival" ]; then
                                                        MAP="c2m1_highway"
                                                    elif [ "$OPTION" == "Swamp Fever" ]; then
                                                        MAP="c3m1_plankcountry"
                                                    elif [ "$OPTION" == "Hard Rain" ]; then
                                                        MAP="c4m1_milltown_a"
                                                    elif [ "$OPTION" == "The Parish" ]; then
                                                        MAP="c5m1_waterfront"
                                                    elif [ "$OPTION" == "The Passing" ]; then
                                                        MAP="c6m1_riverbank"
                                                    elif [ "$OPTION" == "The Sacrifice" ]; then
                                                        MAP="c7m1_docks"
                                                    elif [ "$OPTION" == "No Mercy" ]; then
                                                        MAP="c8m1_apartment"
                                                    elif [ "$OPTION" == "Death Toll" ]; then
                                                        MAP="c10m1_caves"
                                                    elif [ "$OPTION" == "Dead Air" ]; then
                                                        MAP="c11m1_greenhouse"
                                                    elif [ "$OPTION" == "Blood Harvest" ]; then
                                                        MAP="C12m1_hilltop"
                                                    elif [ "$OPTION" == "Cold Stream" ]; then
                                                        MAP="c13m1_alpinecreek"
                                                    elif [ "$OPTION" == "Crash Course" ]; then
                                                        MAP="c9m1_alleys"
                                                    fi

                                                    readarray -t L4D2_PORTS < <(seq 27015 1 27035)
                                                    select PORT in ${L4D2_PORTS[@]}; do
                                                        break
                                                    done

                                                    GAME="L4D2"
                                                    PORT=$PORT
                                                    MAP=$MAP
                                                    CLIENTPORT=$((PORT + 90))
                                                    INSTALL_DIR="/home/servers/servers/left4dead2"
                                                    GS_DIR=$INSTALL_DIR/$PORT
                                                    MASTER_DIR="/home/servers/master/left4dead2"
                                                    GAMETYPE="left4dead2"
                                                    return 0
                                                    ##  Run the gameserver creation function
                                                    createGS
                                                    ;;
                                                2) # Left 4 Dead Install menu
                                                    echo "\nYou picked Left 4 Dead Install menu"
                                                    #break #  Breaks out of the select, back to the mango loop.
                                                    OPTIONS=("Dead Air" "Blood Harvest" "Crash Course" "No Mercy" "Death Toll" "Quit")
                                                    select OPTION in "${OPTIONS[@]}"; do
                                                        case "$REPLY" in
                                                        1 | 2 | 3 | 4 | 5) break ;;
                                                        6) errorAndQuit ;;
                                                        *) errorAndContinue ;;
                                                        esac
                                                    done

                                                    ## Set the MAP Variable
                                                    if [ "$OPTION" == "Dead Air" ]; then
                                                        MAP="l4d_airport01_greenhouse"
                                                    elif [ "$OPTION" == "Blood Harvest" ]; then
                                                        MAP="l4d_farm01_hilltop"
                                                    elif [ "$OPTION" == "Crash Course" ]; then
                                                        MAP="l4d_garage01_alleys"
                                                    elif [ "$OPTION" == "No Mercy" ]; then
                                                        MAP="l4d_hospital01_apartment"
                                                    elif [ "$OPTION" == "Death Toll" ]; then
                                                        MAP="l4d_smalltown01_caves"
                                                    fi

                                                    ## Select a port
                                                    readarray -t L4D_PORTS < <(seq 28015 1 28035)
                                                    select PORTS in ${L4D_PORTS[@]}; do
                                                        break
                                                    done

                                                    ## We really should check that this port/folder is not in use
                                                    ## For now, that will be checked in the createGS function

                                                    ## Set L4D related variables

                                                    GAME="L4D"
                                                    PORT=$PORT
                                                    MAP=$MAP
                                                    CLIENTPORT=$((PORT + 90))
                                                    INSTALL_DIR="/home/servers/servers/left4dead"
                                                    GS_DIR=$INSTALL_DIR/$PORT
                                                    MASTER_DIR="/home/servers/master/left4dead2"
                                                    GAMETYPE="left4dead"
                                                    ##  Run the gameserver creation function
                                                    createGS
                                                    ;;
                                                3) # Killing Floor 2 Install Menu
                                                    echo "\nYou picked KF2 Install menu"
                                                    break # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                                    ;;
                                                4)          # exit
                                                    break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                                    ;;
                                                *) # always allow for the unexpected
                                                    echo "\nUnknown mango operation [${REPLY}]"
                                                    break
                                                    ;;
                                                esac
                                            done
                                        done
                                        break
                                        ;;
                                    2) #  Gameeserver Update Menu
                                        echo "\nYou picked Gameserver Update menu"
                                        break #  Breaks out of the select, back to the mango loop.
                                        ;;
                                    3) # Gameserver Remove Menu
                                        echo "\nYou picked Gameserver Remove menu"
                                        break # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                        ;;
                                    4)          # exit
                                        break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                        ;;
                                    *) # always allow for the unexpected
                                        echo "\nUnknown mango operation [${REPLY}]"
                                        break
                                        ;;
                                    esac
                                done
                            done
                            break
                            ;;
                        3) # Maps
                            while :; do
                                printf "\nMaps Sub-menu\n"
                                echo ""
                                PS3=$MANGOPROMPT
                                select option in Install Update Remove Exit; do
                                    case $REPLY in
                                    1) # install Maps
                                        echo "\nYou picked Install Maps menu"
                                        break #  Breaks out of the select, back to the mango loop.
                                        ;;
                                    2) # Update Maps
                                        echo "\nYou picked Update Maps menu"
                                        break #  Breaks out of the select, back to the mango loop.
                                        ;;
                                    3) # Delete Maps
                                        echo "\nYou picked Delete Maps menu"
                                        break # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                        ;;
                                    4)          # exit
                                        break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                                        ;;
                                    *) # always allow for the unexpected
                                        echo "\nUnknown mango operation [${REPLY}]"
                                        break
                                        ;;
                                    esac
                                done
                            done
                            break
                            ;;
                        4) # Mods
                            echo "\nYou picked Mods Menu"
                            break # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                            ;;
                        5)          # exit
                            break 2 # Breaks out 2 levels, the select loop plus the mango while loop, back to the main loop.
                            ;;
                        *) # always allow for the unexpected
                            echo "\nUnknown mango operation [${REPLY}]"
                            break
                            ;;
                        esac
                    done
                done
                break
                #     ;;
                # 2) # Update
                #     echo "You picked Update"
                #     #;&  # Fall through to #3
                #     break
                #     ;;
                # 3) # Remove
                #     echo "You picked Remove"
                #     break
                #     ;;
                # 4)          # exit
                #     break 2 #  Break out 2 levels, out of the select and the main loop.
                #     ;;
                # *) # Always code for the unexpected.
                #     echo "\nUnknown option [${REPLY}]"
                #     break
                ;;
            esac
        done
    done

}

function createGS() {
    #    echo $GAME
    #    echo $PORT
    #    echo $MAP
    #    echo $CLIENTPORT

    ## Check whether the folder exists
    if [ -d "$GS_DIR" ]; then
        if [ -L "$GS_DIR" ]; then
            # It is a symlink!
            # Symbolic link specific commands go here.
            echo "Symlinked directory exists !! ... Removing!"
            rm -R "$GS_DIR"
        else
            # It's a directory!
            # Directory command goes here.
            echo "Directory Exists"
            rm -R "$GS_DIR"
            mkdir -p "$GS_DIR"
        fi
    fi

    echo "We are about to create a gameserver for: $GAME"
    echo "Server will be running on port: $PORT"
    echo "Server will be running on Clientport: $CLIENTPORT"
    echo "Server will be running map: $MAP"

    #INSTALL_DIR="/home/servers/servers/left4dead"
    #GS_DIR=$GS_DIR
    #MASTER_DIR="/home/servers/master/left4dead2"

    cp -rsa $MASTER_DIR/* "$GS_DIR"
    unlink "$GS_DIR"/srcds_run
    unlink "$GS_DIR"/control.sh
    unlink "$GS_DIR"/$GAMETYPE/host.txt
    unlink "$GS_DIR"/$GAMETYPE/modelsounds.cache
    unlink "$GS_DIR"/$GAMETYPE/motd.txt
    unlink "$GS_DIR"/$GAMETYPE/scene.cache
    if [ $GAME = "L4D2" ]; then
        unlink "$GS_DIR"/$GAMETYPE/cfg/addonconfig.cfg
    fi
    unlink "$GS_DIR"/$GAMETYPE/cfg/server.cfg
    unlink "$GS_DIR"/$GAMETYPE/cfg/autoexec.cfg
    cp $MASTER_DIR/srcds_run "$GS_DIR"
    cp $MASTER_DIR/control.sh "$GS_DIR"
    cp $MASTER_DIR/$GAMETYPE/host.txt "$GS_DIR"/$GAMETYPE
    cp $MASTER_DIR/$GAMETYPE/modelsounds.cache "$GS_DIR"/$GAMETYPE
    cp $MASTER_DIR/$GAMETYPE/motd.txt "$GS_DIR"/$GAMETYPE
    cp $MASTER_DIR/$GAMETYPE/scene.cache "$GS_DIR"/$GAMETYPE
    if [ $GAME = "L4D2" ]; then
        cp $MASTER_DIR/$GAMETYPE/cfg/addonconfig.cfg "$GS_DIR"/$GAMETYPE/cfg
    fi
    cp $MASTER_DIR/$GAMETYPE/cfg/server.cfg "$GS_DIR"/$GAMETYPE/cfg
    cp $MASTER_DIR/$GAMETYPE/cfg/autoexec.cfg "$GS_DIR"/$GAMETYPE/cfg
    exit 0
}

function masterServer() {

    ## First let's just check that steamcmd is installed
    #STEAMCMD="/home/servers/steamcmd/steamcmd.sh"
    #STEAMCMD_DIR="/home/servers/steamcmd"
    #STEAMCMD_DL=$(wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz)
    if [ -f "$STEAMCMD" ]; then
        echo "SteamCMD in installed"
    else
        ## SteamCMD isn't installed so lets install it and update it
        if [ ! -d "$STEAMCMD_DIR" ]; then
            mkdir -p /home/servers/steamcmd
            #cd "${STEAMCMD_DIR}" || exit
            #curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" tar zxvf -
            #echo $(pwd)
            echo "$STEAMCMD_DIR"

            #cd "/home/servers/steamcmd"
            cd "$STEAMCMD_DIR" || exit
            echo "$STEAMCMD_DIR"
            #$STEAMCMD_DL
            #curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" #| tar zxvf -
            #$STEAMCMD_DL

            # $STEAMCMD_D
            #./steamcmd.sh
            #$STEAMCMD
        fi
    fi
    ## Download the relevant server files
    #$STEAMCMD +login anonymous +force_install_dir $MASTER_DIR +app_update $APPID validate +quit
    #chown -R servers:servers $MASTER_DIR
}

#getTask
#testEcho
msTasks
#createGS
#echo $INSTALL_TYPE
