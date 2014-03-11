#!/bin/bash
    
export DOCKER_IP=`ip route | grep default | awk '{print $3}'`

export ETCD_URL=`env | grep -E 'ETCD_PORT=' | sed 's/ETCD_PORT=tcp:\/\// /g' | awk '{print "http://"$1}'`
    
### Setup the ssh keys
SSH_PUB_KEY=`curl -L $ETCD_URL/v2/keys/$APP/ssh/public_key | jq -r '.node.value'`
SSH_PRI_KEY=`curl -L $ETCD_URL/v2/keys/$APP/ssh/private_key | jq -r '.node.value'`
    
echo "$SSH_PUB_KEY" > /root/.ssh/id_rsa.pub
echo "$SSH_PRI_KEY" > /root/.ssh/id_rsa
    
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
    
 ## Setup the environment variables
export GIT_URL=`curl -L $ETCD_URL/v2/keys/$APP/git_url | jq -r '.node.value'`
export DB_NAME=`curl -L $ETCD_URL/v2/keys/mysql/$APP/db | jq -r '.node.value'`
export DB_USER=`curl -L $ETCD_URL/v2/keys/mysql/$APP/user | jq -r '.node.value'`
export DB_PASS=`curl -L $ETCD_URL/v2/keys/mysql/$APP/passwd | jq -r '.node.value'`
export DB_HOST=`curl -L $ETCD_URL/v2/keys/mysql/$APP/host | jq -r '.node.value'`
