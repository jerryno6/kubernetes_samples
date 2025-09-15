# Talos on Proxmox

## First Boot

ISO
https://factory.talos.dev/image/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e/v1.11.1/metal-amd64.iso (ISO documentation)
Disk Image (raw)
https://factory.talos.dev/image/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e/v1.11.1/metal-amd64.raw.zst
Disk Image (qcow2)
https://factory.talos.dev/image/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e/v1.11.1/metal-amd64.qcow2
PXE boot (iPXE script)
https://pxe.factory.talos.dev/pxe/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e/v1.11.1/metal-amd64
(PXE documentation)
Initial Installation
For the initial installation of Talos Linux (not applicable for disk image boot), add the following installer image to the machine configuration:
factory.talos.dev/metal-installer/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e:v1.11.1

Upgrading Talos Linux
To upgrade Talos Linux on the machine, use the following image:
factory.talos.dev/metal-installer/841e64a10871624f61d9689b3f01b1752f70ef3e3e5a981aa7150e5970bb3e3e:v1.11.1


## Install talosctl

`talosctl gen config talos-proxmox-cluster https://$CONTROL_PLANE_IP:6443 --output-dir _out --force`

` talosctl apply-config --insecure --nodes $CONTROL_PLANE_IP --file _out/controlplane.yaml`
` talosctl apply-config --insecure --nodes 192.168.50.141 --file _out/worker.yaml`
` talosctl apply-config --insecure --nodes 192.168.50.142 --file _out/worker.yaml`
` talosctl apply-config --insecure --nodes 192.168.50.143 --file _out/worker.yaml`

### Config talos

```bash
  export TALOSCONFIG="_out/talosconfig"
talosctl config endpoint $CONTROL_PLANE_IP
talosctl config node $CONTROL_PLANE_IP
```

### Boot strap Etcd

` talosctl bootstrap`

` talosctl kubeconfig .`