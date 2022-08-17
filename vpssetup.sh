#!/bin/bash
# This script will setup a VPS server with the following features:
# - Basic server setup
# - Oh My Zsh
# - zsh-syntax-highlighting
# - zsh-autosuggestions
# - Powerlevel10k theme
# - Chinese Locale
# - nvm
# - mosh
# - Firewall Configuration

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install packages
sudo apt-get install -y git zsh zsh-syntax-highlighting zsh-autosuggestions language-pack-zh-hans docker.io docker-compose nginx python3-pip python3-dev mosh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh-syntax-highlighting and zsh-autosuggestions
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Configure Chinese locale
sudo cat << EOF > /etc/default/locale
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh"
LC_NUMERIC="zh_CN"
LC_TIME="zh_CN"
LC_MONETARY="zh_CN"
LC_PAPER="zh_CN"
LC_NAME="zh_CN"
LC_ADDRESS="zh_CN"
LC_TELEPHONE="zh_CN"
LC_MEASUREMENT="zh_CN"
LC_IDENTIFICATION="zh_CN"
LC_ALL="zh_CN.UTF-8"
EOF

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Configure the firewall
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 60000:61000/udp comment "mosh"
sudo ufw enable