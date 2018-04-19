---
layout: post
title: Configuring Unix access to Princeton's servers off campus
---

![](https://www.princeton.edu/researchcomputing/access/prospective_users.jpg)

A small guide of what I've learned in order to connect to your Unix account off-campus.

<!--more-->

# Setting up SRA

It is essential to setup [Secure Remote Access (SRA)](http://www.princeton.edu/oit/news/archive/?id=7589) before attempting anything else. There is also additional information [here](https://princeton.service-now.com/snap?sys_id=6023&id=kb_article).

### Linux

The [linked article](https://princeton.service-now.com/snap?sys_id=1157&id=kb_article) has detailed enough information, and it works well.

### Windows

The [corresponding article](https://princeton.service-now.com/snap?sys_id=1155&id=kb_article) for Windows has SRA download links, but they don't work without a SRA connection set up in the first place, because ~logic `¯\_(ツ)_/¯`.
However, you can access download links (and other useful resources) by logging into [SonicWall Mobile Connect](https://eisnet-sra-n2.remote.princeton.edu/).
Just login into Princeton University and then type your NetID and password. The next page won't load unless you approve the login request with Duo.
Once logged in, download the software using the *Install Connect Tunnel* link.
Alternatively, you can also install SRA in Windows 10 following [these steps](https://princeton.service-now.com/kb_view.do?sysparm_article=1206).
For both installation methods you will have to provide the server name, which is `remote.princeton.edu`.
