#!/bin/bash
ssh git@erep.webbyapp.com 'mysqldump -q -u erep -p erep' > backup.sql
