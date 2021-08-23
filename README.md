# Overview
 
 This is the evaluation repo for MIND against mind. 
 
 We made several modifications to the [original GAM repo](https://github.com/ooibc88/gam), including fixing bugs and implementing memory trace applications.
 
 Please follow the installation guide in the original GAM repo.



# Build & Usage
## Prerequisite
1. `libverbs`
2. `boost thread`
3. `boost system`
4. `gcc 4.8.4+`

## GAM Core
First build `libcuckoo` in the `lib/libcuckoo` directory by following the
`README.md` file in that directory, and then go to the `src` directory and run `make`
therein.
```bash
  cd src;
  make -j 8;
```

## GAM benchmark code
```bash
  cd gam/test
  make -j 8;
```

# Benchmark

Please first install GAM on the servers required for the benchmark. (Mostly a few compute servers, one memory server)


Please gather the memory trace files following the instructions here https://github.com/shsym/mind/tree/main/tools/prepare_traces.

We currently don't support fast scripts to launch the benchmark, therefore we need to launch scripts on each of the servers.

## Cluster setup

This benchmark requires (1, 2, 4, 8) compute servers, and one memory server.

The first compute server (index: 0) also acts as the GAM controller.

The normal switch program is required

## Scripts
Usage:
```bash
cd gam/test
# This requires sudo permission to access the logs in SSD
sudo ./gam_profile_test $TOTAL_SERVERS $NUM_THREAD_PER_SERVER $CONTROLLER_IP $WORKER_IP $CONTROLLER_PORT $WORKER_PORT $IS_CONTROLLER $IS_COMPUTE_NODE LOCAL_CACHE_RATIO $WORKSET_SIZE $TOTAL_NUM_COMPUTE_NODE $TRACE_FILES.... &> $RESULT_FILE
```

Parameters:

$TOTAL_SERVERs = total number of servers in the cluster(compute + memory)

$NUM_THREAD_PER_SERVER = number of compute threads in the server, needs to match number of trace files (1 thread per trace file)

$CONTROLLER_IP = Controller IP

$WORKER_IP = Current Worker IP

$CONTROLLER_PORT = Controller port

$WORKER_PORT = Worker port

$IS_CONTROLLER = 1 for controller, 0 for other servers

$IS_COMPUTE_NODE = 1 for compute node, 0 for memory node

$LOCAL_CACHE_RATIO = Percentage of entire workload memory footprint as local cache. (Local cache in bytes = $LOCAL_CACHE_RATIO * WORKSET_SIZE)

$WORKSET_SIZE = Number of bytes that the workload will cover (whole range, in bytes) -> (ma: 6442450944, mc: 6442450944, tf: 6442450944, graphchi: 6442450944)

$TOTAL_NUM_COMPUTE_NODE = total numebr of compute nodes

$TRACE_FILES... = all trace files (PUT DUMMY FILES FOR MEMORY SERVER)

$RESULT_FILE = the result collection


One thing to note is that $WORKSET_SIZE can be arbitrary large as long as the memory server has enough memory (default 10GB, modify it [here](https://github.com/charles-typ/mind_ae_gam/blob/132aec5fc4cd035670dcc749b4e9ea51c3597cb5/test/gam_profile_test.cc#L551), as we don't use the redundant memory anyway. 

Just keep in mind that local cache size should always be $WORKSET_SIZE X $LOCAL_CACHE_RATIO

## Example
Here is one example for setting up a single compute node single memory node benchmark of memcached_a:

### Server 1: compute server and GAM controller
```bash
sudo ./gam_profile_test 2 10 10.10.10.201 10.10.10.201 1231 1234 1 1 0.083 6442450944 1 /memcached_a/memcached_a_0_0 /memcached_a/memcached_a_1_0 /memcached_a/memcached_a_2_0 /memcached_a/memcached_a_3_0 /memcached_a/memcached_a_4_0 /memcached_a/memcached_a_5_0 /memcached_a/memcached_a_6_0 /memcached_a/memcached_a_7_0 /memcached_a/memcached_a_8_0 /memcached_a/memcached_a_9_0 &> 1C_1M_10T_512MB_memcached_a
```
### Server 2: memory server
```bash
# No sudo requirement for memory server
# ~/tensorflow_0_0 ~/tensorflow_1_0 ~/tensorflow_2_0 ~/tensorflow_3_0 are just dummy files
# WORKSET_SIZE, LOCAL_CACHE_RATIO, NUM_THREAD_PER_SERVER are not used
# NUM_THREAD_PER_SERVER need to match number of dummy trace files
 ./gam_profile_test 2 4 10.10.10.201 10.10.10.221 1231 1234 0 0 0.5 2147483648 1 ~/tensorflow_0_0 ~/tensorflow_1_0 ~/tensorflow_2_0 ~/tensorflow_3_0
 ```
