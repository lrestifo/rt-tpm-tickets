rt-tpm-tickets
==============

Trivial bash script creating repetitive task tickets in RT

## Features
This simple script creates tickets in RT by taking ticket content from one or more text files
named after today - i.e. if you run this script on Tuesdays, it will look for files named
like `tuesday_ticket<something>.txt`.
Every such file becomes the content of an RT ticket, and is passed directly to the RT REST API.

## Purpose
Automated creation of TPM Task tickets like changing a backup tape

## Configuration
1. Tickets text files must be located in `/usr/local/etc`
2. Authentication credentials are taken from `~/.netrc`
3. RT server URL and application credentials are read from `~/.rtrc`.

Remember to protect these files.

## Notes
* File names must be lower case.
* This script is meant to be run by _cron_.
* It uses _httpie_ to communicate over the RT REST interface.
* Outputs http status and newly created ticket number.  Output goes to the system's cronlog.

## Sample text file content
```
id: ticket/new
Queue: General
Requestor: root
Cc: someone@mail.com, another@mail.com
Subject: Monday backup tape
Priority: 20
Text: Please insert Monday's backup tape in the tape backup unit
CF-Request_Type: TPMTask
CF-Ticket Classification: Backup
```

## Deployment
1. Install `rt_tpm_tickets.sh` in `/usr/local/bin`, owner *root:root*, mode *755*
2. Create ticket text files in `/usr/local/etc` (as many as necessary), owner can be any, mode *644*
3. Configure `/root/.netrc` and `/root/.rtrc`, owner *root:crontool*, mode *640*
4. Schedule execution in crontab for every Friday and Sunday at 06:15 with `15 6 * * 1,5 /usr/local/bin/rt_tpm_tickets`
5. For proper security, use *crontool*'s crontab and permissions as indicated above

## References
cron(1), netrc(5), rt(1), http --help
