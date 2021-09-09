#!/bin/bash
#$1: id of compute blade starting from 0
#$2: network interface of RoCE NIC
echo "Initialize VM's RoCE module"
source g_set_env_gam.sh

# Linux kernel module for small initrd
cd ${GAM_PATH}/test/
pwd
# index here is starting from 1 not 0
sudo ../scripts/mn-network-config.sh

./gam_profile_test 2 4 $1 $2 $3 $4 0 0 100 ~/tensorflow_0_0 ~/tensorflow_1_0 ~/tensorflow_2_0 ~/tensorflow_3_0