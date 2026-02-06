#!/usr/bin/env bash

# Exit on any error
set -e

# --- Configuration ---

GITHUB_ORG="TheBuildBox"
REPO_NAME="buildbox"
REPO_BRANCH="main"
BINARY_NAME="builbo"
BINARY_REPO_DIR="cli"
SOURCE_URL="https://raw.githubusercontent.com/${GITHUB_ORG}/${REPO_NAME}/${REPO_BRANCH}/${BINARY_REPO_DIR}/${BINARY_NAME}"
INSTALL_PREFIX="/usr/local"
INSTALL_BIN_DIR="${INSTALL_PREFIX}/bin"
INSTALL_PATH="/${INSTALL_BIN_DIR}/${BINARY_NAME}"

# Colors for terminal output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}==>${NC} Installing ${GREEN}builbo${NC} to ${INSTALL_BIN_DIR}..."

# 1. Download the script to a temporary location
TMP_FILE=$(mktemp)

if ! curl -fsSL "$SOURCE_URL" -o "$TMP_FILE"; then
    echo -e "${RED}Error:${NC} Download failed. Please check the source URL."
    exit 1
fi

# 2. Move and set permissions using sudo
echo -e "${BLUE}==>${NC} Requesting admin privileges to complete installation..."
sudo mv "$TMP_FILE" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

# 3. Final Verification
if command -v builbo >/dev/null 2>&1; then
    echo -e "${GREEN}==> Success!${NC} builbo is now installed."
    echo -e "Note: builbo requires ${BLUE}Docker${NC} or ${BLUE}Podman${NC} to run."
else
    echo -e "${RED}Error:${NC} Installation failed. Please ensure /usr/local/bin is in your \$PATH."
    exit 1
fi




