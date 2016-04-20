---
layout: post
title:  "Running sections of dofiles"
categories: stata
permalink: /posts/run-dofile-section
---

As do-files get larger and more complex, it is common to want to run only a portion or section of the code. Over the years I've come to use extensively what I call "switches", which are handy devices for "turning on and off" some parts of the code.

# The issue

Say you have this *huge* do-file that imports different datasets, performs variuous operations in each one and then finally merges all of them into one.

![Long selection](../files/long_selection.gif)
