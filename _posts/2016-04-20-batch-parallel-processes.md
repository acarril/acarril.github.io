---
layout: post
title:  "Parallel processes in batch mode"
categories: RCE
---

One of the most powerful features of batch mode is the ability to run several processes in parallel. I'll explain how to easily use this feature  with Stata.

This is the second post regarding batch jobs in the RCE server. I also wrote a [first part](batch-jobs) which deals with the basics of running batch jobs using Stata.

# Stuff needed

We are going to need, as usual, a [**do-file**](#do-file) and a [**submit file**](#submit-file). We are also going to assume some basic [**directory structure**](#directory-structure).

### Directory structure

For this example we'll need to set everything up in a root folder which contains a `dofiles` folder, a `batch_output` folder and a `datasets` folder. The do-file to submit is going to be located inside the dofiles folder, while the submit file is located in the root folder. All this can be easily seen in the screenshot below.

![batch_process_directory_structure](..\files\batch_process_directory_structure.png)

### Do-file

The do-file we're using is going to

1. Always read the same dataset
2. Set a different seed for each process
3. Extract a different sample with replacement for each process
4. Compute the average value of a variable from the sampled observations for each process
5. Save a different collapsed dataset for each process

The key here is to collect `process`, an integer passed by the submit file (see the [submit file](#submit-file) below) onto the do-file. This will make each run of the do-file unique for each process.

```
// set more off so that the do-file runs without halting
set more off

// collect the arguments passed by submit file
args process

// load example dataset
sysuse bpwide, clear

// set seed so it's different for every process
set seed `process'

// sample with replacement
bsample, cluster(patient) idcluster(idcluster)

// calculate the mean and standard deviation
collapse (mean) mean_bp_before = bp_before (sd) sd_bp_before = bp_before

// save the result, appending the process number to the dataset name
save "datasets/output_`process'.dta", replace
```

### Submit file

The submit file is very similar to the basic template, but now we pass the `Process` argument from the batch system onto Stata, by defining a global (remeber our do-file expects that?). The way to do that is by appending `$(Process)` at the end of the `Arguments` line. The process number should also be appended to the `ouptut`, `error` and `log` files, like below.

How many process we are requesting is defined in the last line, `Queue`. In this example we're requesting 10 processes, which will make the `$(Process)` integer go from 0 to 9.

```
Universe = vanilla
Executable = /usr/local/bin/stata-mp

# Pass the process number, which will be used
# to append the process number to the output files.
Arguments = -q do dofiles/batch_process.do $(Process)

output = batch_output/mydofile$(Process).out
error = batch_output/mydofile$(Process).err
Log = batch_output/mydofile$(Process).log

Request_Cpus = 2
Request_Memory = 2GB

# Notifications settings
notification = Always
notify_user = your@email.com

# Number of processes to request
Queue 10
```

# Running the processes

To submit these parallel jobs we'll go to the command line and change the current directory to our root folder. For example, I have put all the files of this example in a folder called `batch`, located inside my personal directory in the RCE environment, so I use

```
cd batch
condor_submit stata_batch_process.submit
```
