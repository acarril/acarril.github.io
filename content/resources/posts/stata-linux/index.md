+++
author = "Álvaro Carril"
title = "Installing Stata on Linux"
date = "2018-01-03"
+++


Properly installing Stata in Linux is surprisingly cumbersome, and I've found that even [Statacorp's own guide](https://www.stata.com/support/faqs/unix/install-on-linux/) is incomplete and outdated. So here's mine.

{{< toc >}}

I have installed Stata in many Linux systems, but this guide was originally written for Ubuntu 16.04.
Having said that, I've checked that it works in many other Ubuntu-based and Arch-based distros, including Ubuntu 20.10.
Originally this was written for Stata 14, but I've tested versions 13 through 17.
You should already have a tarball (a file with `.tar.gz` extension) with the appropriate installation files for your operating system, and you'll need root privileges in your system for some steps.

## Installation

### Install script

1. Change directory to wherever you have the `.tar.gz` file (e.g. the Downloads folder). There, create a temporary folder to store the installation files (e.g. `statainstall`), and extract the installation files to that folder.
    ```bash
    cd ~/Downloads
    mkdir statainstall
    tar -xvzf Stata14Linux64.tar.gz -C statainstall
    ```

2. Create the installation directory, and change location into it.
    ```bash
    sudo mkdir /usr/local/stata14
    cd /usr/local/stata14
    ```

3. Run the install script.
    ```bash
    sudo ~/Downloads/statainstall/install
    ```

### License

In order you configure the license file you just need to run `./stinit` (you'll need root privileges to write the file). Be sure to have the serial number, code and authorization. No need to disconnect from the interwebz here, even if you have an "alternative" license ;) (this might have changed for Stata 18).

Run
```bash
sudo ./stinit
```

### Add directory to path

In order to be able to launch Stata you'll need to add the installation directory to the system path.

1. Add one line at the end of your `.bashrc` file (or equivalent, depending on your shell) to add Stata to the system path.
    ```bash
    echo export PATH="/usr/local/stata14:$PATH" >> ~/.bashrc
    ```

2. You need to source your `.bashrc` so that the changes are effective (or you can also restart your terminal):
    ```bash
    source ~/.bashrc
    ```
3. At this point you can also delete the temporary installation folder:
    ```bash
    rm -r ~/Downloads/statainstall
    ```


### Running Stata

After adding the install directory to yout path, you should be able to run the appropriate version of Stata from the terminal, e.g.:
```bash
xstata-mp
```
This launches the X-window (GUI based) version of Stata MP. You can also run Stata directly within the terminal with
```bash
stata-mp
```

Obviously you'll need to substitute `mp` for whatever version you have a license for.


## Updating

It is important to check if you're version of Stata is up to date.
You can head [here](https://www.stata.com/support/updates/) to find more information on updating.
If you have an internet connection you can simply run `update query` to check automatically.
However, if you have an "alternative" license you'll want to do a manual update (i.e. without internet access).

You may run into permissions errors while attempting an update: after running `update query` (online updating) or `update db` (manual, offline updating) you can get something like
```bash
cannot write in directory /usr/local/stata15/.tmp
r(603);
```
This happens due to permission issues in the install folder, but it's easily fixed.
Before attempting to update, you can either start Sata with `sudo` (eg. `sudo xstata-mp`), or temporarily change the folder's permissions:
```bash
sudo chmod 777 -R /usr/local/stata15
```
If you do the latter it would be advisable to revert to the default permissions with
```bash
sudo chmod 755 -R /usr/local/stata15
```

## Additional improvements

![stata-no-icons](https://www.statalist.org/forums/filedata/fetch?id=1351289&d=1469795531&type=full)

I have identified the following potential issues you may have after installing Stata in Linux:

1. Interface has no icons (ie. only question marks)
2. Program doesn't have an application menu entry (ie. can't search for the app)
3. Mimetype associations don't work (ie. you can't double click a `.dta` file and have it open in Stata)
4. PDF documentation links don't work

If you want to solve the first three of these issues at once with little messing around, you can use [Daniel Bela's `stata-integration`](https://github.com/dirtyhawk/stata-integration), which is a bundled Linux binary script integrating an already installed Stata instance into the desktop environment.
I've tried the script and it works as advertised, solving all above issues.
However, it runs some binaries in `sudo`, so you may be uncomfortable with that.

If you would rather fix these issues manually, you can check out the sections below.

### Interface icons

Although it is only a aesthetic annoyance, it _is_ annoying to have an interface with no icons:

![](https://www.statalist.org/forums/filedata/fetch?id=1351289&d=1469795531&type=full)

Friend and colleague Kyle Barron, who I met at the NBER, has written [a fix for this issue](https://github.com/kylebarron/stata-png-fix).
The main advantage of Kyle's solution is that it doesn't require `sudo` privileges.


### Unity launcher and desktop file

Even after successfully installing and running Stata, in Ubuntu it won't be available as an application in the dash, and it won't have a proper icon in the application launcher. We can easily fix this by creating a `.desktop` file for Stata.

```bash
sudo gedit /usr/share/applications/stata14.desktop
```

In this newly-created file just copy and paste the following, obviously adjusting it if you have a different version or flavor of Stata:

```bash
[Desktop Entry]
Version=14.2
Terminal=false
Icon=/usr/local/stata14/stata14.png
Type=Application
Categories=Education;Scientific;
Exec=/usr/local/stata14/xstata-mp
Name=Stata/MP 14
Comment=Perform statistical analyses using Stata.
StartupNotify=true
MimeType=application/x-stata-dta;application/x-stata-do;application/x-stata-smcl;application/x-stata-stpr;application/x-stata-gph;application/x-stata-stsem;
Actions=doedit;use;view;graphuse;projmanag;semopen;
```

After saving this file you should be able to find Stata from the Unity dash, and when launched it should have its icon.

### Adding mimetype associations

Adding mimetype associations for Stata files allows you to see Stata files (e.g. `do` files, `dta` files) with their proper icons, and more importantly, to be automagically opened in Stata when executed. This is the default behavior in Windows or Mac, but with Linux we have to do a bit of extra work.

<!---
1. In the same file, add the following entries below `[Desktop Entry]` and all of its parameters:
```bash
[Desktop Action doedit]
Name=Start Stata and open do-file editor
Exec=/usr/local/stata14/xstata-mp -q doedit "%f"
[Desktop Action use]
Name=Start Stata and use file
Exec=/usr/local/stata14/xstata-mp -q use "%f"
[Desktop Action view]
Name=Start Stata and open viewer
Exec=/usr/local/stata14/xstata-mp -q view "%f"
[Desktop Action graphuse]
Name=Start Stata and open graph editor
Exec=/usr/local/stata14/xstata-mp -q graph use "%f"
[Desktop Action semopen]
Name=Start Stata and open structural equation model builder
Exec=/usr/local/stata14/xstata-mp -q sembuilder "%f"
[Desktop Action projmanag]
Name=Start Stata and open project manager
Exec=/usr/local/stata14/xstata-mp -q projmanag "%f"
```
--->

1. First download [this tarball with Stata icons](/assets/files/stataicons.tar.gz) and extract it wherever you like.

2. In the terminal, go to the location where you have extracted the icons and then change directory to the PNG icons that correspond to your version of Stata. Then issue the following commands:
    ```bash
    xdg-icon-resource install --context mimetypes --size 256 stata-dta_256x256x32.png application-x-stata-dta
    xdg-icon-resource install --context mimetypes --size 256 stata-do_256x256x32.png application-x-stata-do
    ```

3. Create and edit the mimetype definitions with the following command:
    ```bash
    sudo gedit /usr/share/mime/packages/application-x-stata.xml
    ```
    Then copy the following inside this newly created file, and save.
    <script src="https://gist.github.com/acarril/d8894997454653f3d7ffed01695934dd.js?file=application-x-stata.xml"></script>

5. Finally, update the mime and desktop databases so that changes take effect.
    ```bash
    sudo update-mime-database /usr/share/mime
    sudo update-desktop-database /usr/share/applications/
    ```

That's it! You should now have a fully functional, "pretty" version of Stata on your Linux system. With a bit of extra work, you can complete the job and add mimetype associations for more obscure Stata files. For instance, you can associate `do` and `ado` files to be opened up by your favorite editor instead of Stata's default do-file editor.

### PDF documentation

The PDF manuals are loaded by a script named `stata_pdf`, located inside your Stata installation directory (eg. `/usr/local/stata15/stata_pdf`).
By default the script points to Acrobat Reader (`acroread`), but [Adobe discontinued it](https://askubuntu.com/questions/507777/adobe-reader-for-linux-discontinued) around 2014 (good riddance). We can make some edits to `stata_pdf` so that it uses Evince, which is the default PDF reader in many Linux distros.

First, it always advisable to backup the original file:
```bash
cp /usr/local/stata15/stata_pdf /usr/local/stata15/stata_pdf_bkp
```
Now we edit the script with `nano` (or whatever you prefer):
```bash
nano /usr/local/stata15/stata_pdf
```
Scroll past the commented text and modify it so that it reads like the following block.
It boils down to three edits: `cmd="evince"` in second line and the first two `wharg=...`.
```bash
case "$PDFVIEWER" in
"")     cmd="evince"
        ;;
*)      cmd="$PDFVIEWER"
        ;;
esac

case "$1" in
"-page")        pagenum=$2
                fname=$3
                wharg="--page-label=$pagenum"
                ;;
"-section")     section=$2
                fname=$3
                wharg="--named-dest=$section"
                ;;
*)              fname="$1"
                wharg=""
                ;;
esac

exec $cmd $wharg "$fname"
```

## Known issues

- If you have a dark GTK+ theme enabled (e.g. the dark variant of [Arc](https://github.com/horst3180/arc-theme), my theme of choice), the X-window version of Stata looks awful. I tried solving this by executing `xstata` with a different GTK theme; i.e. something like
    ```bash
    Exec=env GTK_THEME=Arc xstata-mp
    ```
    but apparently GTK+ 3 applications have to be coded to respect the `GTK_THEME` env variable, and Stata is not. I suspect some answers in [this](https://askubuntu.com/questions/78088/can-i-apply-a-different-gtk3-theme-from-the-main-one-to-an-individual-applicatio) and [this](https://unix.stackexchange.com/q/14129) questions might contain possible solutions, but I just switched to a light variant of Arc and called it a day.
