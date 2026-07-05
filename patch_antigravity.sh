
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
# Ayo! Why You Looking At Source code??? You dont trust me???? WTF.aNyWaY.
echo -e "${BLUE}===================================================${NC}"
echo -e "${BLUE}     Antigravity Language Server CPU Patch Tool    ${NC}"
echo -e "${BLUE}===================================================${NC}"

if ! command -v qemu-x86_64 &> /dev/null; then
    echo -e "${YELLOW}[!] qemu-x86_64 is not installed. Attempting to install it...${NC}"
    
    if [ -f /etc/arch-release ]; then
        echo -e "${BLUE}[*] Arch Linux detected. Installing qemu-user...${NC}"
        sudo pacman -Sy --needed --noconfirm qemu-user
    elif [ -f /etc/debian_version ]; then
        echo -e "${BLUE}[*] Debian/Ubuntu detected. Installing qemu-user-static...${NC}"
        sudo apt-get update && sudo apt-get install -y qemu-user-static
    elif [ -f /etc/fedora-release ]; then
        echo -e "${BLUE}[*] Fedora detected. Installing qemu-user...${NC}"
        sudo dnf install -y qemu-user
    else
        echo -e "${RED}[-][Error] Unsupported distribution. Please install 'qemu-user' or 'qemu-x86_64' manually and run this script again.${NC}"
        exit 1
    fi
fi
#Subscribe to BED-DESK-ARCHITECT on YOUTUBE!!!!
if command -v qemu-x86_64 &> /dev/null; then
    echo -e "${GREEN}[+] qemu-x86_64 is installed and ready.${NC}"
else
    echo -e "${RED}[-][Error] Failed to install qemu-x86_64. Please install it manually.${NC}"
    exit 1
fi

COMMON_PATHS=(
    "/opt/antigravity-ide/resources/app/extensions/antigravity/bin/language_server_linux_x64"
    "/usr/lib/antigravity-ide/resources/app/extensions/antigravity/bin/language_server_linux_x64"
    "$HOME/.local/share/antigravity-ide/resources/app/extensions/antigravity/bin/language_server_linux_x64"
)

TARGET_BIN=""

for path in "${COMMON_PATHS[@]}"; do
    if [ -f "$path" ] || [ -f "${path}.orig" ]; then
        TARGET_BIN="$path"
        break
    fi
done

if [ -z "$TARGET_BIN" ]; then
    echo -e "${YELLOW}[?] Could not find Antigravity installation in common locations.${NC}"
    read -p "Please enter the absolute path to your Antigravity 'language_server_linux_x64' binary: " user_path
    if [ -f "$user_path" ] || [ -f "${user_path}.orig" ]; then
        TARGET_BIN="$user_path"
    else
        echo -e "${RED}[-][Error] File not found at '$user_path'. Exiting.${NC}"
        exit 1
    fi
fi

BIN_DIR=$(dirname "$TARGET_BIN")
ORIG_BIN="${TARGET_BIN}.orig"

echo -e "${BLUE}[*] Target directory: $BIN_DIR${NC}"

if [ -f "$TARGET_BIN" ] && [ ! -f "$ORIG_BIN" ]; then
    echo -e "${BLUE}[*] Backing up and renaming original binary...${NC}"
    sudo mv "$TARGET_BIN" "$ORIG_BIN"
elif [ -f "$ORIG_BIN" ]; then
    echo -e "${YELLOW}[!] Original binary already backed up as $(basename "$ORIG_BIN").${NC}"
fi

echo -e "${BLUE}[*] Creating QEMU wrapper script...${NC}"

WRAPPER_TEMP=$(mktemp)
cat << 'EOF' > "$WRAPPER_TEMP"
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
exec qemu-x86_64 -cpu max "$DIR/language_server_linux_x64.orig" "$@"
EOF

sudo mv "$WRAPPER_TEMP" "$TARGET_BIN"
sudo chmod +x "$TARGET_BIN"
sudo chown root:root "$TARGET_BIN" 2>/dev/null || true

echo -e "${GREEN}[+] Patch successfully applied! Please restart your Antigravity IDE.${NC}"
echo -e "${BLUE}===================================================${NC}"
#Since you read all you should have realised its NOT A VIRUS BROTHER! .....
