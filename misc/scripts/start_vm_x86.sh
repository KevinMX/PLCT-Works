#!/bin/bash

qemu-system-x86_64 \
  -accel kvm \
  -m 32G \
  -cpu host \
  -smp 16 \
  -drive file=openEuler-23.09-x86_64.qcow2,format=qcow2 \
  -drive if=pflash,format=raw,file=OVMF.fd \
  -nographic \
  -device virtio-net-pci,netdev=n0 \
  -netdev user,id=n0,hostfwd=tcp::60022-:22