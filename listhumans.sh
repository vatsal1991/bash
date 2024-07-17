#!/bin/bash

#This code returns human users i.e. uid > 1000, from the list of /etc/passwd file
#You can use this cmd to get human accounts or user accounts in your system
#It filters users based on their uid

awk -F ':' '$3 >= 1000 && $3 < 64434 {print $1}' /etc/passwd
