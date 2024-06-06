#!/bin/bash

echo Installing SDK
curl -s "https://get.sdkman.io" | bash
source "/home/ec2-user/.sdkman/bin/sdkman-init.sh"
echo sdk install java ${JAVA_VERSION}
sdkman_auto_answer=true sdk install java ${JAVA_VERSION}
echo Java installed
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo Rust installed
source $HOME/.cargo/env
sudo yum install -y git make gcc
git clone https://github.com/apache/datafusion-comet.git
echo Datafusion cloned
cd datafusion-comet
git reset --hard ${COMET_VERSION}
make release PROFILES="-Pspark-${SPARK_VERSION}"
