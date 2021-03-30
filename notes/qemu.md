## General Notes

Wincent tried to do this (big endian on OS X) and failed, but took notes[6].

```
qemu-img create -f qcow2 ubuntu-20.04.2.0-desktop-amd64.qcow2 10G
qemu-system-x86_64 \
    -machine type=q35,accel=hvf \
    -smp 2 \
    -hda ubuntu-20.04.2.0-desktop-amd64.qcow2 \
    -cdrom ./ubuntu-20.04.2.0-desktop-amd64.iso \
    -m 2G \
    -vga virtio \
    -usb \
    -device usb-tablet \
    -display default,show-cursor=on
```

This worked, without even having to specify architecture.

Now, let's try the power pc image from the Kalibera post[2].  Can't accelerate
here since archs are different.

```
qemu-img create -f qcow2 ubuntu-18.04-server-cloudimg-ppc64el.qcow2 10G

qemu-img resize ubuntu-18.04-server-cloudimg-ppc64el.img 10G
qemu-system-ppc64 \
    -cpu power9 \
    -nographic \
    -smp 2 \
    -m 2G \
    -L pc-bios -boot c \
    -hda ubuntu-18.04-server-cloudimg-ppc64el.img \
    -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22

# this did something, but complaining about SCSI reading past end of file...

qemu-img resize ubuntu-18.04-server-cloudimg-ppc64el.img 10G
qemu-system-ppc64 \
    -cpu power9 \
    -nographic \
    -smp 2 \
    -m 2G \
    -L pc-bios -boot c \
    -hda ubuntu-18.04-server-cloudimg-ppc64el.img \
    -drive file=cloud-init.iso,format=raw \
    -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22

# This does not work vv, but ^^ this does?

qemu-system-ppc64 \
    -cpu power9 \
    -nographic \
    -smp 2 \
    -m 2G \
    -L pc-bios -boot c \
    -hda ubuntu-18.04-server-cloudimg-ppc64el.qcow2 \
    -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22
```

This worked, but we do need to set the password.  Also, only worked with the
.img version, so who knows what will happen if we try to do anything that
occupies any space.

[Urban Penguin][4] has some info on maybe using cloud-config, but need to figure
out how to do that on OS X.

[Sumit][5] has a detailed explanation of the cloud init process, with perhaps
even enough info that I can figure out how to get it to work on OS X.  If that
fails, we can try to use this strategy to have another way of setting the
username/password info in Ubuntu.

Eh, this looks hard (assembling the ISO), but not impossible.  We're going to
try to do the cloud config business in vagrant.



```
# old stuff

    -hda ./ubuntu-18.04-server-cloudimg-ppc64el.qcow2 \
    -machine type=powernv \

qemu-system-ppc64le \
  -smp 8 \
  -m 8192 \
  -cpu power9 \
  -nographic \
  -hda ubuntu-18.04-server-cloudimg-ppc64el.img -L pc-bios -boot c \
  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22
```

We're going to try to run QEMU on OSX, but we'll use the ubuntu vagrant image to
configure it (can't get this to work due to:



### Making Image as per Urban Penguin

I could not get `virt-customize` from Tomas's instructions[2] to work:

```
sudo virt-customize -a ubuntu-18.04-server-cloudimg-ppc64el.img --root-password password:
guestfsd: error while loading shared libraries: libgcc_s.so.1: cannot open shared object file: No such file or directory
```

Instead, I had to change the password via `cloud-init`, which worked.  Many ways
of setting passwords did not work.  The key was to change the password of root
via `chpasswd`.

```
sudo apt-get install cloud-init
sudo apt install cloud-image-utils
cat << EOF > meta-data
instance-id: instance-0
local-hostname: host5
EOF

cat << EOF > user-data
#cloud-config
chpasswd:
  list: |
     root:password
  expire: False
EOF

sudo cloud-localds cloud-init.iso user-data meta-data
```

And then run `qemu` via OS X.  **Use a fresh image!**.  Each time we do this the
image is modified and the `cloud-init` business will not work anymore.

```
qemu-img resize ubuntu-18.04-server-cloudimg-ppc64el.img 10G
qemu-system-ppc64 \
    -cpu power9 \
    -nographic \
    -smp 2 \
    -m 2G \
    -L pc-bios -boot c \
    -hda ubuntu-18.04-server-cloudimg-ppc64el.img \
    -drive file=cloud-init.iso,format=raw \
    -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22
```

## QEMU Install

Using instructions from [A Koziel][1] (see also neklaf[3]).  Note the
instructions create an empty container to fill from the CD ISO.  For our own use
we don't want that, but this does have the instructions for the QEMU install
proper:

```
brew install qemu  # remember the chown back and forth stuff
```

[1]: https://www.arthurkoziel.com/qemu-ubuntu-20-04/
[2]: https://developer.r-project.org/Blog/public/2020/05/29/testing-r-on-emulated-platforms/index.html
[3]: https://neklaf.com/2020/03/08/qemu-on-macos-mojave-os-x/
[4]: https://www.theurbanpenguin.com/using-cloud-images-in-kvm/
[5]: https://sumit-ghosh.com/articles/create-vm-using-libvirt-cloud-images-cloud-init/
[6]: https://wincent.com/wiki/Using_QEMU_to_test_big-endian_code_on_Intel-powered_OS_X

