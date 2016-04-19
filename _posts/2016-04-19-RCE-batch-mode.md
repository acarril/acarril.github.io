---
layout: post
title:  "Submitting Batch Jobs"
categories: jekyll
permalink: /posts/batch-jobs
---

# Why use batch mode?

Submitting a job in batch mode is extremely useful for running long processes in the background, while freeing the GUI interface for other tasks. Although it is common to use batch mode for speed, **batch mode doesn't actually run any faster** (except for a negligible amount of speed increase because of lack of GUI).

# What do I need?

## `do-file`

First of all you need a do-file to submit. In this example we'll submit `mydofile.do`. This do-file hasn't have to have anything special, but make sure you know the path of the file. It is also recommended to have a dedicated folder for the outputs produced by the batch processing system. In this example I've been exceedingly creative and named that folder `/output`.

## `submit file`

Once that directory structure is set up, you'll need a `submit file`, which is a simple text file with instructions on how the batch process should be run. This `submit file` has to be saved with a `*.submit` extension. So, for example, I'll name mine `mybatch.submit` (again, creative).

The easiest way to get going is to copy the following text in any plain text editor and then make sure to save it with `*.submit` extension (not `*.submit.txt`!). All lines starting with a `#` are comments. Edit what you want and save the file in the same folder as your do-file.

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

# Submitting a batch job
