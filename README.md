rt-tpm-tickets
==============

Trivial bash script creating repetitive task tickets in RT

## Features
This simple script creates tickets in RT by taking ticket content from one or more text files
named after today - i.e. if you run this script on Tuesdays, it will first
look for files named 'tuesday_ticket*.txt'.
For every such file it will create an RT ticket whose content is taken by reading the file.
Input files are simple text files whose content is passed to the RT REST API unchanged.

## Purpose
Automated creation of TPM Task tickets like changing a backup tape

## Configuration
1. Tickets text files must be located in /usr/local/etc
2. Authentication credentials are taken from ~/.netrc
3. RT server URL and App credentials are read from ~/.rtrc

## Notes
File names must be lower case
This script is meant to be run by cron
It uses httpie to communicate over the RT REST interface
Outputs http status and ticket number

## Sample content
```
id: ticket/new
Queue: IT_Germany
Requestor: root
Cc: treichert@esselte.com, gpimpinella@esselte.com
Subject: DESTU - Monday backup tape
Priority: 20
Text: Please insert Monday's backup tape in the Stuttgart tape backup unit
CF-Country: DE
CF-Request_Type: TPMTask
CF-Ticket Classification: Backup
```

## References
cron(1), netrc(5), rt(1), http --help
