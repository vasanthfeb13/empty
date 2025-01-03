#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Empty Command Installer${NC}"
echo "=============================="

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run as root or with sudo${NC}"
        exit 1
    fi
}

# Function to detect package manager
detect_system() {
    if command -v apt-get >/dev/null; then
        echo "debian"
    elif command -v dnf >/dev/null || command -v yum >/dev/null; then
        echo "redhat"
    else
        echo "unknown"
    fi
}

# Install for Debian/Ubuntu systems
install_deb() {
    echo -e "${YELLOW}Installing for Debian/Ubuntu...${NC}"
    if [ -f "empty-command.deb" ]; then
        dpkg -i empty-command.deb
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Installation successful!${NC}"
        else
            echo -e "${RED}Installation failed!${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: empty-command.deb not found!${NC}"
        exit 1
    fi
}

# Install for RedHat/Fedora systems
install_rpm() {
    echo -e "${YELLOW}Installing for RedHat/Fedora...${NC}"
    if [ -f "empty-1.0-1.aarch64.rpm" ]; then
        rpm -i empty-1.0-1.aarch64.rpm
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Installation successful!${NC}"
        else
            echo -e "${RED}Installation failed!${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: empty-1.0-1.aarch64.rpm not found!${NC}"
        exit 1
    fi
}

# Main installation logic
main() {
    check_root
    system_type=$(detect_system)
    
    case $system_type in
        "debian")
            install_deb
            ;;
        "redhat")
            install_rpm
            ;;
        *)
            echo -e "${RED}Unsupported system. Please install manually.${NC}"
            echo "Supported systems: Debian/Ubuntu, RedHat/Fedora"
            exit 1
            ;;
    esac

    # Verify installation
    if command -v empty >/dev/null; then
        echo -e "${GREEN}Empty command is now installed!${NC}"
        echo "Try it out with: empty --help"
    else
        echo -e "${RED}Installation might have failed. Please check the errors above.${NC}"
        exit 1
    fi
}

# Run the installer
main
