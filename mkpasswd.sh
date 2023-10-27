#!/bin/sh

# Makes a password hash to be used in chgpasswd or nix's passwordHash

echo "DO NOT copy paste into your text editor, this will add a newline"
echo "Usage: ./mkpasswd.sh > rene"

mkpasswd -m sha-512 | tr -d '\n'
