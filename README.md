# raspberrypi-os-cis-hardening
# Hardened Raspberry Pi OS Image

This project provides a **security-hardened Raspberry Pi OS image** based on the [CIS Debian Linux Benchmark](https://www.cisecurity.org/benchmark/debian_linux) and real-world experience in securing Linux-based embedded systems.

## ✨ Features
- Configured according to CIS Level 1 security guidance
- Custom hardening for Raspberry Pi-specific services (SSH, GPIO, camera, etc.)
- Minimal footprint with optional packages for secure IoT deployments
- Disabled unneeded services and default credentials
- Firewall (UFW), Fail2Ban, and other security tools pre-configured

## 📚 Documentation
See the `docs/` folder for detailed guides.

## ⚠️ Disclaimer
This project is **not affiliated with or certified by CIS (Center for Internet Security)**.

> This Raspberry Pi image is based on the recommendations from the [CIS Debian Linux Benchmark] and real-world implementation experience.  
> It does **not include** any copyrighted content from CIS.  
> This image is provided "as-is", and the authors make no warranties about its suitability or completeness.

## 📦 Image Download
Releases are available in the GitHub [Releases section](../../releases).

## 🔐 License
This project is licensed under the MIT License. See `LICENSE` for details.
