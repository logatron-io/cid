#! /bin/bash
apt-get update 
apt-get install git-core curl build-essential openssl libssl-dev python -y
git clone https://github.com/nodejs/node.git
cd node
./configure
make
make install
node -v
curl -L https://npmjs.org/install.sh | sudo sh
npm -v
npm install -g npm 
npm install -g node-sass --force --unsafe-perm=true --allow-root 
npm install -g @angular/cli