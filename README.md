# install proxy-setup

Set-up proxy settings on Ubuntu for curl, apt etc.  
You need to manually setup proxy in settings to have access to the Internet:
1. Network > Proxy > Manual > HTTPS Proxy:  
 - URL: ukd-proxy
 - Port: 80
Alternatively run from the terminal:  
```bash
gsettings set org.gnome.system.proxy.https host 'ukd-proxy'
gsettings set org.gnome.system.proxy.https port 80
gsettings set org.gnome.system.proxy mode 'manual'
```
2. Relogin to the Terminal
```bash
exit
```

3. Run in terminal Terminal:
```bash
wget -qO- https://github.com/nucbio/proxy_setup/raw/main/install.sh | bash
```

4. Relogin to run further setups
```bash
exit
```
