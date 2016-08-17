#!/usr/bin/env bash
echo "Install .files"

#Get root password
sudo -v

#Determine install/dotfiles folder
export DOTFILEPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo ".file Path: $DOTFILEPATH"

#Private Key file creation
echo ".private creation"

mkdir $DOTFILEPATH/private

if [ ! -e $DOTFILEPATH/private ]; then
  echo "creating private folder"
  mkdir private
else
  echo "private folder already exists"
fi

if [ ! -e $DOTFILEPATH/private/.private ]; then
  echo "creating .private"
  echo "#.private keys" > $DOTFILEPATH/private/.private
  echo "#Place your private exports / env variables here" >> $DOTFILEPATH/private/.private
  echo 'echo ".private complete"' >> $DOTFILEPATH/private/.private
else
  echo ".private file already exists"
fi

#Backup existing files
echo "Create backup of existing .files"
BACKUPPATH=$DOTFILEPATH/backups/$(date "+%Y%m%d%H%M")
mkdir -p $BACKUPPATH

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc $BACKUPPATH/.bashrc.bac
else
  echo "No existing .bashrc"
fi

if [ -f ~/.bash_logout ]; then
  mv ~/.bash_logout $BACKUPPATH/.bash_logout.bac
else
  echo "No existing .bashrc"
fi

#Symlink to new dotfiles.
echo "Symlink to new files"
ln -sfv "$DOTFILEPATH/.bashrc" ~
ln -sfv "$DOTFILEPATH/.bash_logout" ~

#Install Linuxbrew
sudo apt-get install build-essential curl git python-setuptools ruby
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

#Install GOLANG
#brew install golang

#Finally reload the shell
echo "Install complete...."
echo "Reloading shell"
exec $SHELL -l
