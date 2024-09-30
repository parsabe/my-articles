#!/bin/bash

# Step 1: Download and unzip GitHub zip file
GITHUB_ZIP_URL="https://github.com/parsabe/parsabe/blob/main/conf/ant.zip"  # Replace with the actual URL
ZIP_FILE="theme.zip"
THEME_FOLDER="ant-nubula"
THEME_DEST_DIR="$HOME/.themes"

# Download the zip file
echo "Downloading the theme zip file..."
curl -L -o "$ZIP_FILE" "$GITHUB_ZIP_URL"

# Unzip the file
echo "Unzipping the downloaded file..."
unzip "$ZIP_FILE" -d "theme_temp"

# Move the `ant-nubula` folder to the themes folder
echo "Copying $THEME_FOLDER to the themes directory..."
mkdir -p "$THEME_DEST_DIR"
cp -r "theme_temp/repo-main/$THEME_FOLDER" "$THEME_DEST_DIR"  # Adjust path if needed

# Clean up temporary files
echo "Cleaning up..."
rm -rf theme_temp "$ZIP_FILE"

echo "$THEME_FOLDER theme successfully copied to $THEME_DEST_DIR"

# Step 2: Install various packages
echo "Installing necessary packages..."
sudo apt update
sudo apt -y install vlc
sudo apt -y install git
sudo apt -y install libreoffice
sudo apt -y install unrar
sudo apt -y install snapd
sudo systemctl start snapd
sudo systemctl enable snapd --now
sudo snap install telegram-desktop

sudo apt update
sudo apt install leafpad
sudo apt-get install winff
sudo apt-get install brasero
sudo apt-get install gpick
sudo apt install ffmpeg

sudo apt install php8.2-fpm
sudo apt-get install php-xml
sudo apt-get install php-curl
sudo apt install nodejs npm
sudo apt install composer
sudo apt install okular

sudo apt install -y docker.io
sudo systemctl enable docker --now

sudo apt update
sudo apt install asterisk

sudo apt update
sudo snap install kubectl --classic
sudo systemctl enable ssh
sudo systemctl start ssh
sudo apt -y --fix-broken install
sudo apt update

# Step 3: Neovim configuration setup
# Define the URL for the init.vim file (replace with the actual URL)
INIT_VIM_URL="https://github.com/parsabe/parsabe/blob/main/conf/init.vim"  # Replace with the actual URL

# Define the Neovim config directory
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Create the config directory if it doesn't exist
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  echo "Creating Neovim configuration directory..."
  mkdir -p "$NVIM_CONFIG_DIR"
fi

# Download the init.vim file
echo "Downloading init.vim..."
curl -fLo "$NVIM_CONFIG_DIR/init.vim" --create-dirs "$INIT_VIM_URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "init.vim downloaded successfully."
else
  echo "Failed to download init.vim. Exiting..."
  exit 1
fi

# Automatically execute the installation or update command in Neovim
echo "Running Neovim to install or update plugins..."
nvim +PlugInstall +PlugUpdate +qa  # Adjust commands for your plugin manager

echo "Neovim setup complete!"
