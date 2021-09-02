#!/bin/bash

### INSTALL FIRST
### XCODE WITH COMMAND LINE TOOLS
### JAVA 11, MAMP 5.7, SEQUEL PRO AND PGSQL 13
### CHANGE TO ZSH: chsh -s /bin/zsh

git config --global user.name "Me"
git config --global user.email "me@me.com"
git config --global init.defaultBranch main

### nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

### maven
curl -L https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o maven.tar.gz
sudo tar xf maven.tar.gz -C /usr/local
sudo ln -s /usr/local/apache-maven-3.6.3 /usr/local/maven

cat > /Applications/MAMP/conf/my.cnf << 'EOF'
# SQL_MODE for MSP development
[mysqld]
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
EOF

### oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
