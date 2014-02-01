!#/bin/bash
echo "YOU MUST BE ROOT"

apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install postfix

echo "This next command has prompts \
1. \"Internet Site\" \
2. your domain name \
3. \"root\" \
4. your domain name \
5. \"Yes\" \
6. default thing \
7. default thing \
8. default thing \
9. default thing"
sleep 3

dpkg-reconfigure postfix
postconf -e 'home_mailbox = Maildir/'
postconf -e 'mailbox_command ='
postconf -e 'smtpd_sasl_local_domain ='
postconf -e 'smtpd_sasl_auth_enable = yes'
postconf -e 'smtpd_sasl_security_options = noanonymous'
postconf -e 'broken_sasl_auth_clients = yes'
postconf -e 'smtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination'
postconf -e 'inet_interfaces = all'

mv smtpd.conf /etc/postfix/sasl/
touch smtpd.key
chmod 600 smtpd.key
openssl genrsa 1024 > smtpd.key
echo "The next 2 commands have prompts"
sleep 1
openssl req -new -key smtpd.key -x509 -days 3650 -out smtpd.crt
openssl req -new -x509 -extensions v3_ca -keyout cakey.pem -out cacert.pem -days 3650

mv smtpd.key /etc/ssl/private/
mv smtpd.crt /etc/ssl/certs/
mv cakey.pem /etc/ssl/private/
mv cacert.pem /etc/ssl/certs/

postconf -e 'smtp_tls_security_level = may'
postconf -e 'smtpd_tls_security_level = may'
postconf -e 'smtpd_tls_auth_only = no'
postconf -e 'smtp_tls_note_starttls_offer = yes'
postconf -e 'smtpd_tls_key_file = /etc/ssl/private/smtpd.key'
postconf -e 'smtpd_tls_cert_file = /etc/ssl/certs/smtpd.crt'
postconf -e 'smtpd_tls_CAfile = /etc/ssl/certs/cacert.pem'
postconf -e 'smtpd_tls_loglevel = 1'
postconf -e 'smtpd_tls_received_header = yes'
postconf -e 'smtpd_tls_session_cache_timeout = 3600s'
postconf -e 'tls_random_source = dev:/dev/urandom'
echo "Make sure you change se1rver.mailcam.co to the domain you're using"
sleep 3
postconf -e 'myhostname = se1rver.mailcam.co'
/etc/init.d/postfix restart
