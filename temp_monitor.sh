#!/bin/bash

TEMP_MIN=45
TEMP_LV1=50
TEMP_LV2=60
FAN_STATE=0
DELAY=30

get_temp () { echo -n $(cat /proc/i8k |cut -d' ' -f 4 |tr -d '\n' |tr -d ' ') ;}

set_fan () { sudo i8kfan - $1 2>&1 > /dev/null; FAN_STATE=$1;}

CALL_LOG () {
    echo $*
}

while true;do 
    
    if [ $(get_temp) -gt $TEMP_MIN ] && [ $(get_temp) -lt $TEMP_LV1 ];then
        if [ ! $FAN_STATE ] ;then 
            CALL_LOG  "Set fan 1 - Temperature $(get_temp) "
            set_fan 1; 
        fi

    elif [ $(get_temp) -gt $TEMP_LV1 ] && [ $(get_temp) -lt $TEMP_LV2 ];then
        CALL_LOG "Set fan 1 - Temperature $(get_temp) "
        set_fan 1 

    elif [ $(get_temp) -gt $TEMP_LV2 ];then
        CALL_LOG "Set fan 2 - Temperature $(get_temp) "
        set_fan 2 

    elif [ $(get_temp) -lt $TEMP_MIN ];then
        CALL_LOG "Set fan 0 - Temperature $(get_temp) "
        set_fan 0 

    elif [ $(get_temp) == "" ];then  
        CALL_LOG "Temperature not detected. "
        exit 1 

    else 
        CALL_LOG "Set fan $FAN_STATE - Temperature $(get_temp) "

    fi
    sleep $DELAY;

done 
