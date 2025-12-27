# Proxy

## Install Cntlm

TODO

In case your installation did not create a system unit, your can create one at `/etc/systemd/system/cntlm.service` with the following content:

```toml
[Unit]
Description=Cntlm Proxy Server
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/cntlm -P /run/cntlm.pid
PIDFile=/run/cntlm.pid
ExecStop= /usr/bin/killall -9 cntlm

[Install]
WantedBy=multi-user.target
```

## Configure Proxy

To configure the proxy in your system you need to adapt the following files and restart your system.

### /etc/environment

```
http_proxy=127.0.0.1:3128
https_proxy=127.0.0.1:3128
HTTP_PROXY=127.0.0.1:3128
HTTPS_PROXY=127.0.0.1:3128
```

### ~/.profile

```
export http_proxy=127.0.0.1:3128
export https_proxy=127.0.0.1:3128
export HTTP_PROXY=127.0.0.1:3128
export HTTPS_PROXY=127.0.0.1:3128
```

### /etc/apt/apt.conf (if you are on Ubuntu)

```
Acquire::http::Proxy "http://127.0.0.1:3128/";
Acquire::https::Proxy "http://127.0.0.1:3128/";
```

### /etc/yum.conf (if you are on CentOS/RHEL)

```
proxy=http://127.0.0.1:3128
```

Make sure permissions are correct:

```sh
sudo chmod 600 /etc/yum.conf
```