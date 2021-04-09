#!/bin/sh

set -e

cd "$HOME" &&
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" &&
    sudo installer -pkg AWSCLIV2.pkg -target /

which aws
aws --version
