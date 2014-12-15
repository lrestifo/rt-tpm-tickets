#!/bin/bash
#
# Create a TPM Task ticket
#
source ~/.trellorc

#
# Create 2 tickets, one for Friday and another one for Monday
FriData="content='`cat friday_ticket.txt`'"
MonData="content='`cat monday_ticket.txt'"
curl --basic --user "$rtUser:$rtPass" --silent --request POST --header "Content-Type: text/plain" --data "$FriData" --url "$rtServer/REST/1.0/ticket/new?user=$rtUser&pass=$rtPass"
curl --basic --user "$rtUser:$rtPass" --silent --request POST --header "Content-Type: text/plain" --data "$MonData" --url "$rtServer/REST/1.0/ticket/new?user=$rtUser&pass=$rtPass"
