#!/bin/bash
# disk-attach.sh
# Reattach the loopback to the existing image

set -euo pipefail

IMG=$OUTPUT_DIR/disk.img
MOUNT=$BUILD_DIR

if [[ ! -f "${IMG}" ]]; then
    echo "ERROR: ${IMG} not found."
    exit 1
fi

if mountpoint -q "${MOUNT}"; then
    echo "${MOUNT} is already mounted, nothing to do."
    exit 0
fi

echo "[attach] Re-attaching ${IMG} to a loopback device..."
LOOP=$(sudo losetup -fP --show "${IMG}")
echo "[attach] Loop device: ${LOOP}"

echo "[attach] Mounting ${LOOP}p1 to ${MOUNT}"
sudo mkdir -p "${MOUNT}"
sudo mount "${LOOP}p1" "${MOUNT}"

echo "Disk re-attached and mounted at ${MOUNT}"
