#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "You must be the superuser to run this script" >&2
    exit 1
fi

function gsTasks() {
    #    echo $GAME
    #    echo $PORT
    #    echo $MAP
    #    echo $CLIENTPORT

    if [ "$TASK" = "INSTALLGS" ]; then
        ## Check whether the folder exists
        if [ -d "$GS_DIR" ]; then

            echo "Directory Exists"
            rm -R "$GS_DIR"
            mkdir -p "$GS_DIR"
        fi

        echo "We are about to create a gameserver for: $GAME"
        echo "Server will be running on port: $PORT"
        echo "Server will be running on Clientport: $CLIENTPORT"
        echo "Server will be running map: $MAP"

        if [ "$GAME" == "L4D" ] || [ "$GAME" == "L4D2" ]; then
            cp -rsa "$MS_DIR"/* "$GS_DIR"
            unlink "$GS_DIR"/srcds_run
            unlink "$GS_DIR"/control.sh
            unlink "$GS_DIR"/"$GAMETYPE"/host.txt
            unlink "$GS_DIR"/"$GAMETYPE"/modelsounds.cache
            unlink "$GS_DIR"/"$GAMETYPE"/motd.txt
            unlink "$GS_DIR"/"$GAMETYPE"/scene.cache
            if [ "$GAME" = "L4D2" ]; then
                unlink "$GS_DIR"/"$GAMETYPE"/cfg/addonconfig.cfg
            fi
            unlink "$GS_DIR"/"$GAMETYPE"/cfg/server.cfg
            unlink "$GS_DIR"/"$GAMETYPE"/cfg/autoexec.cfg
            cp "$MS_DIR"/srcds_run "$GS_DIR"
            cp "$MS_DIR"/control.sh "$GS_DIR"
            cp "$MS_DIR"/"$GAMETYPE"/host.txt "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/modelsounds.cache "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/motd.txt "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/scene.cache "$GS_DIR"/"$GAMETYPE"
            if [ "$GAME" = "L4D2" ]; then
                cp "$MS_DIR"/"$GAMETYPE"/cfg/addonconfig.cfg "$GS_DIR"/"$GAMETYPE"/cfg
            fi
            cp "$MS_DIR"/"$GAMETYPE"/cfg/server.cfg "$GS_DIR"/"$GAMETYPE"/cfg
            cp "$MS_DIR"/"$GAMETYPE"/cfg/autoexec.cfg "$GS_DIR"/"$GAMETYPE"/cfg
        fi
    elif [ "$TASK" = "UPDATEGS" ]; then
        ## Check whether the folder exists
        if [ -d "$GS_DIR" ]; then

            echo "Directory Exists"
            rm -R "$GS_DIR"
            mkdir -p "$GS_DIR"
        fi

        echo "We are about to create a gameserver for: $GAME"
        echo "Server will be running on port: $PORT"
        echo "Server will be running on Clientport: $CLIENTPORT"
        echo "Server will be running map: $MAP"

        if [ "$GAME" == "L4D" ] || [ "$GAME" == "L4D2" ]; then
            cp -rsau "$MS_DIR"/* "$GS_DIR"
            unlink "$GS_DIR"/srcds_run
            unlink "$GS_DIR"/control.sh
            unlink "$GS_DIR"/"$GAMETYPE"/host.txt
            unlink "$GS_DIR"/"$GAMETYPE"/modelsounds.cache
            unlink "$GS_DIR"/"$GAMETYPE"/motd.txt
            unlink "$GS_DIR"/"$GAMETYPE"/scene.cache
            if [ "$GAME" = "L4D2" ]; then
                unlink "$GS_DIR"/"$GAMETYPE"/cfg/addonconfig.cfg
            fi
            unlink "$GS_DIR"/"$GAMETYPE"/cfg/server.cfg
            unlink "$GS_DIR"/"$GAMETYPE"/cfg/autoexec.cfg
            cp "$MS_DIR"/srcds_run "$GS_DIR"
            cp "$MS_DIR"/control.sh "$GS_DIR"
            cp "$MS_DIR"/"$GAMETYPE"/host.txt "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/modelsounds.cache "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/motd.txt "$GS_DIR"/"$GAMETYPE"
            cp "$MS_DIR"/"$GAMETYPE"/scene.cache "$GS_DIR"/"$GAMETYPE"
            if [ "$GAME" = "L4D2" ]; then
                cp "$MS_DIR"/"$GAMETYPE"/cfg/addonconfig.cfg "$GS_DIR"/"$GAMETYPE"/cfg
            fi
            cp "$MS_DIR"/"$GAMETYPE"/cfg/server.cfg "$GS_DIR"/"$GAMETYPE"/cfg
            cp "$MS_DIR"/"$GAMETYPE"/cfg/autoexec.cfg "$GS_DIR"/"$GAMETYPE"/cfg

            ## Now we will use SED to configure control.sh and srcds_run
            sed -i '/export LD_LIBRARY_PATH=".:bin:$LD_LIBRARY_PATH"/c\export LD_LIBRARY_PATH='"$GS_DIR"':'"$GS_DIR"'/bin.:bin:$LD_LIBRARY_PATH"' $GS_DIR/srcds_run
            #sed -i '/PARAMS="-game left4dead2 +ip $IP -port $PORT +clientport $CLIENTPORT +map $MAP -nohltv -strictportbind -debug -condebug -console"/c\PARAMS="-game left4dead2 +ip '"$IP"' -port '"$PORT"' +clientport '"$CLIENTPORT"' +map '"$MAP"' -nohltv -strictportbind -debug -condebug -console"' $INSTALL_DIR/$PORT/control.sh
            sed -i '/DIR=/home/servers/servers/left4dead2/$PORT/c\DIR=/home/servers/servers/left4dead2/'"$PORT"'' $GS_DIR/control.sh
            sed 's/PORT=/PORT='"$PORT"'/' $GS_DIR/control.sh
            sed 's/CLIENTPORT=/CLIENTPORT='"$CLIENTPORT"'/' $GS_DIR/control.sh
            sed 's/MAP=/MAP='"$MAP"'/' $GS_DIR/control.sh
            sed 's/NAME=/NAME=L4D2_'"$PORT"'/' $GS_DIR/control.sh
        fi
        exit 0

    fi

}

function masterServer() {

    ## First let's just check that steamcmd is installed
    STEAMCMD="/home/servers/steamcmd/steamcmd.sh"
    STEAMCMDDIR="/home/servers/steamcmd"
    if [ -f "$STEAMCMD" ]; then
        echo "SteamCMD in installed"
    fi

    ## If SteamCMD doesn't exist, create the folder, change to it and download SteamCMD
    if [ ! -d "/home/servers/steamcmd" ]; then
        mkdir "/home/servers/steamcmd"
        cd "/home/servers/steamcmd" || exit
        curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
        ./steamcmd.sh +quit
        quit
    fi

    echo "$APPID"
    echo "$MS_DIR"
    echo "$TASK"
    ## Install/update the relevant masterserver directory
    if [ "$TASK" = "INSTALLMS" ] || [ "$TASK" = "UPDATEMS" ]; then
        $STEAMCMD +login anonymous +force_install_dir "$MS_DIR" +app_update "$APPID" validate +quit
        chown -R servers:servers "$MS_DIR"
    fi

    ## Remove the relevant masterserver directory
    if [ "$TASK" = "REMOVEMS" ]; then

        rm -R "$MS_DIR"
    fi
}

function getTask() {
    ## First lets find out what the user wants to do
    OPTIONS=("Install" "Update" "Remove" "Quit")
    select OPTION in "${OPTIONS[@]}"; do
        case "$REPLY" in
        1 | 2 | 3) break ;;
        4) errorAndQuit ;;
        *) errorAndContinue ;;
        esac
    done

    ###**********************************************###
    ###******** THIS IS THE INSTALL SECTION *********###
    ## lets find out what the user wants to install
    if [ "$OPTION" == "Install" ]; then
        ACTION="INSTALL"
        OPTIONS=("Gameserver" "Masterserver" "Mods" "Maps" "Quit")
        select OPTION in "${OPTIONS[@]}"; do
            case "$REPLY" in
            1 | 2 | 3 | 4) break ;;
            5) errorAndQuit ;;
            *) errorAndContinue ;;
            esac
        done
        if [ "$OPTION" == "Gameserver" ]; then
            SUB_TASK="GS"
        elif [ "$OPTION" == "Masterserver" ]; then
            SUB_TASK="MS"
        elif [ "$OPTION" == "Mods" ]; then
            SUB_TASK="MODS"
        elif [ "$OPTION" == "Maps" ]; then
            SUB_TASK="MODS"
        fi
        TASK=$ACTION$SUB_TASK

        if [ $SUB_TASK == "MS" ]; then
            ## If user wants to install a master server
            ## lets find out which masterserver to install
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                GAME="L4D2"
                MS_DIR="/home/servers/master/left4dead2"
                APPID="222860"
            elif [ "$OPTION" == "Left 4 Dead" ]; then
                GAME="L4D"
                MS_DIR="/home/servers/master/left4dead"
                APPID="222840"
            elif [ "$OPTION" == "Killing Floor 2" ]; then
                GAME="KF2"
                MS_DIR="/home/servers/master/kf2"
                APPID="232130"
            fi

        elif [ $SUB_TASK == "GS" ]; then
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            echo ""
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                ## Lets see if theres are any L4D2 servers installed already
                #GS_DIR="/home/servers/servers/left4dead2/$FOLDER"
                INSTALL_DIR="/home/servers/servers/left4dead2"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Choose a port?: "
                if [ "$FOLDER" == "" ] || [ "$FOLDERS" == "" ]; then
                    
                    readarray -t L4D2_PORTS < <(seq 27015 1 27035)
                        select PORT in "${L4D2_PORTS[@]}"; do
                            break
                        done
                
                elif [ "$FOLDER" != "" ] || [ "$FOLDERS" != "" ]; then
                    echo " It appears you already have servers installed"
                        select FOLDER in ${FOLDERS} "All" "Quit"; do
                        #echo "${FOLDER}"
                        #echo $FOLDERS
                        break
                    done
                fi

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

                GAME="L4D2"
                PORT=$PORT
                MAP=$MAP
                CLIENTPORT=$((PORT + 90))
                MS_DIR="/home/servers/master/left4dead2"
                GAMETYPE="left4dead2"
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"

            elif [ "$OPTION" == "Left 4 Dead" ]; then
                ## Lets see if theres are any L4D2 servers installed already
                GS_DIR="/home/servers/servers/left4dead/$FOLDER"
                INSTALL_DIR="/home/servers/servers/left4dead"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Which server(s) would you like to Remove?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done

                if [ "$FOLDER" != "" ] || [ "$FOLDERS" != "" ]; then
                    echo " It appears you already have servers installed"
                else
                    readarray -t L4D_PORTS < <(seq 28015 1 28035)
                    select PORT in "${L4D_PORTS[@]}"; do
                        break
                    done
                fi

                GAME="L4D"
                PORT=$PORT
                MAP=$MAP
                CLIENTPORT=$((PORT + 90))
                INSTALL_DIR="/home/servers/servers/left4dead"

                MS_DIR="/home/servers/master/left4dead"
                GAMETYPE="left4dead"
                GS_DIR="/home/servers/servers/left4dead/$FOLDER"

            elif [ "$OPTION" == "Killing Floor 2" ]; then
                ## Lets see if theres are any KF2 servers installed already
                GS_DIR="/home/servers/servers/kf2/$FOLDER"
                INSTALL_DIR="/home/servers/servers/kf2"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Which server(s) would you like to Remove?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done
                GAME="KF2"
                MS_DIR="/home/servers/master/kf2"
                GS_DIR="/home/servers/servers/kf2/$FOLDER"
            fi
        fi
    fi

    ## Fire up the gameserver function
    if [ $SUB_TASK == "GS" ] && [ $TASK = "INSTALLGS" ] || [ $TASK = "UPDATEGS" ] || [ $TASK = "REMOVEGS" ]; then
        gsTasks $PORT $CLIENTPORT $MAP $GAME $MS_DIR $GS_DIR $GAMETYPE
    fi

    ## Fire up the masterserver function
    if [ $SUB_TASK == "MS" ] && [ $TASK = "INSTALLMS" ] || [ $TASK = "UPDATEMS" ] || [ $TASK = "REMOVEMS" ]; then
        masterServer $MS_DIR $APPID $GAME
    fi

    ###**********************************************###
    ###******** THIS IS THE UPDATE SECTION *********###
    ## lets find out what the user wants to update
    if [ "$OPTION" == "Update" ]; then
        ACTION="UPDATE"
        OPTIONS=("Gameserver" "Masterserver" "Mods" "Maps" "Quit")
        select OPTION in "${OPTIONS[@]}"; do
            case "$REPLY" in
            1 | 2 | 3 | 4) break ;;
            5) errorAndQuit ;;
            *) errorAndContinue ;;
            esac
        done
        if [ "$OPTION" == "Gameserver" ]; then
            SUB_TASK="GS"
        elif [ "$OPTION" == "Masterserver" ]; then
            SUB_TASK="MS"
        elif [ "$OPTION" == "Mods" ]; then
            SUB_TASK="MODS"
        elif [ "$OPTION" == "Maps" ]; then
            SUB_TASK="MODS"
        fi
        TASK=$ACTION$SUB_TASK

        if [ $SUB_TASK == "MS" ]; then
            ## If user wants to update a master server
            ## lets find out which masterserver to update
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                GAME="L4D2"
                MS_DIR="/home/servers/master/left4dead2"
                APPID="222860"
            elif [ "$OPTION" == "Left 4 Dead" ]; then
                GAME="L4D"
                MS_DIR="/home/servers/master/left4dead"
                APPID="222840"
            elif [ "$OPTION" == "Killing Floor 2" ]; then
                GAME="KF2"
                MS_DIR="/home/servers/master/kf2"
                APPID="232130"
            fi

        elif [ $SUB_TASK == "GS" ]; then
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                ## Lets see if theres are any L4D2 servers installed already
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"
                INSTALL_DIR="/home/servers/servers/left4dead2"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Choose a port?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done

                GAME="L4D2"
                PORT=$PORT
                MAP=$MAP
                CLIENTPORT=$((PORT + 90))
                MASTER_DIR="/home/servers/master/left4dead2"
                GAMETYPE="left4dead2"
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"

            elif [ "$OPTION" == "Left 4 Dead" ]; then
                ## Lets see if theres are any L4D2 servers installed already
                GS_DIR="/home/servers/servers/left4dead/$FOLDER"
                INSTALL_DIR="/home/servers/servers/left4dead"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Which server(s) would you like to Remove?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done

                if [ "$FOLDER" != "" ] || [ "$FOLDERS" != "" ]; then
                    echo " It appears you already have servers installed"
                else
                    readarray -t L4D_PORTS < <(seq 28015 1 28035)
                    select PORT in "${L4D_PORTS[@]}"; do
                        break
                    done
                fi

                echo "$PORT"
                echo "$FOLDER"
                echo "$FOLDERS"

                GAME="L4D2"
                PORT=$PORT
                MAP=$MAP
                CLIENTPORT=$((PORT + 90))
                INSTALL_DIR="/home/servers/servers/left4dead2"

                MASTER_DIR="/home/servers/master/left4dead2"
                GAMETYPE="left4dead2"
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"

            elif [ "$OPTION" == "Killing Floor 2" ]; then
                ## Lets see if theres are any KF2 servers installed already
                GS_DIR="/home/servers/servers/kf2/$FOLDER"
                INSTALL_DIR="/home/servers/servers/kf2"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Which server(s) would you like to Remove?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done
                GAME="KF2"
                MS_DIR="/home/servers/master/kf2"
                GS_DIR="/home/servers/servers/kf2/$FOLDER"
            fi
        fi
    fi

    ###**********************************************###
    ###******** THIS IS THE REMOVE SECTION *********###
    ## lets find out what the user wants to Remove
    if [ "$OPTION" == "Remove" ]; then
        ACTION="REMOVE"
        OPTIONS=("Gameserver" "Masterserver" "Mods" "Maps" "Quit")
        select OPTION in "${OPTIONS[@]}"; do
            case "$REPLY" in
            1 | 2 | 3 | 4) break ;;
            5) errorAndQuit ;;
            *) errorAndContinue ;;
            esac
        done
        if [ "$OPTION" == "Gameserver" ]; then
            SUB_TASK="GS"
        elif [ "$OPTION" == "Masterserver" ]; then
            SUB_TASK="MS"
        elif [ "$OPTION" == "Mods" ]; then
            SUB_TASK="MODS"
        elif [ "$OPTION" == "Maps" ]; then
            SUB_TASK="MODS"
        fi
        TASK=$ACTION$SUB_TASK

        if [ $SUB_TASK == "MS" ]; then
            ## User wants to remove a master server
            ## so lets find out which masterserver to install
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                GAME="L4D2"
                MS_DIR="/home/servers/master/left4dead2"
                APPID="222860"
            elif [ "$OPTION" == "Left 4 Dead" ]; then
                GAME="L4D"
                MS_DIR="/home/servers/master/left4dead"
                APPID="222840"
            elif [ "$OPTION" == "Killing Floor 2" ]; then
                GAME="KF2"
                MS_DIR="/home/servers/master/kf2"
                APPID="232130"
                masterServer $TASK $MS_DIR $APPID $GAME
            fi

        elif [ $SUB_TASK == "GS" ]; then
            OPTIONS=("Left 4 Dead 2" "Left 4 Dead" "Killing Floor 2" "Quit")
            select OPTION in "${OPTIONS[@]}"; do
                case "$REPLY" in
                1 | 2 | 3 | 4) break ;;
                5) errorAndQuit ;;
                *) errorAndContinue ;;
                esac
            done
            if [ "$OPTION" == "Left 4 Dead 2" ]; then
                ## Lets see if theres are any L4D2 seerver installed before we try and remove them
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"
                INSTALL_DIR="/home/servers/servers/left4dead2"
                FOLDERS=$(find $INSTALL_DIR -maxdepth 1 -type d | cut -d"/" -f6-)
                PS3="Which server(s) would you like to Remove?: "
                select FOLDER in ${FOLDERS} "All" "Quit"; do
                    #echo "${FOLDER}"
                    #echo $FOLDERS
                    break
                done
                GAME="L4D2"
                MS_DIR="/home/servers/master/left4dead2"
                GS_DIR="/home/servers/servers/left4dead2/$FOLDER"
            fi
        fi
    fi
}

getTask
