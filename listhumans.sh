#!/bin/bash

awk -F ':' '$3 >= 1000 && $3 < 64434 {print $1}' /etc/passwd
