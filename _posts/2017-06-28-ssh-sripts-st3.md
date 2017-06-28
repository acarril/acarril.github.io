---
layout: post
title: "Editing remote scripts locally via SSH using SublimeText 3"
---

![](/files/missing_link_chain.jpg)

Nowadays I conduct most of my research in servers, like [Microsoft Azure](https://azure.microsoft.com/en-us/). The two main methods for interacting with remote systems are either through SSH (ie. using Putty in Windows) o through X11 tunneling GUI (something like Remote Desktop Environment).

Editing scripts through either of those methods is a pain in the ass, because you either do it via a super laggy graphical interface or you edit directly within the command line with something like `nano`. Both of these options suck, so I implemented a setup that works perfectly for me: **edit remote text files locally using SublimeText 3 and have them automatically transferred via SSH onto the remote server.**

<!--more-->

[SublimeText 3](http://www.sublimetext.com/) (ST3) is a superb text editor that's available for Windows, Mac and Linux. In a [previous post](/posts/use-st3) I explained how to get ST3 and how to configure it in order to be able to edit R, Python, Stata, LaTeX and Julia scripts. For this post I'll assume you have ST3 installed (including [Package Control](https://packagecontrol.io/installation)).

1. Fire up ST3 on your local machine and open the Package Control panel (Ctrl-Shift-P on Linux/Win; Cmd-Shift-P on Mac), type "install" and hit enter. Now search for the `rsub` package and hit enter again to install it.

2. In your local machine add `RemoteForward 52698 127.0.0.1:52698` to your `.ssh/config` file. This can be done from the terminal with
```bash
-R 52698:localhost:52698
```
Alternatively, if you're using Putty to connect to your remote machine then load your session and go to the `Connection > SSH > Tunnels` category. Write `52698` on "Source port" and `Localhost:52698` on "Destination". Change the radio buttons below so that "Remote" is selected and click "Add". You should see something like the screenshot below once the new forwarded port is added:
![](https://blog.cs.wmich.edu/wp-content/uploadsfiles/2014/10/sub5.png)

3. Connect to your remote server through SSH and install `rmate` by executing these commands:
```bash
sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
sudo chmod a+x /usr/local/bin/rmate
```

4. That's it! Your now ready to edit any file locally. Just execute `rmate <file>` and the file will be automatically transferred through SSH and opened in ST3. You can edit the file locally and each time you save it will be automatically transferred to the remote machine.