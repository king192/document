#!/bin/bash

list_port="9000 80 22"
res_list=()
filename="`date "+%Y-%m-%d"`.lock"
dir="/tmp/notice/"
fullpath="${dir}${filename}"
notice_times=2
reports=0
is_notice() {
    mkdir -p ${dir}
    if [ -f "${fullpath}" ];then
        reports=`cat ${fullpath}`
        #echo "sdfsdf:${reports}"
        #echo `expr ${reports} + 10`
            if [ ${reports} -ge ${notice_times} ];then
                echo "false"
                return 0
            else
                reports=`expr ${reports} + 1`
                echo "report:${reports}"
                echo ${reports} > ${fullpath}
            fi
    else
        echo 1 > ${fullpath}
        echo "true"
        return 1 
    fi
    return 1
}
case "$1" in
    check)
        for l_p in ${list_port}
        do
            echo "p:${l_p}"
            res_list[${l_p}]='1'
        done

        echo ${!res_list[@]}

        res=`netstat -lntp|awk '{print $4}'|awk -F ':' '{print $2}'`
        #echo $res

        for port in $res
        do
            for l_p in ${list_port}
            do
                if [ ${port} = ${l_p} ];then
                    res_list[${l_p}]='0'
                fi
            done

        done

        echo ${res_list}
        echo ${res_list[@]}
        echo ${res_list[*]}

        for k in ${!res_list[@]}
        do
            echo ${res_list[${k}]}
            if [ ${res_list[${k}]} = 1 ];then
                echo "your service is not running,the server port is ${k}"
                res=`is_notice`
                echo "res:${res}"
                if [ ${res} = false ];then
                    echo 'do something to notice somebody'
                    
                fi
            fi
        done
        ;;
    reset)
        rm ${fullpath}
        ;;
    *)
        echo "Usage: $0 {check|reset}"
        exit 1
        ;;
esac
