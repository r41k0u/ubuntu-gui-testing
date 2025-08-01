*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}                ${CURDIR}
${RECOVERY_KEY}     62624-10584-39666-64718-31970-44050-59829-32069


*** Keywords ***
Open Firmware Updater
    [Documentation]    Open the firmware updater application
    Start Application    firmware-updater
    Match Text    Firmware Updater    60

Refresh Firmware Metadata
    [Documentation]    Fetch the firmware catalog from LVFS
    Open Terminal
    Run Sudo Command In Terminal    sudo fwupdmgr refresh --force
    Close Terminal

Setup Fake Webcam
    [Documentation]    Setup the fake webcam device from fwupd-tests
    Install Debian Package    fwupd-tests
    Open Terminal
    Run Sudo Command In Terminal    sudo echo foo
    Type String    sudo snap connect firmware-updater
    Keys Combo    Shift_L    ;
    Type String    hostfs-usr-share-installed-tests-fwupd
    Keys Combo    Return
    Close Terminal

Setup Mock TPM FDE Update
    [Documentation]    Write firmware-updater config file to make it pretend updating the fwupd test device affects TPM FDE so that it triggers the recovery key dialog
    Open Terminal
    Type String    mkdir -p snap/firmware-updater/current/.config/firmware-updater
    Keys Combo    Return
    Type String    echo 'testDeviceAffectsFde
    Keys Combo    Shift_L    ;
    Keys Combo    space
    Type String    true'
    Keys Combo    Shift_L    .
    Type String    snap/firmware-updater/current/.config/firmware-updater/firmware-updater.yml
    Keys Combo    Return
    Builtin.Sleep    5
    Close Terminal

Setup Mock Bitlocker Partition
    [Documentation]    Setup a mock Bitlocker partition by loopmounting a test image from cryptsetup
    Open Terminal
    Run Command In Terminal
    ...    wget gitlab.com/cryptsetup/cryptsetup/-/raw/2cf4c9a360e6c9497898ad89a1cb3c81f77ce458/tests/bitlk-images.tar.xz
    Run Command In Terminal    tar xvf bitlk-images.tar.xz bitlk-images/bitlk-aes-xts-128.img
    Run Sudo Command In Terminal    sudo losetup -f --show bitlk-images/bitlk-aes-xts-128.img
    Run Command In Terminal    sudo systemctl restart fwupd.service
    Close Terminal

Update ${device}
    [Documentation]    Update the given device
    Match Text    ${device}    60
    Move Pointer To ${device}
    EzClick
    Move Pointer To ${Y}/generic/update-to-latest-button.png
    EzClick

Handle Reboot Prompt
    [Documentation]    Confirm to reboot the system
    Match    ${Y}/generic/reboot-now-button.png    60
    Move Pointer To ${Y}/generic/reboot-now-button.png
    EzClick

Handle Recovery Key Prompt
    [Documentation]    Enter the recovery key in the dialog
    Move Pointer To ${Y}/generic/passphrase-textfield.png
    EzClick
    Type String    ${RECOVERY_KEY}

Handle Recovery Key Checkbox
    [Documentation]    Tick the checkbox in the recovery key confirmation dialog
    Move Pointer To I have recovery keys for all my encrypted drives
    EzClick

Confirm Update
    [Documentation]    Confirm the firmware update
    Move Pointer To ${Y}/generic/update-button.png
    EzClick

Enter Recovery Key On Reboot
    [Documentation]    Enter the recovery key on reboot
    Match Text    Please enter the recovery key    120
    Type String    ${RECOVERY_KEY}
    Keys Combo    Return

Check For Successful Fake Webcam Update
    [Documentation]    Confirm that the Fake Webcam has been updated successfully
    Match    ${Y}/generic/fake-webcam-update-done.png    60

Check For Successful UEFI CA Update
    [Documentation]    Confirm that the Microsoft certificate has been updated successfully
    Open Terminal
    Type String    fwupdmgr get-updates
    Keys Combo    Return
    Match    ${Y}/generic/uefi-ca-update-done.png    60

Handle PolKit Prompt
    [Documentation]    Enter the user password in the polkit prompt to allow checking the recovery key
    Match    ${Y}/generic/polkit-prompt.png
    Type String    ubuntu
    Keys Combo    Return
