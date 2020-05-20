#!/bin/bash
## Debugging
#set -x
#set -v

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

## Declare some variables
IP=51.159.22.125
#PORT=29000
L4D_START_PORT=28015
L4D_END_PORT=28035
L4D2_START_PORT=27015
L4D2_END_PORT=27035

OPTIONS=("Install Gameserver" "Update Gameserver" "Remove Gameserver" "Install/Update Maps" "Install/Update Mods" "Quit")
select OPTION in "${OPTIONS[@]}"; do
    case "$REPLY" in
    1 | 2 | 3 | 4 | 5) break ;;
    6) errorAndQuit ;;
    *) errorAndContinue ;;
    esac
done

if [ "$OPTION" == "Install Gameserver" ]; then
    INSTALL="INSTALL"
elif [ "$OPTION" == "Update Gameserver" ]; then
    INSTALL="UPDATE"
elif [ "$OPTION" == "Remove Gameserver" ]; then
    INSTALL="REMOVE"
elif [ "$OPTION" == "Install/Update Maps" ]; then
    INSTALL="MODS"
elif [ "$OPTION" == "Install/Update Mods" ]; then
    INSTALL="MAPS"
fi

#echo $INSTALL

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

if [ $INSTALL = "INSTALL" ] && [ $GAME = "L4D2" ]; then

    OPTIONS=("Dead Center" "Dark Carnival" "Swamp Fever" "Hard Rain" "The Parish" "The Passing" "The Sacrifice" "No Mercy" "Death Toll" "Dead Air" "Blood Harvest" "Cold Stream" "Crash Course" "Quit")
    select OPTION in "${OPTIONS[@]}"; do
        case "$REPLY" in
        1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13) break ;;
        14) errorAndQuit ;;
        *) errorAndContinue ;;
        esac
    done

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
elif
    [ $INSTALL = "INSTALL" ] && [ $GAME = "L4D" ]
then

    OPTIONS=("Dead Air" "Blood Harvest" "Crash Course" "No Mercy" "Death Toll" "Quit")
    select OPTION in "${OPTIONS[@]}"; do
        case "$REPLY" in
        1 | 2 | 3 | 4 | 5) break ;;
        6) errorAndQuit ;;
        *) errorAndContinue ;;
        esac
    done

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
fi



if [ $INSTALL = "INSTALL" ]; then
    if [ $GAME = "L4D2" ]; then

        readarray -t L4D2_PORTS < <(seq 27015 1 27035)
        select PORT in ${L4D2_PORTS[@]}; do
        echo " Variable is right afteer this"
        echo $PORT
        #export $PORT
        echo "Yes i am right heer"
            break
        done
CLIENTPORT=$((PORT+90))
echo CLIENTPORT
        ## Create the L4D2 server

        ## Create the server folder if it doesn't already exist

        if [ ! -d $INSTALL_DIR/$PORT ]; then
            mkdir -p $INSTALL_DIR/$PORT
        fi

        # cp -rsa $MASTER_DIR/* $INSTALL_DIR/$PORT
        # unlink $INSTALL_DIR/$PORT/srcds_run
        # unlink $INSTALL_DIR/$PORT/control.sh
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/host.txt
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/modelsounds.cache
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/motd.txt
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/scene.cache
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/cfg/addonconfig.cfg
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/cfg/server.cfg
        # unlink $INSTALL_DIR/$PORT/$GAMETYPE/cfg/autoexec.cfg
        # cp $MASTER_DIR/srcds_run $INSTALL_DIR/$PORT
        # cp $MASTER_DIR/control.sh $INSTALL_DIR/$PORT
        # cp $MASTER_DIR/$GAMETYPE/host.txt $INSTALL_DIR/$PORT/$GAMETYPE
        # cp $MASTER_DIR/$GAMETYPE/modelsounds.cache $INSTALL_DIR/$PORT/$GAMETYPE
        # cp $MASTER_DIR/$GAMETYPE/motd.txt $INSTALL_DIR/$PORT/$GAMETYPE
        # cp $MASTER_DIR/$GAMETYPE/scene.cache $INSTALL_DIR/$PORT/$GAMETYPE
        # cp $MASTER_DIR/$GAMETYPE/cfg/addonconfig.cfg $INSTALL_DIR/$PORT/$GAMETYPE/cfg
        # cp $MASTER_DIR/$GAMETYPE/cfg/server.cfg $INSTALL_DIR/$PORT/$GAMETYPE/cfg
        # cp $MASTER_DIR/$GAMETYPE/cfg/autoexec.cfg $INSTALL_DIR/$PORT/$GAMETYPE/cfg

        # ## Now we will use SED to configure control.sh and srcds_run

        # sed -i '/export LD_LIBRARY_PATH=".:bin:$LD_LIBRARY_PATH"/c\export LD_LIBRARY_PATH='"$INSTALL_DIR"'/'"$PORT"':'"$INSTALL_DIR"'/'"$PORT"'/bin.:bin:$LD_LIBRARY_PATH"' $INSTALL_DIR/$PORT/srcds_run
        
        # sed -i '/PARAMS="-game left4dead2 +ip $IP -port $PORT +clientport $CLIENTPORT +map $MAP -nohltv -strictportbind -debug -condebug -console"/c\PARAMS="-game left4dead2 +ip '"$IP"' -port '"$PORT"' +clientport '"$CLIENTPORT"' +map '"$MAP"' -nohltv -strictportbind -debug -condebug -console"' $INSTALL_DIR/$PORT/control.sh
    
    elif [ $GAME = "L4D" ]; then

        readarray -t L4D_PORTS < <(seq 28015 1 28035)
        select PORTS in ${L4D_PORTS[@]}; do
        
            break
        done
        echo $CLIENTPORT
        ## Create the server folder if it doesn't already exist
        if [ ! -d $INSTALL_DIR/$PORT ]; then
            mkdir -p $INSTALL_DIR/$PORT
        fi

        ## Create the L4D server
        cp -rsa $MASTER_DIR/* $INSTALL_DIR/$PORT
        unlink $INSTALL_DIR/$PORT/srcds_run
        unlink $INSTALL_DIR/$PORT/control.sh
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/host.txt
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/modelsounds.cache
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/motd.txt
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/scene.cache
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/cfg/server.cfg
        unlink $INSTALL_DIR/$PORT/$GAMETYPE/cfg/autoexec.cfg
        cp $MASTER_DIR/srcds_run $INSTALL_DIR/$PORT
        cp $MASTER_DIR/control.sh $INSTALL_DIR/$PORT
        cp $MASTER_DIR/$GAMETYPE/host.txt $INSTALL_DIR/$PORT/$GAMETYPE
        cp $MASTER_DIR/$GAMETYPE/modelsounds.cache $INSTALL_DIR/$PORT/$GAMETYPE
        cp $MASTER_DIR/$GAMETYPE/motd.txt $INSTALL_DIR/$PORT/$GAMETYPE
        cp $MASTER_DIR/$GAMETYPE/scene.cache $INSTALL_DIR/$PORT/$GAMETYPE
        cp $MASTER_DIR/$GAMETYPE/cfg/server.cfg $INSTALL_DIR/$PORT/$GAMETYPE/cfg
        cp $MASTER_DIR/$GAMETYPE/cfg/autoexec.cfg $INSTALL_DIR/$PORT/$GAMETYPE/cfg
    fi
fi

## Update a server if required

if [ $INSTALL = "UPDATE" ]; then
    if [ $GAME = "L4D2" ]; then

        ## First lets check for existing servers and then ask the user which one(s) they want to update

        folders=$(ls -A $INSTALL_DIR | sed 's:/*$::')
        PS3="Which server(s) would you like to update?: "
        select filename in ${folders} "All" "Quit"; do
            echo "${file}"
            break
        done

        if [ $filename = "Quit" ]; then
            exit 0
        elif [ $filename = "All" ]; then
            ## User wants to update all L4D2 servers
            exit 0
        fi

        ## Check that the gameeserver actually exists!!
        if [ ! -d $INSTALL_DIR/$filename ]; then
            echo "Server does not exist!!"
            exit 0
        fi

        ## Update the server files
        cp -rsau $MASTER_DIR/* $INSTALL_DIR/$filename
    
    elif [ $GAME = "L4D" ]; then

        ## First lets check for existing servers and then ask the user which one(s) they want to update

        folders=$(ls -A $INSTALL_DIR | sed 's:/*$::')
        PS3="Which server(s) would you like to update?: "
        select filename in ${folders} "All" "Quit"; do
            echo "${file}"
            break
        done

        if [ $filename = "Quit" ]; then
            exit 0
        elif [ $filename = "All" ]; then
            ## User wants to update all L4D servers
            exit 0
        fi
        ## Check that the gameeserver actually exists!!
        if [ ! -d $INSTALL_DIR/$filename ]; then
            echo "Server does not exist!!"
            exit 0
        fi

        ## Update the server files
        cp -rsau $MASTER_DIR/* $INSTALL_DIR/$filename
    fi
#find /home/servers/servers/left4dead2/27020 -exec du -s {} + | awk '{total = total + $1}END{print (total / 1024 / 1024) "MB"}'
fi

## Lets remove a server
if [ $INSTALL = "REMOVE" ]; then
    if [ $GAME = "L4D2" ]; then
        ## First lets check for existing servers and then ask the user which one(s) they want to update

        folders=$(ls -A $INSTALL_DIR | sed 's:/*$::')
        PS3="Which server(s) would you like to remove?: "
        select filename in ${folders} "All" "Quit"; do
            echo "${file}"
            break
        done

        if [ $filename = "Quit" ]; then
            exit 0
        elif [ $filename = "All" ]; then
            ## User wants to remove all L4D2 servers
            exit 0
        fi

        ## Check that the gameeserver actually exists!!
        if [ ! -d $INSTALL_DIR/$filename ]; then
            echo "Server does not exist!!"
            exit 0
        fi
        ## Delete the server
        rm -R $INSTALL_DIR/$filename
    
    elif [ $GAME = "L4D" ]; then
        ## First lets check for existing servers and then ask the user which one(s) they want to update

        folders=$(ls -A $INSTALL_DIR | sed 's:/*$::')
        PS3="Which server(s) would you like to remove?: "
        select filename in ${folders} "All" "Quit"; do
            echo "${file}"
            break
        done

        if [ $filename = "Quit" ]; then
            exit 0
        elif [ $filename = "All" ]; then
            ## User wants to remove all L4D2 servers
            exit 0
        fi

        ## Check that the gameeserver actually exists!!
        if [ ! -d $INSTALL_DIR/$filename ]; then
            echo "Server does not exist!!"
            exit 0
        fi
        ## Delete the server
        rm -R $INSTALL_DIR/$filename
    fi
fi

echo $IP
 echo $PORT
 echo $CLIENTPORT
 echo $INSTALL
 echo $GAME
 echo $MAP
 echo $MASTER_DIR
 echo $INSTALL_DIR
