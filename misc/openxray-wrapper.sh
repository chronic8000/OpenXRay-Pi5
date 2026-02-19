#!/bin/bash
# Homeless Tech OpenXRay Launcher for Pi 5

# 1. Apply runtime tweaks
/usr/games/rpi5_optimize.sh

# 2. V3D / Mesa Overrides
export v3d_debug=no_vpm_wait
export MESA_LOADER_DRIVER_OVERRIDE=zink

# 3. Execution Root
cd /usr/share/stalker-pi5

# 4. Launch with taskset and NUMA interleaving
taskset -c 1-3 numactl --interleave=all /usr/games/xr_3da "$@"
