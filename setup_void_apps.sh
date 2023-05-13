#!/bin/bash

###############################################################################################
# Author: 	imatsatsos                                                                        #
# Description:	This script install's my preferred applications in an interactive way         #
###############################################################################################


box() {
    title=" $1 "
    echo -e "\e[1;31m$title\e[0m"
}

box "Do you want to: Install Steam?  [Y/N]"
read -r dm1
if [[ "$dm1" == [Y/y] ]]; then
	sudo xbps-install -Sy void-repo-nonfree void-repo-multilib{,-nonfree}
	sudo xbps-install -Sy steam libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit
	box "Will you use an Nvidia GPU for Steam?  [Y?N]"
	read -r dm2
	if [[ "$dm2" == [Y/y] ]]; then
		sudo xbps-install -Sy nvidia-libs-32bit
	fi
fi

box "Do you want to: Install flatpak?  [Y/N]"
read -r dm3
if [[ "$dm3" == [Y/y] ]]; then
	sudo xbps-install -Sy flatpak; sleep 0.5
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; sleep 0.5
	flatpak update --appstream
## TODO: menu for some of my flatpaks
fi

box "Do you want to: Install a collection of apps I use?  [Y/N]"
echo "(alacritty, geany, htop, neovim, mpv, yt-dlp, easyeffects, lutris, fzf, curl"
echo " git, xmirror, xrandr, intel-undervolt, intel-gpu-tools, glxinfo, libva-utils)"
read -r dm4
if [[ "$dm4" == [Y/y] ]]; then
	sudo xbps-install -Sy alacritty geany htop neovim mpv yt-dlp ffmpeg easyeffects lutris fzf
	sudo xbps-install -y curl git xmirror xrandr intel-undervolt intel-gpu-tools glxinfo libva-utils
fi
# alacritty > terminal
# geany > text editor
# htop > sys monitor
# neovim > term text editor
# mpv > media player
# yt-dlp > download videos from internet
# ffmpeg > the world runs on this
# easyeffects > EQ for audio devices
# lutris > run windows software via wine
# fzf > fuzzy search
# curl > to download stuff from cli
# git > you know, for online git repos
# xmirror > void app to change xbps mirrors
# xrandr > to change screen resolution and more on xorg
# intel-undervolt > undervolt intel CPUs
# intel-gpu-tools > mainly for itop (intel gpu monitor)
# glxinfo > cli util to verify gpu drivers
# libva-utils > cli util to verify vaapi support

box "Do you want to: Enable Virtualization support (virt-manager)?  [Y/N]"
read -r dm4
if [[ "$dm5" == [Y/y] ]]; then
	sudo xbps-install -Sy libvirtd virt-manager qemu
	sudo ln -s /etc/sv/libvirtd/ /var/service/
	sudo ln -s /etc/sv/virtlogd/ /var/service/
	sudo usermod -a -G libvirt $(whoami)
fi