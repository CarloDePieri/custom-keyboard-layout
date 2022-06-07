#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "[ERR] I need to run as root!"
  exit 1
fi

map_file=/usr/local/share/kbd/keymaps/us_cik.map

if [[ ! -f "$map_file" ]]; then
  mkdir -p /usr/local/share/kbd/keymaps
  cp us_cik.map /usr/local/share/kbd/keymaps/.
  loadkeys /usr/local/share/kbd/keymaps/us_cik.map
  # localectl set-keymap --no-convert /usr/local/share/kbd/keymaps/us_cik.map  # This is not working, don't know why
  sed -i -e '/KEYMAP=/ s/=.*/=\/usr\/local\/share\/kbd\/keymaps\/us_cik.map/' /etc/vconsole.conf
fi
