#!/bin/bash
clear
current_user=$(whoami)

echo "Install Jenkins on this EC2"
echo 
echo
sleep 2
sudo amazon-linux-extras install epel -y
sudo yum install -y wget curl git unzip
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum upgrade && sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo systemctl start jenkins

# testing if user jenkins exists
echo "Adding users to sudoers:"
if getent passwd jenkins > /dev/null 2>&1; then
    echo 'jenkins ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
else
    echo "No, the user jenkins does not exist"
fi

echo "Verify Jenkins is running:"
sudo systemctl status jenkins.service | grep -i active
echo
echo "Jenkins Installation done!"
echo
sleep 2
clear
echo "Installing Packer"
echo
echo
sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install packer
echo 
sleep 2
clear
echo
echo "Instaling Terraform"
echo
wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip
unzip terraform_*
sudo mv terraform /usr/local/bin/ && rm terraform_*
echo "Packer installation done!"
packer --version
echo "Terraform installation done!"
terraform version
echo
#sleep 2
echo "$current_user ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR="tee -a" visudo > /dev/null 2>&1
echo

# add some ls aliases

cp ~/.bashrc ~/.bashrc.bak
cat > ~/.bashrc <<"EOF"
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias jen='sudo su - jenkins -s /bin/bash'
EOF
source ~/.bashrc

echo "To login as jenkins user type: jen (you might need to logout)"

