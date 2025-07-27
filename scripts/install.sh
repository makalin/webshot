#!/bin/bash

# WebShot Installation Script
# This script installs WebShot on various platforms

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "linux";;
        Darwin*)    echo "darwin";;
        CYGWIN*)    echo "windows";;
        MINGW*)     echo "windows";;
        MSYS*)      echo "windows";;
        *)          echo "unknown";;
    esac
}

# Function to detect architecture
detect_arch() {
    case "$(uname -m)" in
        x86_64)     echo "amd64";;
        aarch64)    echo "arm64";;
        arm64)      echo "arm64";;
        armv7l)     echo "arm";;
        *)          echo "unknown";;
    esac
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to download and install WebShot
install_webshot() {
    local os=$1
    local arch=$2
    local version=${3:-"latest"}
    
    print_status "Installing WebShot for $os/$arch..."
    
    # Create temporary directory
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # Download WebShot
    local download_url="https://github.com/makalin/webshot/releases/$version/download/webshot-$os-$arch"
    if [[ "$os" == "windows" ]]; then
        download_url="$download_url.exe"
    fi
    
    print_status "Downloading from: $download_url"
    
    if command_exists curl; then
        curl -L -o webshot "$download_url"
    elif command_exists wget; then
        wget -O webshot "$download_url"
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
    
    # Make executable
    chmod +x webshot
    
    # Install to system
    local install_dir="/usr/local/bin"
    if [[ "$os" == "windows" ]]; then
        install_dir="/c/Windows/System32"
    fi
    
    if [[ ! -w "$install_dir" ]]; then
        print_warning "Cannot write to $install_dir, trying user directory..."
        install_dir="$HOME/.local/bin"
        mkdir -p "$install_dir"
    fi
    
    mv webshot "$install_dir/webshot"
    
    # Clean up
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    print_success "WebShot installed to $install_dir/webshot"
    
    # Add to PATH if needed
    if [[ ":$PATH:" != *":$install_dir:"* ]]; then
        print_warning "Please add $install_dir to your PATH"
        if [[ "$os" == "darwin" ]]; then
            echo "Add this line to your ~/.zshrc or ~/.bash_profile:"
            echo "export PATH=\"$install_dir:\$PATH\""
        elif [[ "$os" == "linux" ]]; then
            echo "Add this line to your ~/.bashrc:"
            echo "export PATH=\"$install_dir:\$PATH\""
        fi
    fi
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    # Check for Chrome/Chromium
    if command_exists google-chrome; then
        print_success "Google Chrome found"
    elif command_exists chromium-browser; then
        print_success "Chromium found"
    elif command_exists chromium; then
        print_success "Chromium found"
    elif [[ "$(detect_os)" == "darwin" ]] && [[ -d "/Applications/Google Chrome.app" ]]; then
        print_success "Google Chrome found"
    else
        print_warning "Chrome/Chromium not found. Please install it for WebShot to work."
        print_status "Installation instructions:"
        echo "  - macOS: brew install --cask google-chrome"
        echo "  - Ubuntu: sudo apt install chromium-browser"
        echo "  - CentOS: sudo yum install chromium"
    fi
}

# Main installation function
main() {
    print_status "WebShot Installation Script"
    print_status "============================"
    
    # Detect OS and architecture
    local os=$(detect_os)
    local arch=$(detect_arch)
    
    if [[ "$os" == "unknown" ]]; then
        print_error "Unsupported operating system"
        exit 1
    fi
    
    if [[ "$arch" == "unknown" ]]; then
        print_error "Unsupported architecture"
        exit 1
    fi
    
    print_status "Detected: $os/$arch"
    
    # Check if already installed
    if command_exists webshot; then
        print_warning "WebShot is already installed"
        read -p "Do you want to reinstall? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
    fi
    
    # Check dependencies
    check_dependencies
    
    # Install WebShot
    install_webshot "$os" "$arch"
    
    # Test installation
    print_status "Testing installation..."
    if webshot --version > /dev/null 2>&1; then
        print_success "Installation successful!"
        print_status "Try: webshot --help"
    else
        print_error "Installation failed. Please check the error messages above."
        exit 1
    fi
}

# Run main function
main "$@" 