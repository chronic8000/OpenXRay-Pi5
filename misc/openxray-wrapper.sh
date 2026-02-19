#!/bin/bash
# Homeless Tech OpenXRay Launcher for Pi 5

# 1. Apply runtime tweaks
/usr/bin/rpi5_optimize.sh

# 2. V3D / Mesa Overrides
export v3d_debug=no_vpm_wait
export MESA_LOADER_DRIVER_OVERRIDE=zink

# 3. Launch with taskset to isolate Core 0 (System) and utilize 1-3 for Game
# We also use numactl to enforce interleaving for the process itself to be sure
taskset -c 1-3 numactl --interleave=all /usr/games/xr_3da "$@"
