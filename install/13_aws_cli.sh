#!/bin/sh

set -e

curl https://awscli.amazonaws.com/AWSCLIV2.pkg -o "$HOME"/AWSCLIV2.pkg &&
    sudo installer -pkg "$HOME"/AWSCLIV2.pkg -target "$HOME"/

# Install cdk
npm install -g aws-cdk

# Verify install
which aws
aws --version
