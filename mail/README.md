# Mail

## create user

```
# adduser george
# adduser george sudo
# adduser george adm

# mkdir /home/george/.ssh
# chmod 700 /home/george/.ssh
# cp .ssh/authorized_keys /home/george/.ssh/
# chmod 644 /home/george/.ssh/authorized_keys
# chown -R george:george /home/george/.ssh/
```

## sudo config

```
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL
```

## backup

```
$ ssh mail sudo tar -cvz /home/george/config > /tmp/config.tar.gz \
    && ssh mail sudo tar -cvz /var/lib/docker/volumes/george_maildata > /tmp/george_maildata.tar.gz \
    && ssh mail sudo tar -cvz /var/lib/docker/volumes/george_mailstate > /tmp/george_mailstate.tar.gz
```

```
$ pv /tmp/config.tar.gz | ssh mail "tar xzf - -C /" \
    && pv /tmp/george_maildata.tar.gz | ssh mail "sudo tar xzf - -C /" \
    && pv /tmp/george_mailstate.tar.gz | ssh mail "sudo tar xzf - -C /"
```

## certbot

```
$ sudo certbot certonly --standalone -d example.com
```

## zram

```
$ sudo apt install linux-modules-extra-5.15.0-71-generic
$ sudo apt -install systemd-zram-generator
$ sudo systemctl start /dev/zram0
$ sudo reboot
```
