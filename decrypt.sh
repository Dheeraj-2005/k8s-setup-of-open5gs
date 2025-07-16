#!/bin/bash
set -e

# Use K3s's containerd socket
CTR="ctr --address /run/k3s/containerd/containerd.sock"
NAMESPACE="-n k8s.io"

echo "[*] Downloading encrypted image and key..."
curl -fsSL -o /tmp/open5gs.tar.enc  http://172.31.46.214:8080/open5gs.tar.enc
curl -fsSL -o /tmp/image.key     http://172.31.46.214:8080/image.key

echo "[*] Decrypting..."
openssl enc -d -aes-256-cbc \
        -in  /tmp/open5gs.tar.enc \
        -out /tmp/open5gs.tar      \
        -pass file:/tmp/image.key

echo "[*] Importing into K3s containerd with explicit name..."
$CTR $NAMESPACE images import --digests \
      --index-name docker.io/library/open5gs-decrypted:latest \
      /tmp/open5gs.tar


# Mark image “managed” so K3s’s CRI plugin sees it
$CTR $NAMESPACE image label docker.io/library/open5gs-decrypted:latest \
      "io.cri-containerd.image=managed"

echo "[*] Done."
