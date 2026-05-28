#!/bin/bash
# disk-init.sh
# Create, partition, format and mount the disk.

set -euo pipefail

IMG=$OUTPUT_DIR/disk.img
SIZE=${1:-15G}
MOUNT=$BUILD_DIR

if [[ -f "${IMG}" ]]; then
    echo "ERROR: ${IMG} already exists!"
    exit 1
fi

echo "[init] Creating ${SIZE} disk image..."
truncate -s "${SIZE}" "${IMG}"

echo "[init] Attaching loopback device..."
LOOP=$(sudo losetup -fP --show "${IMG}")
echo "[init] Loop device: ${LOOP}"

echo "[init] Partitioning..."
echo -e "n\np\n1\n\n\na\nw\n" | sudo fdisk "${LOOP}"

sleep 1

echo "[init] Formatting ext4..."
sudo mkfs -v -t ext4 "${LOOP}p1"

echo "[init] Mounting ${LOOP}p1 to ${MOUNT}"
sudo mkdir -pv "${MOUNT}"
sudo mount -v -t ext4 "${LOOP}p1" "${MOUNT}"
sudo chown root:root "${MOUNT}"
sudo chmod 755 ${MOUNT}

echo "Disk initialized and mounted at ${MOUNT}"
echo "Loop device: ${LOOP}"
