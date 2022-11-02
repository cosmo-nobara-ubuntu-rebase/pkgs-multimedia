#! /bin/bash

# Check system for NVIDIA card and set vaapi env vars

nvgpu=$(lspci | grep -iE 'VGA|3D' | grep -i nvidia | cut -d ":" -f 3)
nvkernmod=$(lspci -k | grep -iEA3 '^[[:alnum:]]{2}:[[:alnum:]]{2}.*VGA|3D' | grep -iA3 nvidia | grep -i 'kernel driver' | grep -iE 'vfio-pci|nvidia')

if [[ ! -z $nvgpu ]]; then
	if [[ -z $nvkernmod ]]; then
        	export LIBVA_DRIVER_NAME=nvidia
        	export MOZ_DISABLE_RDD_SANDBOX=1
        	export EGL_PLATFORM=wayland
	else
        	echo "No NVIDIA Driver detected. No env vars set for va-api."
	fi
else
	echo "No NVIDIA GPU detected. No env vars set for va-api."
fi
