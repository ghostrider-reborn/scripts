#!/bin/bash
#
# Script to set up an Ubuntu 18.04 DigitalOcean Server
# for android ROM compiling
#
# Made by Adithya R (ghostrider-reborn)
#

# Go to home dir
cd ~

# Install the dependencies
echo -e "\n================== INSTALLING PACKAGES ==================\n"
sudo apt-get update
sudo apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk python ccache
sudo apt-get upgrade -y

# Install Android SDK
echo -e "\n================== INSTALLING ANDROID SDK ==================\n"
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip
rm platform-tools-latest-linux.zip

# Install repo
echo -e "\n================== INSTALLING GIT-REPO ==================\n"
mkdir bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo -e "\n================== SETTING UP BASHRC & .PROFILE ==================\n"
# Add env variables to bashrc
cat <<'EOF' >> ~/.bashrc

export USE_CCACHE=1
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6144m"
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6144m"
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF8 -Xmx6144m"
EOT

# Add ~/bin and sdk to path
cat <<'EOF' >> ~/.profile

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi
EOF

# Set env from .bashrc and .profile
source ~/.profile
source ~/.bashrc
echo "Done"

# Configure git
echo -e "\n================== CONFIGURING GIT ==================\n"
git config --global user.email "gh0strider.2k18.reborn@gmail.com"
git config --global user.name "Adithya R"
git config --global alias.cp 'cherry-pick'
git config --global alias.c 'commit'
echo "Done"

# Done!
echo -e "\nALL DONE. Now sync sauces & start baking!\n"