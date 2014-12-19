#!/bin/bash
################################################################################
#
# Title:    RT_TPM_TICKETS -- Create the RT ticket of the day
# Author:   Thu Dec 18 21:54:06 CET 2014 Luciano Restifo [lrestifo@esselte.com]
# Description:
#   Creates a ticket in RT by taking ticket content from a text file named
#   after today - i.e. if you run this script on Tuesdays, it will create an RT
#   ticket whose content is taken from a file named "tuesday_ticket.txt"
# Purpose:
#   Automated creation of TPM Task tickets like changing a backup tape
# Configuration:
#   basic authentication credentials are taken from ~/.netrc
#   RT server URL and App credentials are read from ~/.rtrc
# Notes:
#   This script is meant to be run by cron
#   Uses httpie to communicate over the RT REST interface
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
tkt="/usr/local/etc/`date '+%A' | tr '[:upper:]' '[:lower:]'`_ticket.txt"
[ -s $tkt ] || die "No $tkt, nothing to do."
sed 's/ /=/' ~/.rtrc >/tmp/rtrc && source /tmp/rtrc && rm /tmp/rtrc
http --check-status --ignore-stdin --body --form POST $server/REST/1.0/ticket/new user==$user pass==$passwd content=@$tkt
