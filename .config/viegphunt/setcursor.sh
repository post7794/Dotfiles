#!/usr/bin/env bash

mkdir -p ~/.icons/default/
cat > ~/.icons/default/index.theme << 'EOF'
[icon theme]
Inherits=macOS
EOF
sudo rm -f /usr/share/icons/default/index.theme
sudo cp ~/.icons/default/index.theme /usr/share/icons/default/
