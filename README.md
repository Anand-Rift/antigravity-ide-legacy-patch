# Antigravity IDE - Legacy CPU Instruction Patcher 🚀🏎️

A standalone, automated utility script designed to patch the **Antigravity IDE** backend language server, allowing it to execute flawlessly on legacy `x86_64-v1` processor architectures (such as Intel Sandy Bridge, Ivy Bridge, AMD Phenom, etc.) that lack native modern instruction extensions like **AES-NI**.

---

## 🔍 The Problem & Why This Is Used

Modern development engines and language servers are frequently pre-compiled targeting modern x86 CPU instruction sets. 
* **The Symptom:** When launching Antigravity IDE on an older generation processor, the backend Go binary (`language_server_linux_x64`) instantly crashes on startup with an `Illegal instruction (core dumped)` or `SIGILL` signal.
* **The Reason:** The binary contains pre-compiled instruction pathways (specifically requiring `AES-NI` / `AVX` extensions) that older hardware transistors cannot physically interpret.

### 🛠️ The Surgical Bypass
This tool implements an elegant, zero-overhead hardware workaround:
1. It automatically detects your Linux distribution package manager (`pacman`, `apt`, or `dnf`).
2. It ensures `qemu-x86_64` (user-space emulation) is installed on your system.
3. It relocates the original crashing binary safely to `.orig`.
4. It injects a transparent, hyper-optimized bash wrapper execution hook that tells QEMU to spoof a fully featured modern CPU wrapper (`-cpu max`) in software right before running the server binary.

Because it utilizes **user-space emulation** rather than a heavy full-system virtual machine, it runs natively on your system at maximum performance, only translating the exact unmapped instructions when requested!

---

## 🚀 Usage Instructions

Getting up and running takes less than 10 seconds. Open your terminal and run the following commands:

```bash
curl -O [https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/patch_antigravity.sh](https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/patch_antigravity.sh)

chmod +x patch_antigravity.sh

./patch_antigravity.sh
```

#📜 Legal Disclaimer & Rights

⚠️ IMPORTANT NOTICE: * NOT ASSOCIATED WITH GOOGLE: This utility patch script is a completely independent, open-source project created by community developers. It is NOT an official product of Google LLC, nor is it endorsed, sponsored, or affiliated with Google in any capacity.
 NO COPYRIGHTED CODE DISTRIBUTED: This repository does not bundle, host, mirror, or distribute any proprietary closed-source application binaries or intellectual property belonging to Google.

HOW IT COMPLIES: This tool is purely a transparent deployment utility script that modifies files locally and entirely on the user's local machine under their explicit permission. You are responsible for complying with any application-specific End User License Agreements (EULA) regarding local environment configuration modifications.
