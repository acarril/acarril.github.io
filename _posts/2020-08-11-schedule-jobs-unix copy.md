---
layout: post
title: Using `cron` to schedule jobs in Linux and OSX
draft: true
---

Recently I've discovered the power of [cron](https://man7.org/linux/man-pages/man8/cron.8.html), a job scheduler that allows you to run scripts or other programs periodically, at fixed times or intervals. In this post I explain how to set it up, and go into the little tricks I found along the way.
{: .fs-6 .fw-300 }

# The problem

In my case I had a Python script named `pup-notify.py` (don't ask), which is a simple script that runs in less than half a second, but I wanted to run it every 10 minutes.
Even though running it is as simple as typing `python3 ~/bin/pup-notifier.py`, I wanted to automate the job.
One possible solution was to do it via Python, either via `time.sleep` or via the `schedule` library (or others, like `gevent`).
However, these solutions require that the program will be continously running, which seemed a bit inelegant.

# Enter cron(tab)

