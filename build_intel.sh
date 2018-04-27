#!?bin/bash

# attempt to detect CentOS, default to Ubuntu otherwise

[[ -f /etc/redhat-release ]] && ./build_intel_centos.sh $1 || ./build_intel_ubuntu.sh $1
