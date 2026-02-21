#!/bin/bash
# Set default workspace for code-server
echo "Setting default workspace to /vscode/projects"

# Create workspace settings directory
mkdir -p /config/data/User/workspaceStorage

# Create a recently opened file to set default workspace
mkdir -p /config/data/User/globalStorage
cat > /config/data/User/globalStorage/storage.json << 'EOF'
{
    "lastKnownMenubarData": {},
    "openedPathsList": {
        "workspaces3": [],
        "files2": []
    }
}
EOF

# Create user settings
mkdir -p /config/data/User
cat > /config/data/User/settings.json << 'EOF'
{
    "workbench.startupEditor": "none",
    "window.restoreWindows": "none"
}
EOF

# Set ownership
chown -R abc:abc /config/data/User
chown -R abc:abc /config/data/User/globalStorage

echo "Default workspace configured successfully"
