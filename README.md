rt-tpm-tickets
==============

Trivial bash script creating repetitive task tickets in RT

## Features
This simple script creates tickets in RT by taking ticket content from one or more text files
named after today - i.e. if you run this script on Tuesdays, it will look for files named
like *tuesday_ticket<any>.txt* (where <any> can be any text matched by a *).
For every such file it will create an RT ticket whose content is taken by reading the file.
Input files are simple text files whose content is passed directly to the RT REST API.

## Purpose
Automated creation of TPM Task tickets like changing a backup tape

## Configuration
1. Tickets text files must be located in /usr/local/etc
2. Authentication credentials are taken from ~/.netrc
3. RT server URL and application credentials are read from ~/.rtrc
Remember to protect these files

## Notes
File names must be lower case
This script is meant to be run by cron
It uses httpie to communicate over the RT REST interface
Outputs http status and ticket number

## Sample text file content
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

## Deployment
1. Install rt_tpm_tickets.sh in /usr/local/bin, owner root:root, mode 755
2. Create ticket text files in /usr/local/etc (as many as necessary)
3. Configure /root/.netrc and /root/.rtrc, owner root:root, mode 600
4. Schedule daily execution in crontab 06:15 Fri & Sun only ==> '15 6 * * 1,5 /usr/local/bin/rt_tpm_tickets'

## References
cron(1), netrc(5), rt(1), http --help
