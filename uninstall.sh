#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}Empty Command Uninstaller${NC}"
echo "=============================="

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run as root or with sudo${NC}"
        exit 1
    fi
}

# Main uninstallation function
uninstall() {
    echo -e "${YELLOW}Uninstalling empty command...${NC}"
    
    # Remove binary
    if [ -f "/usr/local/bin/empty" ]; then
        rm -f /usr/local/bin/empty
        echo -e "${GREEN}Removed empty command${NC}"
    else
        echo -e "${YELLOW}empty command not found in /usr/local/bin${NC}"
    fi
    
    # Remove man page
    if [ -f "/usr/share/man/man1/empty.1.gz" ]; then
        rm -f /usr/share/man/man1/empty.1.gz
        echo -e "${GREEN}Removed man page${NC}"
    else
        echo -e "${YELLOW}Man page not found${NC}"
    fi
}

# Main uninstallation logic
main() {
    check_root
    uninstall

    # Verify uninstallation
    if command -v empty >/dev/null; then
        echo -e "${RED}Warning: empty command is still available in the system.${NC}"
        echo "Please remove it manually or contact support."
        exit 1
    else
        echo -e "${GREEN}Uninstallation successful!${NC}"
        echo -e "${YELLOW}The empty command has been removed from your system.${NC}"
    fi
}

# Run the uninstaller
main
