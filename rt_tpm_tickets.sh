#!/bin/bash
################################################################################
#
# Title:    RT_TPM_TICKETS -- Create the RT ticket of the day
# Author:   Thu Dec 18 21:54:06 CET 2014 Luciano Restifo [lrestifo@esselte.com]
# Description:
#   Creates tickets in RT by taking ticket content from one or more text files
#   named after today - i.e. if you run this script on Tuesdays, it will first
#   look for files named 'tuesday_ticket*.txt', and for each one of them it will
#   create an RT ticket whose content is taken by reading the file.  Input files
#   are simple text files whose content is passed to the RT REST API unchanged.
# Purpose:
#   Automated creation of TPM Task tickets like changing a backup tape
# Configuration:
#   1. Tickets text files must be located in /usr/local/etc
#   2. Authentication credentials are taken from ~/.netrc
#   3. RT server URL and App credentials are read from ~/.rtrc
# Notes:
#   File names must be lower case
#   This script is meant to be run by cron
#   It uses httpie to communicate over the RT REST interface
#   Outputs http status and ticket number
# References:
#   cron(1), netrc(5), rt(1), http --help
#
################################################################################

function die() {
    echo "$1"
    exit 1
}

[ -s ~/.rtrc  ] || die "Can't open ~/.rtrc"
[ -s ~/.netrc ] || die "Can't open ~/.netrc"
tktfiles="/usr/local/etc/`date '+%A' | tr '[:upper:]' '[:lower:]'`_ticket"
sed 's/ /=/' ~/.rtrc >/tmp/rtrc && source /tmp/rtrc && rm /tmp/rtrc
for tkt in $tktfiles*.txt
do
  [ -s $tkt ] && echo /usr/local/bin/http --check-status --ignore-stdin --body --form POST $server/REST/1.0/ticket/new user==$user pass==$passwd content=@$tkt
done
