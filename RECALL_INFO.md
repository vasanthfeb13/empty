# Recall System Documentation

## File Locations

1. **Recall Script Location:**
   ```
   /usr/local/lib/empty/recall.sh
   ```

2. **System-wide Alias Location:**
   ```
   /etc/profile.d/empty-recall.sh
   ```

## File Contents

### 1. recall.sh
```bash
#!/bin/bash
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${RED}The 'empty' command is not installed.${NC}"
echo -e "${YELLOW}To install, run:${NC}"
echo "git clone https://github.com/vasanthfeb13/empty.git"
echo "cd empty"
echo "sudo ./install.sh"

# Create a temporary alias that will show this message
alias empty="$0"
```

### 2. empty-recall.sh
```bash
alias empty='/usr/local/lib/empty/recall.sh'
```

## Example Output

When you try to use the `empty` command after uninstallation, you'll see:

```
The 'empty' command is not installed.
To install, run:
git clone https://github.com/vasanthfeb13/empty.git
cd empty
sudo ./install.sh
```

## How It Works

1. **During Uninstallation:**
   - The `empty --uninstall` command:
     1. Creates `/usr/local/lib/empty/recall.sh`
     2. Makes it executable
     3. Creates a system-wide alias in `/etc/profile.d/empty-recall.sh`
     4. Removes the original empty command

2. **After Uninstallation:**
   - When user types `empty`, the alias points to recall.sh
   - recall.sh displays the installation instructions
   - This works until the user reinstalls the command

3. **During Installation:**
   - The installer removes both recall files
   - Installs the actual command
   - The recall system is cleaned up

## Testing the System

1. **Install the command:**
   ```bash
   sudo ./install.sh
   ```

2. **Verify installation:**
   ```bash
   empty --help
   ```

3. **Uninstall using the command:**
   ```bash
   sudo empty --uninstall
   ```

4. **Verify recall system:**
   ```bash
   ls -l /usr/local/lib/empty/recall.sh
   ls -l /etc/profile.d/empty-recall.sh
   ```

5. **Try using the command:**
   ```bash
   empty
   ```
   You should see the installation instructions.

6. **Reinstall to test cleanup:**
   ```bash
   sudo ./install.sh
   ```
   This should remove the recall files and restore the command.
