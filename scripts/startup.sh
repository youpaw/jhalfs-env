#!/bin/bash
# scripts/start.sh

set -euo pipefail

sudo mkdir -p "${SRC_ARCHIVE}" "${OUTPUT_DIR}"
sudo chown $USER:$USER "${SRC_ARCHIVE}" "${OUTPUT_DIR}"
sudo chmod a+wt ${SRC_ARCHIVE}

if [[ ! -d "${JHALFS_DIR}" ]]; then
    echo "[jhalfs] Cloning into ${JHALFS_DIR} ..."
    git clone https://git.linuxfromscratch.org/jhalfs.git "${JHALFS_DIR}"
else
    echo "[jhalfs] Already cloned at ${JHALFS_DIR}, skipping."
fi

${SCRIPTS_DIR}/disk-attach.sh && echo "Disk reattached" || echo "Reattach failed, first run?"

if [[ "$(readlink /usr/bin/sh)" != "bash" ]]; then
    sudo rm -f /usr/bin/sh
    sudo ln -s bash /usr/bin/sh
fi

exec /bin/bash
