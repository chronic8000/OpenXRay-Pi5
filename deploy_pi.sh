#!/bin/bash
# Homeless Tech OpenXRay Pi5 Deployment Script

PI_IP="192.168.18.23"
PI_USER="chronic"
PI_PASS="Winblows2k!!"
REMOTE_DIR="~/openxray-pi5-build"

echo "[1/4] Syncing codebase to Pi 5 via rsync..."
sshpass -p "$PI_PASS" ssh -o StrictHostKeyChecking=no $PI_USER@$PI_IP "mkdir -p $REMOTE_DIR"
sshpass -p "$PI_PASS" rsync -azv --exclude='.git' --exclude='build' --exclude='bin' ./ $PI_USER@$PI_IP:$REMOTE_DIR/

echo "[2/4] Installing dependencies on Pi 5..."
sshpass -p "$PI_PASS" ssh $PI_USER@$PI_IP "echo '$PI_PASS' | sudo -S apt-get update && echo '$PI_PASS' | sudo -S apt-get install -y cmake build-essential libglew-dev libegl1-mesa-dev libgles2-mesa-dev libopenal-dev libcrypto++-dev libfreeimage-dev libfreeimageplus-dev libogg-dev libtheora-dev libvorbis-dev liblzo2-dev libjpeg-dev libncurses5-dev gcc-14 g++-14 libpcre3-dev libsdl2-dev debhelper numactl"

echo "[3/4] Starting Homeless Tech Optimized Build..."
sshpass -p "$PI_PASS" ssh $PI_USER@$PI_IP "cd $REMOTE_DIR && mkdir -p build && cd build && cmake .. -DCMAKE_C_COMPILER=gcc-14 -DCMAKE_CXX_COMPILER=g++-14 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON -DNEW_DYNAREC=ON -DOPTIMIZED=ON && make -j$(nproc)"

echo "[4/4] Generating Debian Package..."
sshpass -p "$PI_PASS" ssh $PI_USER@$PI_IP "cd $REMOTE_DIR && dpkg-buildpackage -b -uc -us"

echo "------------------------------------------------------------"
echo "DEPLOYMENT COMPLETE: The .deb package should be ready in the parent directory."
echo "------------------------------------------------------------"
