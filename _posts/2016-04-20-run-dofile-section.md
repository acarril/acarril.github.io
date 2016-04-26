---
layout: post
comments: true
title:  "Running sections of do-files"
categories: stata
permalink: /posts/dofile-section
published: false
---

As do-files get larger and more complex, it is common to want to run only a portion or section of the code. Over the years I've come to use extensively what I call **do-switches**, which are just handy devices for "turning on and off" some parts of the code.

# The issue

We've all done it. It starts with

1. Error! `r(XXX);`

  then
  <ol start="2">
    <li>Correct small portion of code</li>
    <li><b>Select section of code in large do-file and run it</b></li>
    <i>(rinse and repeat)</i>
  </ol>

This post is all about step **3.**, which is can be very graphically appreciated in the following gif:

![Long selection](../files/long_selection.gif)

# Some solutions
