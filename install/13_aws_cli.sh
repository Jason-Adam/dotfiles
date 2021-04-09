#!/bin/sh

set -e

curl https://awscli.amazonaws.com/AWSCLIV2.pkg -o "$HOME"/AWSCLIV2.pkg &&
    sudo installer -pkg "$HOME"/AWSCLIV2.pkg -target "$HOME"/

which aws
aws --version
