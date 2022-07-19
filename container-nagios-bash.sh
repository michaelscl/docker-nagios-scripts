#!/bin/bash

. ./.env
sudo docker exec -it ${CONTAINER} /bin/bash
