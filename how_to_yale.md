# Guide to run experiments in Yale cluster(GAM)
This directory contains command lines with minimal description. 

## Summary
We will run the following experiments:
- GAM performance evaluation with memory traces (Fig. 6)
---

<br></br>
## Setup evaluation for GAM
* *Please make sure that you shut down compute blades(/VMs) running other systems*

* We assume you already have access to the control server.


For GAM experiments, we need to change the directory to this repo:

```bash
$ cd ~/mind_ae_gam/ctrl_scripts/scripts
$ pwd
/home/sosp_ae/mind_ae_gam/ctrl_scripts/scripts
```

You can check the current status of git repository
```bash
$ git remote -v
origin	https://github.com/charles-typ/mind_ae_gam.git (fetch)
origin	https://github.com/charles-typ/mind_ae_gam.git (push)

$ git status
(some result here)

$ git log
(some result here)
```

If some files were modified by previous evaluator, please reset the repository by
```bash
git reset --hard HEAD
git pull
```

Please tell switch that you are going to run normal switch program
```bash
python3 run_commands.py --profile=profiles/02_setup_normal_switch.yaml
```
---

<br></br>
## ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) Performance evaluation with memory traces (Fig. 8)

*Skip this step if you already loaded target traces for MIND*
- Every time you load traces for new application, it will automatically erase the previous ones
- Go inside the script directory and load memory access traces for Tensorflow

```bash
python3 run_commands.py --profile=profiles/05_load_trace_tf.yaml
```

After the script for loading traces is finished, we can run the following command to run an experiment with the TensorFlow memory traces we just loaded:
```bash
python3 run_commands.py --profile profiles/04_macro_bench_gam_tf.yaml
```
- By default, it will run only 1/10 of the total traces (i.e., 5k steps of total 50k steps) with 2 compute blades; it will take 10 ~ 20 minutes.
  - Please modify the values in `profiles/04_macro_bench_gam_tf.yaml` to change number of blades, threads and steps.
  - Tag for the application or [APP]
    - [APP]: `tf` for TensorFlow, `gc` for GraphChi, `ma` / `mc` for Memcached with YCSB workloadA/workloadC
  - Number of total steps we used in the paper are
    - `tf`: 50000,  `gc`: 50000, `ma`: 35000, `mc`: 20000
    ```yaml
    - name: run macro benchmark
        job: macro_bench
        per_command_delay: 10
        post_delay: 0
        job_args:
        trace: tf         # Tensorflow workload
        node num: 2       # <- ** BECAREFUL ** this value is different from MIND's configuration, node num is the toal number of servers(both compute and memory) in the system modify this value to set the number of vms [2, 3, 5, 9]. The default value(2) means one compute VM and one memory VM.
        thread_num: 10    # <- modify this value to set the number of threads per blade [1, 2, 4, 10]
        step_num: 5000    # <- increase this value to run more portion of the traces
        controller_ip: 10.10.10.201 # By default the first compute VM will be the GAM controller (No need to modify)
        controller_port: 1231 # Default GAM controller port (No need to modify)
        worker_port: 1234 # Default GAM worker port (No need to modify)
    ```
## Please be careful "node num" in gam experiments represent the total number of VMs in the system (# compute + # memory). This is different from the MIND configuration.
The result of the experiment will be downloaded at `~/Downloads/gam/04_macro_bench_gam_[APP]`


To compute the final number of the result, please run
```bash
cd post_processing && ./04macro_bench_gam_res.sh && cd ..
```
- This script scan will scan through the directories for all the applications and number of compute blades and calculate normalized computing speed.

We can also test traces from other applications, for example
```bash
python3 run_commands.py --profile=profiles/05_load_trace_gc.yaml
python3 run_commands.py --profile profiles/04_macro_bench_gam_gc.yaml
```

## Clean up
**Please shut down GAM's compute blades(/VMs) before testing out other systems**
```bash
python3 run_commands.py --profile profiles/06_shutdown_system.yaml
```
