#!/usr/bin/env bash

##
# Bash script to provision VM, used to set up test environment.
# The is the correct home for one time builds/installations 
# required to set up the demonstrators.
#
# Be aware this script is only the first time you issue the
#    vagrant up
# command, or following a
#    vagrant destroy
#    vagrant up
# combination.  See the README for further detais.
##

# Update apt repos
apt-get update

# Install firefox for pagelyzer 
apt-get install -y firefox
# Install xvfb for pagelyzer 
apt-get install -y xvfb
#install java  
apt-get install -y openjdk-7-jre-headless


# Install apache 2 and PHP 5
apt-get install -y apache2
apt-get install -y php5 libapache2-mod-php5

# Restart apache and link www root to the vagrant shared dir
# which is the project home directroy. This allows live edits
# on the host machine to be immediately available of the VM.
/etc/init.d/apache2 restart
rm -rf /var/www
ln -fs /vagrant /var/www


#Running selenium server 
Xvfb :2 -screen 0 1024x768x24 &
DISPLAY=:2 java -jar /var/www/pagelyzer/selenium-server-standalone-2.39.0.jar -port 8015 &
#Create screen to run pagelyzer 
Xvfb :1 -screen 0 1024x768x24 &



# Install tools for downloading and building xcorrsound 
apt-get install -y git make cmake
apt-get install -y libfftw3-dev libboost-all-dev

# Build xcorrsound package in temp
cd /tmp
git clone https://github.com/openplanets/scape-xcorrsound.git
cd scape-xcorrsound
mkdir build && cd build
cmake ..
make package
cpack -G DEB

# Install xcorrsound package
dpkg -i scape-xcorrsound*deb