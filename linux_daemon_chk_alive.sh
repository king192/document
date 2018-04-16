list_port="9000 80 22"
res_list=()

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
    if [ ${res_list[${k}]} = 0 ];then
        echo 'your service is not running'
        
    fi
done
