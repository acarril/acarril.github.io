---
layout: post
title:  "Submitting Batch Jobs"
categories: jekyll
permalink: /posts/batch-jobs
---

Submitting a job in batch mode is extremely useful for running long processes in the background, while freeing the GUI interface for other tasks. Although it is common to use batch mode for speed, it doesn't actually run any faster (except for a negligible amount of speed increase because of lack of GUI).

```
# Universe whould always be 'vanilla'. This line MUST be
#included in your submit file, exactly as shown below.
Universe = vanilla

# The path to Stata (could be R or Matlab)
Executable = /usr/local/bin/stata-mp

# Specify any arguments you want to pass to the executable.
# Here we pass arguments to make Stata run the bootstrap.do
# file. We also pass the process number, which will be used
# to append the process number to the output files.
Arguments = -q do mydofile.do

# Specify where to output any results printed by your program.
output = output/mydofile.out
# Specify where to save any errors returned by your program.
error = output/mydofile.err
# Specify where to save the log file.
Log = output/mydofile.log

# Request processors (Stata maxes out at 4) and memory (in MB)
Request_Cpus = 4
Request_Memory = 8192

# Notifications settings
notification = Always
notify_user = your@email.com

# Enter the number of processes to request.
# This section should always come last.
Queue 1
```
