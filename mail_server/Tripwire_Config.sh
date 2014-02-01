!#/bin/bash
echo "YOU MUST BE ROOT"

apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install tripwire

cd /etc/tripwire/
chmod 0600 tw.cfg tw.pol
tripwire --init

rm /etc/tripwire/twpol.txt
rm /etc/tripwire/twcfg.txt
