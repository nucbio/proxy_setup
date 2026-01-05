#!/bin/bash

# Setup proxy for system environment
PROXY_FILE="/etc/profile.d/proxy.sh"
if [ ! -f "$PROXY_FILE" ]; then
  echo '# proxy settings' | sudo tee "$PROXY_FILE"
fi
grep -q "http_proxy=" "$PROXY_FILE" || sudo tee -a "$PROXY_FILE" > /dev/null <<'EOF'
export http_proxy="http://ukd-proxy:80"
export https_proxy="http://ukd-proxy:80"
export ftp_proxy="http://ukd-proxy:80"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://ukd-proxy:80"
export HTTPS_PROXY="http://ukd-proxy:80"
export FTP_PROXY="http://ukd-proxy:80"
export NO_PROXY="127.0.0.1,localhost"
EOF
sudo chmod +x "$PROXY_FILE"
source "$PROXY_FILE"

# Setup GNOME system proxy
CURRENT_PROXY=$(gsettings get org.gnome.system.proxy mode 2>/dev/null)
if [ "$CURRENT_PROXY" != "'manual'" ]; then
    gsettings set org.gnome.system.proxy.http host 'ukd-proxy'
    gsettings set org.gnome.system.proxy.http port 80
    gsettings set org.gnome.system.proxy.https host 'ukd-proxy'
    gsettings set org.gnome.system.proxy.https port 80
    gsettings set org.gnome.system.proxy.ftp host 'ukd-proxy'
    gsettings set org.gnome.system.proxy.ftp port 80
    gsettings set org.gnome.system.proxy.socks host 'ukd-proxy'
    gsettings set org.gnome.system.proxy.socks port 80
    gsettings set org.gnome.system.proxy mode 'manual'
fi

# Setup proxy for apt
APT_PROXY_FILE="/etc/apt/apt.conf.d/80proxy"
if [ ! -f "$APT_PROXY_FILE" ] || ! grep -q "ukd-proxy" "$APT_PROXY_FILE"; then
    echo 'Acquire::http::proxy "http://ukd-proxy:80";
Acquire::https::proxy "http://ukd-proxy:80";
Acquire::ftp::proxy "ftp://ukd-proxy:80";' | sudo tee "$APT_PROXY_FILE" > /dev/null
    echo "APT proxy configured"
fi

# Setup proxy for wget
if ! grep -q "ukd-proxy" /etc/wgetrc 2>/dev/null; then
    echo 'use_proxy = on
http_proxy = http://ukd-proxy:80
https_proxy = http://ukd-proxy:80
ftp_proxy = http://ukd-proxy:80' | sudo tee -a /etc/wgetrc > /dev/null
    echo "wget proxy configured"
fi

# Setup proxy for snap
if command -v snap &> /dev/null; then
    sudo snap set system proxy.http="http://ukd-proxy:80"
    sudo snap set system proxy.https="http://ukd-proxy:80"
    echo "snap proxy configured"
fi

# Setup proxy in /etc/environment
if ! grep -q "ukd-proxy" /etc/environment 2>/dev/null; then
    echo 'http_proxy="http://ukd-proxy:80"
https_proxy="http://ukd-proxy:80"
ftp_proxy="http://ukd-proxy:80"
no_proxy="127.0.0.1,localhost"' | sudo tee -a /etc/environment > /dev/null
    echo "/etc/environment proxy configured"
fi

echo ""
echo "=== Proxy setup complete ==="
echo "Current environment variables:"
echo "http_proxy=$http_proxy"
echo "https_proxy=$https_proxy"
echo ""
echo "Note: You may need to log out and log back in for all changes to take effect."
