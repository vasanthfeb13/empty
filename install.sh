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

# Main installation function
install() {
    echo -e "${YELLOW}Installing empty command...${NC}"
    
    # Create necessary directories
    mkdir -p /usr/local/bin
    mkdir -p /usr/share/man/man1
    
    # Install the main script
    if [ -f "empty" ]; then
        cp empty /usr/local/bin/
        chmod +x /usr/local/bin/empty
        echo -e "${GREEN}Installed empty command to /usr/local/bin/empty${NC}"
    else
        echo -e "${RED}Error: empty script not found!${NC}"
        exit 1
    fi
    
    # Install man page
    if [ -f "empty.1" ]; then
        cp empty.1 /usr/share/man/man1/
        gzip -f /usr/share/man/man1/empty.1
        echo -e "${GREEN}Installed man page${NC}"
    else
        echo -e "${YELLOW}Warning: man page not found, skipping...${NC}"
    fi
}

# Main installation logic
main() {
    check_root
    install

    # Verify installation
    if command -v empty >/dev/null; then
        echo -e "${GREEN}Installation successful!${NC}"
        echo -e "${YELLOW}Try it out with: ${NC}empty --help"
    else
        echo -e "${RED}Installation failed. Please check the errors above.${NC}"
        exit 1
    fi
}

# Run the installer
main
