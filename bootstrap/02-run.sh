#!/bin/bash -e

# Install raspotify using the utility script in chroot
echo "Installing raspotify..."
on_chroot << EOF
curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

EOF

# Function to let us modify key=value pairs in files
setvalue_and_uncomment() {
    sed -i "s/^[#]*\s*$1=.*/$1=\"$2\"/" $3
}

# Set DEVICE_NAME by modifying the config file directly on the image filesystem
echo "Setting DEVICE_NAME..."
setvalue_and_uncomment DEVICE_NAME ${RASPOTIFY_NAME} ${ROOTFS_DIR}/etc/default/raspotify