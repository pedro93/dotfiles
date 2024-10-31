# Development Environment Setup

This is my personal repository that contains scripts and configurations for setting up a consistent development environment across different machines. 

## Features

- 🔄 Automated setup for Linux and macOS
- 💾 Automatic backup of existing configurations
- ⚙️ Modular configuration management
- 🔗 Symbolic linking of config files
- 📦 Package installation for common development tools

## Prerequisites

- Git
- Bash
- curl or wget
- Administrative privileges for package installation

## Quick Start

```bash
# Clone the repository
git clone https://github.com/pedro93/dotfiles.git
cd dotfiles

# Run the installation script
./install.sh
```

## Directory Structure

- `install.sh`: Main installation script
- `setup/`: OS-specific and common setup scripts
- `configs/`: Configuration files for various tools
- `scripts/`: Utility scripts for backup and sync

## Configuration

### Adding New Tools

1. Create a new directory under `configs/` for your tool
2. Add configuration files
3. Update `install.sh` to create appropriate symbolic links

### Customizing for Your Team

1. Fork this repository
2. Modify the configurations and scripts as needed
3. Update the README with team-specific instructions

## Maintenance

### Backing Up Configurations

```bash
./scripts/backup.sh
```

### Syncing Changes

```bash
./scripts/sync.sh
```

### Restoring from Backup

```bash
./scripts/restore.sh 
```

## License

MIT License - feel free to modify and share!