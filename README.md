## Antigravity IDE Patch - made this bc it crashed on my core i3 2350m,,,

A standalone, automated utility script designed to patch the **Antigravity IDE** backend language server, allowing it to execute flawlessly on legacy `x86_64-v1` processor architectures (such as Intel Sandy Bridge, Ivy Bridge, AMD Phenom, etc.) that lack native modern instruction extensions like **AES-NI**.

---

##  The Problem & Why This Is Used

Modern  language servers are frequently pre-compiled targeting modern x86 CPU instruction sets. 
* **The Symptom:** When launching Antigravity IDE on an older generation processor, the backend Go binary (`language_server_linux_x64`) instantly crashes on startup with an `Illegal instruction (core dumped)` or `SIGILL` signal.
* **The Reason:** The binary contains pre-compiled instruction pathways (specifically requiring `AES-NI`) that older hardware cannot use fuck google (joking)....

###  the tool ... what to name this point?..yo i forgot lol.... 
1. It automatically detects your Linux distribution package manager (`pacman`, `apt`, or `dnf` anything else idk it will not work).
2. It ensures `qemu-x86_64` (user-space emulation) is installed on your system.
3. It relocates the original crashing binary safely to `.orig` (dont gonna nuke your system).
4. It injects a transparent, hyper-optimized bash wrapper execution hook that tells QEMU to spoof a fully featured modern CPU wrapper (`-cpu max`) in software right before running the server binary (bro spoofing is the 2nd thing i do all day. running infinite google photos on my phone lol).

Because it utilizes **user-space emulation** rather than a heavy full-system virtual machine, it runs natively on your system at maximum performance, only translating the exact unmapped instructions when requested!
---
too much work broo
##  Usage Instructions

Getting up and running takes less than 10 seconds. Open your terminal and run the following commands:

```bash
curl -sSL https://raw.githubusercontent.com/Anand-Rift/antigravity-ide-legacy-patch/main/patch_antigravity.sh | bash
```
Subscribe to Anand-Rift
