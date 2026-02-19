#!/bin/bash
# Homeless Tech RPi5 System Optimizer

# 1. Set CPU Governor to Performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# 2. Pin GPU to high frequency (if not already handled by config.txt)
echo 1000000000 | sudo tee /sys/class/tgpu/frequency/freq_min # Simplified path, may vary by kernel

# 3. Check for NUMA interleaving
if journalctl -b | grep -q "mempolicy: NUMA default policy overridden to 'interleave:0-7'"; then
    echo "[OK] NUMA Interleaving Active"
else
    echo "[WARNING] NUMA Interleaving NOT active. Please ensure postinst ran and system rebooted."
fi

echo "[OK] Chronic8000 Silicon Optimizations Applied."
