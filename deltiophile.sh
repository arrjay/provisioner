# linode
echo 'delti.ophile.us' > /etc/sysconfig/network
hostname delti.ophile.us

mkdir /root/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3OueMyB4NBGlHBdgN3BjVcq+eTQ3zhjMFUE1Kmn8gPupqwrQdZavSAkzsvuFl9XD2rvaoJxc/WGpsBd9zfkGLt2MrrvKzaGhBs2uOoZoT1/TTrWdv4F3FrEYO6+F49n0tKFX6OHR711H/0AmqLE1pNh37rqDIV9y4QUCpa/dg51KbCcDhtq9mKvRmoVLUYkRNPGgcWK1CTGT3uQ5IZwQSR2Ia5kr+5cYXTlNnRMk+P8ecUET4fpmqrNd8fFQGldFWTr5xJTDn80yfMi1CbvsWHmk5JxbxOzJga1AQeWspzPgz1rPwOMoYOArS6i4WxsHCOeuUQtF1gViAABiCM/D7 cardno:000603634564' > /root/.ssh/authorized_keys

yum update

yum install augeas
augtool set /files/etc/ssh/sshd_config/PermitRootLogin without-password

yum install docker
chkconfig docker on

adduser -u 1500 -d / -l -M -s /sbin/nologin bitlbee
mkdir /bitlbee
chown bitlbee:bitlbee /bitlbee

shutdown -r now

docker pull arrjay/cc:bitlbee-c7-latest
cat << EOF > /etc/systemd/system/bitlbee-docker.service
[Unit]
Description=Bitlbee in a docker instance
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/docker run -v /bitlbee:/bitlbee arrjay/cc:bitlbee-c7-latest
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
chkconfig bitlbee-docker on
service bitlbee-docker start

echo
