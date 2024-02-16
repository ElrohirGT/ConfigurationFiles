#!/usr/bin/env bash

echo -e "\e[32m Copying files to /etc/nixos/\e[0m" \
	&& sudo cp nixos/** /etc/nixos/ \
	&& (rm -r ~/.config/; cp -r . ~/.config/) \
	&& echo -e "\e[32m Rebuilding system on boot...\e[0m"\
	&& sudo nixos-rebuild boot \
	&& echo -e "\e[32m Building home manager configuration...\e[0m"\
	&& nix run home-manager/master -- switch \
	&& reboot
