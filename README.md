# CardGateway - Secure Object Key

This document will provide a new developer with the required information to setup a development environment compatible with the Secure Object Key server.

This guide is compatible and interchangeable between OSX and Ubuntu installations.

## Table of contents

* **[Git repository information](#git-repository-info)**
  * [SSH Keys and Git](#ssh-keys-and-git)
  * [Cloning the SecureObjectKey repo](#cloning-the-secureobjectkey-repo)
  * [Cloning the customised Proxama Django-Piston repo](#cloning-the-customised-proxama-django-piston-repo)
  * [Create a testing database directory](#create-a-testing-database-directory)
* **[Pip, Virtualenv and Virtualenvwrapper](#pip-virtualenv-and-virtualenvwrapper)**
  * [Install Pip](#install-pip)
  * [Install Virtualenv](#install-virtualenv)
  * [Install Virtualenvwrapper](#install-virtualenvwrapper)
    * [Shell profile setup](#shell-profile-setup)
    * [Optional - Alias setup](#optional-alias-setup)
* **[Setup a working virtualenv](#setup-a-working-virtualenv)**
  * [Install SecureObjectKey server components](#install-secureobjectkey-server-components)
* **[Optional - Eclipse setup](#optional-eclipse-setup)**
  * Reserved for future use
  * blah blah 
  
  
## Git repository info

The SecureObjectKey server Git repository can be found here [git@git.prx.ma:cardgateway/cardgateway-sok.git]()

#### SSH keys and Git

To clone this repository you'll need `git` installed but also to generate some SSH keys to authenticate yourself. Instructions for this are available on Proxama's gitlab [here](https://git.prx.ma/help/ssh).

If using **Ubuntu** you can install `git` easily

```
sudo apt-get update && sudo apt-get -y install git
```
On **OSX**, the easiest method is just to open the terminal and type `git`. You should then get a prompt asking you to download and install `command line utils` automatically. Alternatively `git` also comes with Xcode.

Don't forget to set your global variables so `git` knows who you are:

```
git config --global user.email "super.awesome@proxama.com"
git config --global user.name "Super Awesome"
```

#### Cloning the SecureObjectKey repo

Make sure you have changed into the directory where you want this project to live. Let's say it's `~/Documents/Proxama/gitRepos/`, just for fun.

```
git clone git@git.prx.ma:cardgateway/cardgateway-sok.git
```

#### Cloning the customised Proxama Django-piston repo

This is a separate repo from the main project and you will need specific permissions to access it. Create a directory in your repo cloning root, call it `django-piston`.

```
git clone git@git.prx.ma:proxama/django-piston.git
```

Remember this file path, you'll need it later when installing stuff using `pip`.


#### Create a testing database directory

Assuming you've cloned the repo above, you'll have a folder name `cardgateway-sok`. Right beside it create another folder entitled `cardgateway-dbs`. You can do this on the command line with `mkdir cardgateway-dbs`.

A successful directory structure should look like this:

```
.
├── cardgateway-dbs
├── cardgateway-sok
│   ├── config
│   │   ├── apt.list
│   │   └── pip.list
│   ├── libs
│   │   └── tp-core.tar.gz
│   ├── logs
│   │   └── srv.log
│   ├── pid
│   └── src
│       ├── cardgateway_sok
│       │   ├── app_settings.py
│       │   ├── celery_init.py
│       │   ├── __init__.py
│       │   ├── local_settings.dev.py
│       │   ├── local_settings.master.py
│       │   ├── settings.py
│       │   ├── urls.py
│       │   └── wsgi.py
│       ├── directory_service
│       │   ├── api_urls.py
│       │   ├── __init__.py
│       │   ├── models.py
│       │   ├── tests
│       │   │   ├── __init__.py
│       │   │   └── test_external_lookup_id.py
│       │   └── urls.py
│       └── manage.py
└── django-piston

```

## Pip, Virtualenv and Virtualenvwrapper

It is good practice to create isolated virtual environments for each Django project. To do this we use `virtualenv`.

First, you'll need to grab `python-setuptools` from your package manager. This guide assumes you're using a Debian based distro such as Ubuntu. You need to be running Python 2.7 and can check this by running `python -V`.

###### Debian / Ubuntu

```
sudo apt-get update
sudo apt-get upgrade  <--- optional, but recommended
sudo apt-get install python-setuptools
```

###### Mac OSX

OSX comes with `easy_install` already setup, however it is recommended that Xcode is installed as it contains several useful tools we might need later. Xcode is a 2.5gb download, sorry.

##### Install Pip 

This is the same for OSX and Linux. We use `sudo` to perform this system wide.

```
sudo easy_install pip
```

Check it is installed properly by issuing `pip`. Hopefully, you'll get some output like this

```
Usage:
	pip <command> [options]
	...
```

##### Install virtualenv

Again, this is identical for OSX and Linux and also a system wide command, hence `sudo`.

```
sudo pip install virtualenv
```
Check that's worked by issuing `virtualenv`, it should look something like this

```
proxama@UbuntuVM:~$ virtualenv
You must provide a DEST_DIR
Usage: virtualenv [OPTIONS] DEST_DIR

Options:
...
```

##### Install virtualenvwrapper

This is identical for OSX and Linux and again, systemwide. More detailed information about virtualenvwrapper is available in it's excellent documentation which can be found here [http://virtualenvwrapper.readthedocs.org/en/latest/install.html]().

```
sudo pip install virtualenvwrapper
```
In order for virtualenvwrapper to be able to do it's stuff most effectively we're going to need to edit your shell profile file. This process differs on OSX and Linux.

###### Debian / Ubuntu

Linux uses the file `~/.bashrc` to load your shell parameters. To edit this file let's use `nano`, a text editor.

```
nano ~/.bashrc
```
It doesn't matter where you put the following, but at the end of the file is best practice. Make sure to edit the file paths to your liking!

```
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Proxama/repos
source /usr/local/bin/virtualenvwrapper.sh
```
Save the file. If using `nano` this is `Ctrl+X` then `Ctrl+Y`. Close and reopen your terminal to reload the shell with these changes. Then issue `workon`. If you don't get an error, you're good.

###### OSX

OSX loads it's shell parameters from several files but we'll create our own, separate file `~/.bash_profile` to hold our stuff. This follows a similar pattern the above Linux steps, just substitute the filename where required.

###### Optional - Alias Setup

Whilst we're editing our bash shell profiles it might be a good time to speed up your workflow by adding `aliases` to them. Instead of having to change to a long, convoluted file path such as `~/Documents/Proxama/some/amazing/magic/trick` we can utilise an alias to simply type `magictrick`. Add the following line to either your `.bashrc` or `.bash_profile` file depending upon your OS:

```
alias magictrick="cd ~/Documents/Proxama/some/amazing/magic/trick"
```

You can take this simple concept and really go to town with it. Enjoy!

## Setup a working virtualenv

Now we have `pip`, `virtualenv` and `virtualenvwrapper` successfully installed (I hope), let's setup an environment within which to actually get some work done. You can replace `cg-sok` with whatever you like, it's just the name given to the virtualenv.

```
mkvirtualenv cg-sok
```

You will automatically enter this virtualenv after setup, but to manually enter it type `workon $vEnvName$`. To leave the virtualenv simply type `deactivate`. 

###### Install SecureObjectKey server components

*Make sure you're still in your virtualenv. Look at your shell and it should have your vEnv name in parenthesis like this* `(cg-sok)proxama@UbuntuVM:~$`.

It is assumed that you have *already* cloned the Git repository. If you haven't done that yet, you need to do it now.

** Ubuntu / Linux only ** - you need to install the contents of `cardgateway-sok\config\apt.list` in order for the next step(s) to work.

```
sudo apt-get install $(grep -vE "^\s*#" apt.list  | tr "\n" " ") 
```

** Need my new `pip.list` comitting for this to work properly. **

We're going to use `pip` to install multiple components at once from the file `cardgateway-sok\config\pip.list`. But before we do, we need to edit `pip.list` to point the `django-piston` repo you cloned earlier, you did clone it right? S


You need to run this command from within that directory, `cd cardgateway-sok\config`.

```
pip install -r pip.list
```

## Optional - Eclipse setup

Something about setting up Eclipse...
