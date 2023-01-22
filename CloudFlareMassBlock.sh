#!/usr/bin/env bash

# >>>>>>>>>>>>>>>>>>>>>>>> Variables >>>>>>>>>>>>>>>>>>>>>>>>
zones="myzone"
email="me@example.com"
authkey="AuthKey"
id="id"
org_name="My Organization"
notes="Mass Block"
# <<<<<<<<<<<<<<<<<<<<<<<< Variables <<<<<<<<<<<<<<<<<<<<<<<<

count=0

for ip in `cat "$1"`; do
  curl -sSX POST "https://api.cloudflare.com/client/v4/zones/$zones/firewall/access_rules/rules" \
    -H "X-Auth-Email: $email" \
    -H "X-Auth-Key: $authkey" \
    -H "Content-Type: application/json" \
    –data "{\"mode\":\"block\",\"scope\":{\"id\":\"$id\",\"name\":\"$org_name\",\"type\":\"organization\"},\"configuration\":{\"target\":\"ip\",\"value\":\"$ip\"},\"notes\":\"$notes\"}" ;

  ((count++))
  echo "$count. blocked: $ip"
done

# Using command:
# CloudFlareMassBlock.sh /path/ip-list.txt
