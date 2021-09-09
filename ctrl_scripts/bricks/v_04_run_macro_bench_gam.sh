#!/bin/bash
#$1: node id
#$2: number of nodes
#$3: number of thread per blade
#$4: trace type = [tf, gc, ma, mc]
#$5: maximum step (workload specific)
#$6: controller ip address
#$7: worker ip address
#$8: controller port number
#$9: worker port number
#$10: trace type full name

if [ $# -le 9 ]; then
  echo "Error: missing arguments: $@"
fi

LOG_DIR=~/Downloads/04_macro_bench_$4
mkdir -p $LOG_DIR
echo "Run for Node: $1"
source g_set_env_gam.sh

NFS_IP="192.168.122.1"
echo $NFS_IP

# Mount logs
sudo mkdir -p /test_program_log
sudo mkdir -p /test_program_log/${4}
sudo mount ${NFS_IP}:/media/data_ssds/${10}_logs /test_program_log/${4}
sudo mkdir -p /media/data_raid0/
sudo mkdir -p /media/data_raid0/${10}_logs
sudo mount ${NFS_IP}:/media/data_raid0/${10}_logs /media/data_raid0/${10}_logs

cd ~/mind_ae_gam/lib/libcuckoo && autoreconf -fis && ./configure && make && sudo make install && cd ~/mind_ae_gam/src && make -j 8 && cd ~/mind_ae_gam/test && make -j 8

cd ${GAM_PATH}/test/
pwd
make_cmd="./gam_profile_test"
echo "Make cmd: ${make_cmd}"
if [[ $1 -eq 0 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 1 1 $5 /test_program_log/${4}/0 /test_program_log/${4}/1 /test_program_log/${4}/2 /test_program_log/${4}/3 /test_program_log/${4}/4 /test_program_log/${4}/5 /test_program_log/${4}/6 /test_program_log/${4}/7 /test_program_log/${4}/8 /test_program_log/${4}/9
  $make_cmd $2 $3 $6 $7 $8 $9 1 1 $5 /test_program_log/${4}/0 /test_program_log/${4}/1 /test_program_log/${4}/2 /test_program_log/${4}/3 /test_program_log/${4}/4 /test_program_log/${4}/5 /test_program_log/${4}/6 /test_program_log/${4}/7 /test_program_log/${4}/8 /test_program_log/${4}/9 &> result.log &
elif [[ $1 -eq 1 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/10 /media/data_raid0/${10}_logs/11 /media/data_raid0/${10}_logs/12 /media/data_raid0/${10}_logs/13 /media/data_raid0/${10}_logs/14 /media/data_raid0/${10}_logs/15 /media/data_raid0/${10}_logs/16 /media/data_raid0/${10}_logs/17 /media/data_raid0/${10}_logs/18  /media/data_raid0/${10}_logs/19
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/10 /media/data_raid0/${10}_logs/11 /media/data_raid0/${10}_logs/12 /media/data_raid0/${10}_logs/13 /media/data_raid0/${10}_logs/14 /media/data_raid0/${10}_logs/15 /media/data_raid0/${10}_logs/16 /media/data_raid0/${10}_logs/17 /media/data_raid0/${10}_logs/18  /media/data_raid0/${10}_logs/19 &> result.log &

elif [[ $1 -eq 2 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/20 /test_program_log/${4}/21 /test_program_log/${4}/22 /test_program_log/${4}/23 /test_program_log/${4}/24 /test_program_log/${4}/25 /test_program_log/${4}/26 /test_program_log/${4}/27 /test_program_log/${4}/28 /test_program_log/${4}/29
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/20 /test_program_log/${4}/21 /test_program_log/${4}/22 /test_program_log/${4}/23 /test_program_log/${4}/24 /test_program_log/${4}/25 /test_program_log/${4}/26 /test_program_log/${4}/27 /test_program_log/${4}/28 /test_program_log/${4}/29 &> result.log &

elif [[ $1 -eq 3 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/30 /media/data_raid0/${10}_logs/31 /media/data_raid0/${10}_logs/32 /media/data_raid0/${10}_logs/33 /media/data_raid0/${10}_logs/34 /media/data_raid0/${10}_logs/35 /media/data_raid0/${10}_logs/36 /media/data_raid0/${10}_logs/37 /media/data_raid0/${10}_logs/38  /media/data_raid0/${10}_logs/39
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/30 /media/data_raid0/${10}_logs/31 /media/data_raid0/${10}_logs/32 /media/data_raid0/${10}_logs/33 /media/data_raid0/${10}_logs/34 /media/data_raid0/${10}_logs/35 /media/data_raid0/${10}_logs/36 /media/data_raid0/${10}_logs/37 /media/data_raid0/${10}_logs/38  /media/data_raid0/${10}_logs/39

elif [[ $1 -eq 4 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/40 /test_program_log/${4}/41 /test_program_log/${4}/42 /test_program_log/${4}/43 /test_program_log/${4}/44 /test_program_log/${4}/45 /test_program_log/${4}/46 /test_program_log/${4}/47 /test_program_log/${4}/48 /test_program_log/${4}/49
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/40 /test_program_log/${4}/41 /test_program_log/${4}/42 /test_program_log/${4}/43 /test_program_log/${4}/44 /test_program_log/${4}/45 /test_program_log/${4}/46 /test_program_log/${4}/47 /test_program_log/${4}/48 /test_program_log/${4}/49 &> result.log &

elif [[ $1 -eq 5 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/50 /media/data_raid0/${10}_logs/51 /media/data_raid0/${10}_logs/52 /media/data_raid0/${10}_logs/53 /media/data_raid0/${10}_logs/54 /media/data_raid0/${10}_logs/55 /media/data_raid0/${10}_logs/56 /media/data_raid0/${10}_logs/57 /media/data_raid0/${10}_logs/58  /media/data_raid0/${10}_logs/59
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/50 /media/data_raid0/${10}_logs/51 /media/data_raid0/${10}_logs/52 /media/data_raid0/${10}_logs/53 /media/data_raid0/${10}_logs/54 /media/data_raid0/${10}_logs/55 /media/data_raid0/${10}_logs/56 /media/data_raid0/${10}_logs/57 /media/data_raid0/${10}_logs/58  /media/data_raid0/${10}_logs/59 &> result.log &

elif [[ $1 -eq 6 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/60 /test_program_log/${4}/61 /test_program_log/${4}/62 /test_program_log/${4}/63 /test_program_log/${4}/64 /test_program_log/${4}/65 /test_program_log/${4}/66 /test_program_log/${4}/67 /test_program_log/${4}/68 /test_program_log/${4}/69
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /test_program_log/${4}/60 /test_program_log/${4}/61 /test_program_log/${4}/62 /test_program_log/${4}/63 /test_program_log/${4}/64 /test_program_log/${4}/65 /test_program_log/${4}/66 /test_program_log/${4}/67 /test_program_log/${4}/68 /test_program_log/${4}/69 &> result.log &

elif [[ $1 -eq 7 ]]; then
  echo $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/70 /media/data_raid0/${10}_logs/71 /media/data_raid0/${10}_logs/72 /media/data_raid0/${10}_logs/73 /media/data_raid0/${10}_logs/74 /media/data_raid0/${10}_logs/75 /media/data_raid0/${10}_logs/76 /media/data_raid0/${10}_logs/77 /media/data_raid0/${10}_logs/78  /media/data_raid0/${10}_logs/79
  $make_cmd $2 $3 $6 $7 $8 $9 0 1 $5 /media/data_raid0/${10}_logs/70 /media/data_raid0/${10}_logs/71 /media/data_raid0/${10}_logs/72 /media/data_raid0/${10}_logs/73 /media/data_raid0/${10}_logs/74 /media/data_raid0/${10}_logs/75 /media/data_raid0/${10}_logs/76 /media/data_raid0/${10}_logs/77 /media/data_raid0/${10}_logs/78  /media/data_raid0/${10}_logs/79 &> result.log &

# Memory blade id start from 16
elif [[ $1 -eq 16 ]]; then
  echo $make_cmd 2 4 $6 $7 $8 $9 0 0 100 ~/tensorflow_0_0 ~/tensorflow_1_0 ~/tensorflow_2_0 ~/tensorflow_3_0
  $make_cmd 2 4 $6 $7 $8 $9 0 0 100 ~/tensorflow_0_0 ~/tensorflow_1_0 ~/tensorflow_2_0 ~/tensorflow_3_0
fi
sleep 30
