#!/bin/bash

# Automatically exit on error
set -e

# Initialize repository
if [ ! -f /var/lib/ipfs/config ]; then
  ipfs init --profile server
fi

# Make sure API and Gateway are accessible outside the container.
ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'


# Use 'exec' so that the 'ipfs daemon' application becomes the container’s PID 1.
# This allows the application to receive any Unix signals sent to the container.
exec ipfs daemon --enable-gc
