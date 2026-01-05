# install proxy-setup

Set-up proxy settings for curl, apt etc.
You need to manually setup proxy in settings to have access to the Internet:
1. Network > Proxy > Manual > HTTPS Proxy: 
 - URL: ukd-proxy
 - Port: 80

2. Run in Terminal:
```bash
wget -qO- https://github.com/nucbio/proxy_setup/raw/main/install.sh | bash
```
