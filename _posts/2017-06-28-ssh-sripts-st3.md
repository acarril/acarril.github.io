---
layout: post
title: "Editing remote scripts locally via SSH using SublimeText 3"
---

![](/files/missing_link_chain.jpg)

Nowadays I conduct most of my work in servers, like [Microsoft Azure](https://azure.microsoft.com/en-us/). The two main methods for interacting with remote systems are either using SSH directly (ie. using Putty in Windows) or by tunneling X11 applications to use a GUI (something like Remote Desktop Environment).

Editing scripts through either of those methods is a pain in the ass, because you either do it via a laggy graphical interface or you edit directly within the command line using something like `nano`, which lacks syntax highlighting and other goodies. Both of these options suck, so I implemented a setup that works perfectly for me: **edit remote text files locally using SublimeText 3 and have them automatically transferred via SSH onto the remote server.**

<!--more-->

[SublimeText 3](http://www.sublimetext.com/) (ST3) is a superb text editor that's available for free on Windows, Mac and Linux. In a [previous post](/posts/use-st3) I explained how to get ST3 up and running, and how to configure it in order to be able to edit R, Python, Stata, LaTeX and Julia scripts. For this post I'll assume you have ST3 installed (including [Package Control](https://packagecontrol.io/installation)).

## Initial configuration

1. Fire up ST3 on your local machine and open the Package Control panel (Ctrl-Shift-P on Linux/Win; Cmd-Shift-P on Mac), type "install" and hit enter. Now search for the `rsub` package and hit enter again to install it.

2. You must add a new forwarded port (52698) to your SSH connection. This process is different depending on your OS.
<br/><br/>
**Linux/Mac**
<br/><br/>
Add the following option to your `ssh` command:
```
-R 52698:localhost:52698
```
For instance, if you normally connect to the machine by typing
```
ssh <username>@<remotehost>
```
where `<remotehost>` is the server address or IP, now you should type
```
ssh -R 52698:localhost:52698 <username>@<remotehost>
```
Of course, a much better alternative is to store these settings into your `.ssh/config` file.
If you haven't done this already, now may be a good time to do it.
The cool thing about it is that you just choose an `<alias>` for the session and it will store and load all the necessary settings.
Simply launch the terminal and run
```
nano ~/.ssh/config
```
You will see a blank file if you haven't configured any SSH hosts.
Write the following lines, filling in your own information in any fields that are written like `<this>`:
```
host <alias>
HostName <remotehost>
User <username>
RemoteForward 52698 localhost:52698
```
Save with Ctrl+O and exit with Ctrl+X.
The beauty of having configured your `.ssh/config` file is that now you can connect just by typing
```
ssh <alias>
```
**Windows (Putty)**
<br/><br/>
If you're using Windows I'll assume you use [Putty](http://www.putty.org/) as your SSH client. Load your session and go to the `Connection > SSH > Tunnels` category. Write `52698` as "Source port" and `localhost:52698` as "Destination". Change the radio buttons below so that "Remote" is selected and click "Add". You should see something like the screenshot below once the new forwarded port is added:
<br/><br/>
![](https://blog.cs.wmich.edu/wp-content/uploadsfiles/2014/10/sub5.png)
<br/><br/>
Be sure to save these settings into your session before connecting to the remote system.

3. Install `rmate` in the remote machine by executing these commands:
```bash
sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
sudo chmod a+x /usr/local/bin/rmate
```

## Usage

That's it! You're now ready to edit any remote text file locally. Just execute `rmate <file>` and the file will be seamlessly transferred through SSH and opened in ST3 (be sure to have it open). You can edit the file locally and each time you save it will be automatically transferred to the remote machine.
