# install proxy-setup

Set-up Dresden Technical University proxy settings on Ubuntu for system, curl, apt and snap.  
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
2. Exit and restart your shell:
```bash
exit
```

3. Run in the Terminal:
```bash
wget -qO- https://github.com/nucbio/proxy-setup/raw/main/install.sh | bash
```

4. Exit and restart your shell to run further setups:
```bash
exit
```

Jumpt to the [Ubuntu Setup](https://github.com/nucbio/ubuntu-setup).
