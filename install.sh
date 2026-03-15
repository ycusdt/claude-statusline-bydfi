#!/bin/bash
# Claude Code Statusline API Stats Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/Woaiyc121/claude-statusline-bydfi/main/install.sh | bash

set -e

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_NAME="api-stats"
SETTINGS_FILE="$HOME/.claude/settings.json"
REPO_URL="https://raw.githubusercontent.com/Woaiyc121/claude-statusline-bydfi/main"

echo "🔧 Installing Claude Code Statusline API Stats..."

# Create install directory
mkdir -p "$INSTALL_DIR"

# Download the main script
echo "📥 Downloading api-stats script..."
curl -fsSL "${REPO_URL}/${SCRIPT_NAME}" -o "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip3 install cloudscraper --quiet 2>/dev/null || pip install cloudscraper --quiet 2>/dev/null || {
    echo "⚠️  Could not install cloudscraper automatically. Please run: pip3 install cloudscraper"
}

# Check if ccusage is installed
if ! command -v ccusage &> /dev/null; then
    echo "⚠️  ccusage not found. Installing..."
    npm install -g ccusage 2>/dev/null || {
        echo "⚠️  Could not install ccusage. Please install manually: npm install -g ccusage"
    }
fi

# Update Claude Code settings
if [ -f "$SETTINGS_FILE" ]; then
    echo "⚙️  Updating Claude Code settings..."
    # Backup existing settings
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"

    # Use Python to update JSON
    python3 << EOF
import json
import os

settings_file = os.path.expanduser("$SETTINGS_FILE")
with open(settings_file, 'r') as f:
    settings = json.load(f)

settings['statusLine'] = {
    'type': 'command',
    'command': '$INSTALL_DIR/$SCRIPT_NAME'
}

with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=2)

print("✅ Settings updated")
EOF
else
    echo "⚙️  Creating Claude Code settings..."
    mkdir -p "$HOME/.claude"
    cat > "$SETTINGS_FILE" << EOF
{
  "model": "opus",
  "statusLine": {
    "type": "command",
    "command": "$INSTALL_DIR/$SCRIPT_NAME"
  }
}
EOF
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Edit $INSTALL_DIR/$SCRIPT_NAME"
echo "   2. Update the API_ID variable with your API ID"
echo "   3. Restart Claude Code to see the new statusline"
echo ""
echo "📊 Expected output format:"
echo "   🤖 Opus 4.6 | 🧠 19,236 (10%) | 💰 \$2.55 today / \$18.78 used / \$281.22 left | 📥 5.3M in / 📤 82K out"
