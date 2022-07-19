#!/bin/sh

. ./.env

echo "Opravdu? Cekam 5sec"
sleep 5

sudo docker stop ${CONTAINER}
sudo docker rm ${CONTAINER}

#sudo docker rmi ${IMG}

#sudo docker volume remove ${CONTAINER}-etc
sudo docker volume create ${CONTAINER}-etc

#sudo docker volume remove ${CONTAINER}-var
sudo docker volume create ${CONTAINER}-var

#sudo docker volume remove ${CONTAINER}-nagvis-etc
sudo docker volume create ${CONTAINER}-nagvis-etc

#sudo docker volume remove ${CONTAINER}-nagvis-userfiles
sudo docker volume create ${CONTAINER}-nagvis-userfiles

#sudo docker volume remove ${CONTAINER}-nagiosgraph-etc
sudo docker volume create ${CONTAINER}-nagiosgraph-etc

#sudo docker volume remove ${CONTAINER}-nagiosgraph-var
sudo docker volume create ${CONTAINER}-nagiosgraph-var



sudo docker run \
  --env HTTPS_PROXY="http://proxy" \
  --name ${CONTAINER}  \
  -it --restart unless-stopped \
  -e MAIL_RELAY_HOST="smtpinternal.constellium.com" \
  -e MAIL_FROM="nagios@constellium.com" \
  -e MAIL_INET_PROTOCOLS="ipv4" \
  -e NAGIOS_FQDN="nagios.constellium.biz" \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v ${CONTAINER}-etc:/opt/nagios/etc \
  -v ${CONTAINER}-var:/opt/nagios/var \
  -v ${CONTAINER}-nagvis-etc:/opt/nagvis/etc \
  -v ${CONTAINER}-nagvis-userfiles:/opt/nagvis/share/userfiles \
  -v ${CONTAINER}-nagiosgraph-etc:/opt/nagiosgraph/etc \
  -v ${CONTAINER}-nagiosgraph-var:/opt/nagiosgraph/var \
  -h nagios.constellium.biz \
  -p 8380:80 \
  ${IMAGE}

