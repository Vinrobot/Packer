#!/bin/bash

set -exuo pipefail

# Add user 'administrator' to group 'docker'
usermod -aG docker administrator
