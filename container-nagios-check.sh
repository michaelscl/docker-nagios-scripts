#!/bin/bash

. ./.env
sudo docker exec -it ${CONTAINER} /opt/nagios/bin/nagios -v /opt/nagios/etc/nagios.cfg && sleep 2 || sleep 5


