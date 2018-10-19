!#/bin/bash

rmmod pcspkr

systemctl restart dhpcpd

exec i3
