# S.T.A.L.K.E.R. OpenXRay: Ultimate "Homeless Tech" RPi5 Build

Welcome to the **Silicon Whisperer Edition** of OpenXRay, specifically engineered and optimized for the Raspberry Pi 5. This release brings desktop-class S.T.A.L.K.E.R. performance to the ARM64 platform with silicon-level tuning.

![Homeless Tech Splash](res/logo.bmp)

---

## 🚀 Key Optimizations

This isn't just a generic compile. We've gone deep into the silicon to squeeze every bit of performance out of the Broadcom BCM2712:

*   **16KB Page Alignment**: Re-linked core engine binaries to support the Pi 5's 16KB-paged kernel natively.
*   **SSE2NEON SIMD Port**: Full translation of x86 SIMD intrinsics to native ARM NEON instructions for maximum throughput.
*   **Real-time Threading**: NPC A-Life thread priority elevated to `SCHED_RR` for fluid world interactions.
*   **Silicon Whisperer Tuner**: Custom scripts to override BIOS/Kernel constraints (`SDRAM_BANKLOW`, `NUMA` interleaving, `IOMMU` policy).
*   **V3D Overrides**: Tuned Mesa V3D driver hints for reduced stutter and improved frame pacing.

---

## 📦 Installation

To experience the ultimate build, you need to install **both** generated Debian packages. The optimized engine package depends on the data package for branded assets and system-level configuration.

1.  **Download the latest release** from the [GitHub Releases](https://github.com/chronic8000/OpenXRay-Pi5/releases) page.
2.  **Install the packages**:
    ```bash
    sudo dpkg -i stalker-pi5-optimized.deb stalker-pi5-data.deb
    sudo apt-get install -f  # To resolve any missing dependencies
    ```
3.  **Run the Silicon Tuner** (Highly Recommended):
    ```bash
    stalker-pi5-optimize
    ```
    *Note: This will modify your `/boot/firmware/config.txt` for bandwidth optimizations and may require a reboot.*

---

## 🎮 Launching the Game

Simply click the **S.T.A.L.K.E.R.** icon in your Games menu, or run it from the terminal via the Silicon Whisperer wrapper:
```bash
stalker-pi5-wrapper
```

---

## 🛠 Build Technicals

*   **Compiler**: GCC 14.2 / G++ 14.2
*   **Architecture**: ARM64 (Cortex-A76 Optimized)
*   **Page Size**: 16KB Native
*   **Memory Allocator**: Standard (malloc) for stability on RPi5 memory architecture.

---

## ❤️ Credits & Support

Brought to you by **Homeless Tech**. 
Check out the building process and support the project on YouTube:
[Homeless Tech YouTube Channel](https://youtube.com/@HomelessTech)

*Special thanks to the OpenXRay team for the incredible engine foundation.*

---

### Disclaimer
*S.T.A.L.K.E.R.: Call of Pripyat assets are required to play. This repository contains the engine and optimization scripts only.*
