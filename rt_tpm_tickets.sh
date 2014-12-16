#!/bin/bash
#
# Create a TPM Task ticket
# Create 2 tickets, one for Friday and another one for Monday
#FriData="content='`cat friday_ticket.txt`'"
#MonData="content='`cat monday_ticket.txt'"
#curl --basic --user "$rtUser:$rtPass" --silent --request POST --header "Content-Type: text/plain" --data "$FriData" --url "$rtServer/REST/1.0/ticket/new?user=$rtUser&pass=$rtPass"
#curl --basic --user "$rtUser:$rtPass" --silent --request POST --header "Content-Type: text/plain" --data "$MonData" --url "$rtServer/REST/1.0/ticket/new?user=$rtUser&pass=$rtPass"

$rtServer=ithelpdesk-test.ema.esselte.net
http --check-status --ignore-stdin -f POST $rtServer/rt/REST/1.0/ticket/new user==$rtUser pass==$rtPass content=@friday_ticket.txt
http --check-status --ignore-stdin -f POST $rtServer/rt/REST/1.0/ticket/new user==$rtUser pass==$rtPass content=@monday_ticket.txt
