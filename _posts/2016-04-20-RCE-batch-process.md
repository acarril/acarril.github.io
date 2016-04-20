---
layout: post
title:  "Running parallel processes in batch mode"
categories: jekyll
permalink: /posts/batch-jobs
---

### Files needed

# Do-file

<pre class="sh_stata">
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
</pre>

# Submit file

````
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
````
