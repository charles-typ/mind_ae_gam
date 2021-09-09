#!/bin/bash
#$1: id of compute blade starting from 0
#$2: network interface of RoCE NIC
source g_set_env_gam.sh

cd ${GAM_PATH}/scripts/
# index here is starting from 1 not 0
sh 0$(($1+1))-network-config.sh

exit
