#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print test result
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
        exit 1
    fi
}

echo -e "${YELLOW}Running Empty Command Tests${NC}"
echo "=============================="

# Test 1: Installation
echo -e "\n${YELLOW}Test 1: Installation${NC}"
sudo ./install.sh
print_result $? "Installation"

# Test 2: Help command
echo -e "\n${YELLOW}Test 2: Help Command${NC}"
empty --help | grep "Usage: empty"
print_result $? "Help command shows usage"

# Test 3: Empty a file
echo -e "\n${YELLOW}Test 3: Empty File${NC}"
empty tests/test.txt
if [ ! -s tests/test.txt ]; then
    print_result 0 "File emptied successfully"
else
    print_result 1 "File not emptied"
fi

# Test 4: Empty a directory
echo -e "\n${YELLOW}Test 4: Empty Directory${NC}"
empty tests/testdir
if [ -z "$(ls -A tests/testdir)" ]; then
    print_result 0 "Directory emptied successfully"
else
    print_result 1 "Directory not emptied"
fi

# Test 5: Uninstall command
echo -e "\n${YELLOW}Test 5: Uninstall Command${NC}"
sudo empty --uninstall
print_result $? "Uninstall command"

# Test 6: Verify recall script
echo -e "\n${YELLOW}Test 6: Verify Recall Script${NC}"
if [ -f "/usr/local/lib/empty/recall.sh" ] && [ -f "/etc/profile.d/empty-recall.sh" ]; then
    print_result 0 "Recall scripts created"
else
    print_result 1 "Recall scripts not found"
fi

# Test 7: Try empty command after uninstall
echo -e "\n${YELLOW}Test 7: Empty Command After Uninstall${NC}"
echo "Running 'empty' command (should show installation instructions):"
source /etc/profile.d/empty-recall.sh
empty

# Test 8: Reinstallation
echo -e "\n${YELLOW}Test 8: Reinstallation${NC}"
sudo ./install.sh
print_result $? "Reinstallation"

# Test 9: Verify recall scripts removed
echo -e "\n${YELLOW}Test 9: Verify Recall Scripts Removed${NC}"
if [ ! -f "/usr/local/lib/empty/recall.sh" ] && [ ! -f "/etc/profile.d/empty-recall.sh" ]; then
    print_result 0 "Recall scripts removed"
else
    print_result 1 "Recall scripts still exist"
fi

echo -e "\n${GREEN}All tests completed successfully!${NC}"
