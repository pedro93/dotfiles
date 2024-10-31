#!/usr/bin/env bash
set -euo pipefail

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin*)
            echo "macos"
            ;;
        Linux*)
            echo "linux"
            ;;
        *)
            error "Unsupported operating system"
            ;;
    esac
}

# Backup existing configurations
backup_configs() {
    log "Backing up existing configurations..."
    mkdir -p "$BACKUP_DIR"
    
    # List of files to backup
    local files=(
        ~/.gitconfig
        ~/.gitignore_global
        ~/.bashrc
        ~/.zshrc
        ~/.vimrc
    )

    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            cp "$file" "$BACKUP_DIR/" || log "Failed to backup $file"
        fi
    done
    
    success "Backup completed at $BACKUP_DIR"
}

# Create symbolic links
create_symlinks() {
    log "Creating symbolic links..."
    
    # Git configuration
    ln -sf "$SCRIPT_DIR/configs/git/.gitconfig" "$HOME/.gitconfig"
    ln -sf "$SCRIPT_DIR/configs/git/.gitignore_global" "$HOME/.gitignore_global"
    
    # Shell configuration
    ln -sf "$SCRIPT_DIR/configs/shell/.bashrc" "$HOME/.bashrc"
    ln -sf "$SCRIPT_DIR/configs/shell/.zshrc" "$HOME/.zshrc"
    
    # Vim configuration
    ln -sf "$SCRIPT_DIR/configs/vim/.vimrc" "$HOME/.vimrc"
    
    # VSCode configuration (OS-specific paths)
    if [ "$(detect_os)" = "macos" ]; then
        VSCODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
    else
        VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
    fi
    
    mkdir -p "$VSCODE_CONFIG_DIR"
    ln -sf "$SCRIPT_DIR/configs/vscode/settings.json" "$VSCODE_CONFIG_DIR/settings.json"
    
    success "Symbolic links created"
}

# Main installation
main() {
    log "Starting installation..."
    
    # Backup existing configurations
    backup_configs
    
    # Create symbolic links
    create_symlinks
    
    # Run OS-specific setup
    local os_type=$(detect_os)
    if [ -f "$SCRIPT_DIR/setup/${os_type}-setup.sh" ]; then
        log "Running ${os_type}-specific setup..."
        bash "$SCRIPT_DIR/setup/${os_type}-setup.sh"
    fi
    
    # Run common setup
    log "Running common setup..."
    bash "$SCRIPT_DIR/setup/common-setup.sh"
    
    success "Installation completed successfully!"
}

main