#!/usr/bin/env bash

set -e;

# Install Gcloud SDK
gcloud_sdk() {
	curl https://sdk.cloud.google.com | bash;
}

gcloud_sdk;
