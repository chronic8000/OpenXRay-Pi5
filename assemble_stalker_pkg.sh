#!/bin/bash
set -ex

# Base directories
BUILD_ROOT=~/openxray-pi5-build
PKG_ROOT=~/stalker-pi5-optimized-pkg
DATA_PKG_ROOT=~/stalker-pi5-data-pkg

# 1. Clear previous roots
rm -rf $PKG_ROOT $DATA_PKG_ROOT
mkdir -p $PKG_ROOT/usr/lib/aarch64-linux-gnu
mkdir -p $PKG_ROOT/usr/games
mkdir -p $PKG_ROOT/usr/share/applications
mkdir -p $PKG_ROOT/DEBIAN

mkdir -p $DATA_PKG_ROOT/usr/share/stalker-pi5
mkdir -p $DATA_PKG_ROOT/DEBIAN

# 2. Copy optimized binaries (Manual build output)
BI_DIR=$BUILD_ROOT/bin/aarch64/Release
cp $BI_DIR/*.so $PKG_ROOT/usr/lib/aarch64-linux-gnu/
cp $BI_DIR/xr_3da $PKG_ROOT/usr/games/

# 3. Copy wrappers and scripts
cp $BUILD_ROOT/misc/openxray-wrapper.sh $PKG_ROOT/usr/games/
cp $BUILD_ROOT/misc/rpi5_optimize.sh $PKG_ROOT/usr/games/
chmod +x $PKG_ROOT/usr/games/*

# 4. Copy desktop entries
cp $BUILD_ROOT/misc/linux/*.desktop $PKG_ROOT/usr/share/applications/

# 5. Create Opt Package Control
cat << 'EOC' > $PKG_ROOT/DEBIAN/control
Package: stalker-pi5-optimized
Version: 1.6.02-homeless-tech-1
Architecture: arm64
Maintainer: Homeless Tech <https://youtube.com/@HomelessTech>
Depends: numactl, stalker-pi5-data (= 1.6.02-homeless-tech-1)
Section: games
Priority: optional
Description: Ultimate Homeless Tech Optimized OpenXRay Build for RPi5
 Silicon-level memory tuning, 16KB page alignment, and real-time A-Life threading.
EOC

# 6. Create Data Package Control
cat << 'EOD' > $DATA_PKG_ROOT/DEBIAN/control
Package: stalker-pi5-data
Version: 1.6.02-homeless-tech-1
Architecture: all
Maintainer: Homeless Tech <https://youtube.com/@HomelessTech>
Section: games
Priority: optional
Description: Data assets for Homeless Tech Optimized OpenXRay Build
 Includes branded splash and filesystem configurations.
EOD

# 7. Copy Data Assets
cp $BUILD_ROOT/res/logo.bmp $DATA_PKG_ROOT/usr/share/stalker-pi5/
find $BUILD_ROOT -name fsgame.ltx -exec cp {} $DATA_PKG_ROOT/usr/share/stalker-pi5/ \;

# 8. Set Permissions
chmod -R 755 $PKG_ROOT
chmod -R 755 $DATA_PKG_ROOT

# 9. Build Packages
dpkg-deb --build $PKG_ROOT ~/stalker-pi5-optimized.deb
dpkg-deb --build $DATA_PKG_ROOT ~/stalker-pi5-data.deb

echo "SUCCESS: Packages assembled in home directory."
