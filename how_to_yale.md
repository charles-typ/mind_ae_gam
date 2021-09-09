# Guide to run experiments in Yale cluster(GAM)
This directory contains command lines with minimal description. 

## Summary
We will run the following experiments:
- ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) Performance evaluation with memory traces (Fig. 8)

## Access to the control server
We assume thet you already have Yale VPN following our instructions in hotcrp.
- **IMPORTANT** please reserve your time slot first using the link in hotcrp; since we have only one cluster with a programmable switch, each evaluator should have own dedicated time slot.
- *For your anonymity, please do not use your google account when you access any Google docs we provide*

After start Yale VPN session (i.e., login on Cisco Anyconnect)
```bash
ssh -i [PATH TO THE SSH KEY] sosp_ae@ecl-mem-01.cs.yale.internal
```
- Please find ssh key from hotcrp.
- Please do not remove repository in the control server; it will also remove any precomputed input/log files we set up on the servers.

Once you log in, the default directory is set to the [control script directory](https://github.com/shsym/mind/tree/main/mind_switch_ctrl) of MIND repository:
```bash
$ pwd
/home/sosp_ae/mind/ctrl_scripts
```

You can check the current status of git repository
```bash
$ git remote -v
origin	https://github.com/shsym/mind.git (fetch)
origin	https://github.com/shsym/mind.git (push)

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

## ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) Performance evaluation with memory traces (Fig. 8)

Let's go inside the script directory and load memory access traces for Tensorflow
```bash
cd scripts
python3 run_commands.py --profile=profiles/05_load_trace_tf.yaml
```
The script will print out raw input (i.e., ssh commands to the servers) and standard output.
- Since we need to download more than 1TB of data, this will take some time up to one hour.

After the script for loading traces is finished, we can run the following command to run an experiment with the TensorFlow memory traces we just loaded:
```bash
python3 run_commands.py --profile profiles/04_macro_bench_tf.yaml
```
- By default, it will run only 1/10 of the total traces with 2 compute blades; it will take 10 ~ 20 minutes.
  - Please modify the values in `profiles/04_macro_bench_tf.yaml` for test various setup

    ```yaml
    - name: run macro benchmark
        job: macro_bench
        per_command_delay: 10
        post_delay: 0
        job_args:
        trace: tf         # Tensorflow workload
        node num: 2       # <- modify this value to set the number of compute blades [1, 2, 4, 8]
        thread_num: 10    # <- modify this value to set the number of threads per blade [1, 2, 4, 10]
        step_num: 5000    # <- increase this value to run more portion of the traces
    # step_num used in the paper ()
    # - Tensorflow or tf: 50000
    # - GraphChi or gc: 50000
    # - Memcached YCSB workloadA or ma: 35000
    # - Memcached YCSB workloadA or mc: 20000
    ```
  The result of the experiment will be downloaded at `~/Downloads/04_macro_bench_[APP]`
- [APP]: `tf` for Tensorflow, `gc` for GraphChi, `ma` / `mc` for Memcached with YCSB workloadA/workloadC

To compute the final number of the result, please run
```bash
cd post_processing && ./04macro_bench_res.sh && cd ..
```
- This script scan will scan through the directories for all the applications and number of compute blades and calculate normalized computing speed.
  - The value is calculated by (total amount of task / processing time): [actual code](https://github.com/shsym/mind/blob/8cf7e8baa05bd2489ad3058437d06acd92c8aa43/ctrl_scripts/scripts/post_processing/04macro_bench.py#L54)

Result from the switch will be placed at `~/Download/latest.log`
  - A new result will override any previous result having the same filename.
  - Inside the log file, each line  `23:07:02:512201, 7473, 1`

    represents `[TIMESTAMP], [#FREE DIRECTORY ENTRIES], [SPLIT/MERGE THRESHOLD]`
    - We used/set total number of entires as 30,000

We can also test traces from other applications, for example
```bash
python3 run_commands.py --profile=profiles/05_load_trace_gc.yaml
python3 run_commands.py --profile profiles/04_macro_bench_gc.yaml
```
