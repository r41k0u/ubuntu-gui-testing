# ubuntu-gui-testing
GUI Testing on Ubuntu

## Pre-requisite Knowledge

The tests in this repository are all written using Robot Framework, and executed using Yarf.

Here's the yarf [documentation](https://canonical-yarf.readthedocs-hosted.com/).

Here's the yarf [repository](https://github.com/canonical/yarf/).

## Repository Structure

This repository is structured as follows - taking a snippet from the initial PR with an example test case, we have:
```
├── README.md
├── common
│   ├── circle-of-friends.png
│   └── common.resource
└── tests
    └── firefox-example
        ├── common -> ../../common/
        ├── firefox-basic
        │   └── firefox-basic.robot
        ├── firefox-example.resource
        └── generic
            ├── firefox.png
            └── new-tab.png
```

Under `common`, there exists `common.resource`. A resource file is a Robot Framework file wherein you can define functions that'll be used in `.robot` files.
 
`.robot` files are the "scripts" which make up an individual test case. They "import" `.resource` files.

Each directory under `tests` corresponds to an application - the name should be the same as the deb/snap package which provides the application.

Under each application directory, there should be `$test_case` directories, containing at least a `$test_case.robot` file, which provides the script to run the actual test case. In this `$test_case` directory, there should also exist any templates that are used *only for that test case*.

Under each application directory, outside of the test case directories, there should be the following subdirectories:
```
- generic  # for templates used in more than one $test_case
- common  # a symlink to the common directory at the root of the repo
```

Under each application directory, there should be an `$application.resource` file - full of functions used by the various `$test_case`'s for that application.

For more information on the semantics of setting up your test case, please see Robot Framework documentation.

## Writing Your Own Test Case

First, create a directory for your `$application`, if it doesn't already exist, with:
```
./scripts/new-application-test-suite-setup.sh $application
```

Congrats! Your test suites are now bootstrapped.

TBD! Need the template_factory [PR](https://github.com/canonical/yarf/pull/160) to land first.

Can use this [gist](https://gist.github.com/andersson1234/43eecdd90b02f33980500aee1ad9c183) as reference and for some helpful copy paste.

### Spawning a VM And Creating Images For Testing

Spawning VM with pre-installed raw desktop image:
```
qemu-system-x86_64 -drive format=raw,file=ubuntu25-04.img -enable-kvm -m 8192M -smp 2 -machine type=q35,accel=kvm -usbdevice tablet -vga virtio -vnc :0,share=ignore
```

You can create a pre-installed desktop image by booting a live ISO in a vm and preserving the virtual disk you install onto. Usually with qemu VMs, these are qcow2 images. qcow2 images also take up less disk space than their raw counterparts.

That'd look like this:

```
qemu-img create -f qcow2 reference.qcow2 30G
# run the live iso
qemu-system-x86_64 -boot once=d -cdrom /path/to/$release-desktop-amd64.iso -enable-kvm -hda /path/to/reference.qcow2 -m 8192M -smp 2 -usbdevice tablet -vga virtio
# run through the installer and complete your install of choice, then preserve the disk image
mv /path/to/reference.qcow2 /somewhere/safe/reference.qcow2
# Then you can boot that VM up like so:
qemu-system-x86_64 -drive format=qcow2,file=/somewhere/safe/reference.qcow2 -enable-kvm -m 8192M -smp 2 -machine type=q35,accel=kvm -usbdevice tablet -vga virtio
```

#### Overlay Images

A helpful side note, if you have a pre-installed image, as described above, and you want to run tests on it without modifying the original disk image, you can do the following, using an overlay image:

```
# create the overlay image
qemu-img create -o backing_file=/somewhere/safe/reference.qcow2,backing_fmt=qcow2 -f qcow2 /path/to/overlay.qcow2
# boot the overlay image
qemu-system-x86_64 -drive format=qcow2,file=/path/to/overlay.qcow2 -enable-kvm -m 8192M -smp 2 -machine type=q35,accel=kvm -usbdevice tablet -vga virtio
```

You can then make all the modifications you want to `overlay.qcow2` without them having any effect on `reference.qcow2`.

Please take note when using an overlay image that the absolute path to the reference image is stored within the overlay image. Changing the absolute path of the reference image requires manual intervention. It is not recommended to do this.

If you have downloaded an overlay image, and have a local pre-installed disk image you want to overlay it on top of, in order to debug:
```
qemu-img rebase -b /path/to/overlay.qcow2 /path/to/local/pre-installed.qcow2
```

### Running Yarf

Running yarf:
```
VNC_PORT=0 yarf --platform=Vnc  # for interactive console
VNC_PORT=0 yarf --platform=Vnc /path/to/application/ -- --suite mysuite # for running a test suite
# For example:
VNC_PORT=0 yarf --platform=Vnc tests/firefox-example/ -- --suite "Firefox-Example-New-Tab"
```

## Writing Your Test Plan Definitions

In this section, we'll introduce the concept of test plans. In each directory under `tests/`, there may be a corresponding `plans` directory, inside containing one or several `$plan.yaml`s.

Here's an example of what a `$plan.yaml` should look like (you can also see examples at `tests/firefox-example/plans/`):

```
---
robot_files:
    - "tests/application-1/application-1-basic/application-1-basic.robot"
```

In this example, we define one test plan. In the context of testing desktop images for Ubuntu releases, you could perhaps have test plans like `daily`, `beta`, `release-candidate`, corresponding to `daily.yaml`, `beta.yaml`, and `release-candidate.yaml`, respectively.

Under each plan, the `robot_files` key exists. `robot_files` is a list of file paths (from the root of the repo) that point to `.robot` script files. The idea is that, for a specific test plan, you'd want to run a list of separate test suites. This `yaml` file is consumed by [GUTS](https://github.com/canonical/gui-ubuntu-testing-system), in order to run several test suites in parallel.

You do not have to have more than one plan, in fact, a directory under `tests/` doesn't *need* to include any `plans/*.yaml` files at all. If the tests don't need to be run in GUTS, you can simply use `ubuntu-gui-testing` to store your tests, and run them in whatever way you choose.

An important feature of the `$plan.yaml` schema described above, is that tests from one application can include tests from another in their `$plan.yaml`. For example, if `application-1` depends on `application-2`, there may exist a `application-1-application-2-dependency.yaml` plan, with the following contents:

```
---
robot_files:
    - "tests/application-1/application-1-basic/application-1-basic.robot"
    - "tests/application-2/application-2-basic/application-2-basic.robot"
```

