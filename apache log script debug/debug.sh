#!/usr/bin/env bash
LOG_FILE="$1"

function request_per_day() {
    declare -A day_array
    while read line; do
        day=$(echo "$line" | sed 's/.*\[//g;s/].*//g;s/:.*//g')
        if [[ -v day_array[$day] ]]; then
            day_array[$day]=$((day_array[$day]+1))
        else
            day_array[$day]=1
        fi
    done < $LOG_FILE

    for day in ${!day_array[@]}; do echo ${day_array[$day]} $day; done | sort -rn | head -10
}

function request_per_ip() {
    declare -A ip_array
    while read line; do
        ip=$(echo $line | awk '{print $1}')
        if [[ -v ip_array[$ip] ]]; then
            ip_array[$ip]=$((ip_array[$ip]+1))
        else
            ip_array[$ip]=1
        fi
    done < $LOG_FILE

    for ip in ${!ip_array[@]}; do echo ${ip_array[$ip]} $ip; done | sort -rn | head -10
}
function request_ru() {
    declare -A ru_array
    while read line; do
        site=$(echo $line | awk '{print $15}')
        if [[ -v ru_array[$site] ]]; then
            ru_array[$site]=$((ru_array[$site]+1))
        else
            ru_array[$site]=1
        fi
    done < $LOG_FILE

    for site in ${!ru_array[@]}; do echo ${ru_array[$site]} $site; done | sort -rn | >
}


request_per_day
echo ""
request_per_ip
request_ru