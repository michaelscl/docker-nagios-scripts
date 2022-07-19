#!/bin/bash

. ./.env
sudo docker exec -it ${CONTAINER} mc -a /opt/nagios/etc/conf.d
