*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}                ${CURDIR}
${RECOVERY_KEY}     62624-10584-39666-64718-31970-44050-59829-32069


*** Keywords ***
Open Firmware Updater
    Start Application    firmware-updater
    Match Text    Firmware Updater    60

Refresh Firmware Metadata
    Open Terminal
    Run Sudo Command In Terminal    sudo fwupdmgr refresh
    Close Terminal

Setup Fake Webcam
    Install Debian Package    fwupd-tests
    Open Terminal
    Run Sudo Command In Terminal    sudo echo foo
    Type String    sudo snap connect firmware-updater
    Keys Combo    Shift_L    ;
    Type String    hostfs-usr-share-installed-tests-fwupd
    Keys Combo    Return
    Close Terminal

Setup Mock TPM FDE Update
    # Write firmware-updater config file to make it pretend updating the fwupd
    # test device affects TPM FDE so that it triggers the recovery key dialog
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

Update ${device}
    Match Text    ${device}    60
    Move Pointer To ${device}
    EzClick

    # Update to latest version
    Move Pointer To ${Y}/generic/update-to-latest-button.png
    EzClick

Handle Reboot Prompt
    Match    ${Y}/generic/reboot-now-button.png    60
    Move Pointer To ${Y}/generic/reboot-now-button.png
    EzClick

Handle Recovery Key Prompt
    Move Pointer To ${Y}/generic/passphrase-textfield.png
    EzClick
    Type String    ${RECOVERY_KEY}

Confirm Update
    Move Pointer To ${Y}/generic/update-button.png
    EzClick

Enter Recovery Key On Reboot
    Match Text    Please enter the recovery key    120
    Type String    ${RECOVERY_KEY}
    Keys Combo    Return

Check For Successful Fake Webcam Update
    Match    ${Y}/generic/fake-webcam-update-done.png    60

Check For Successful UEFI CA Update
    Open Terminal
    Type String    fwupdmgr get-updates
    Keys Combo    Return
    Match    ${Y}/generic/uefi-ca-update-done.png    60

Handle PolKit Prompt
    Match    ${Y}/generic/polkit-prompt.png
    Type String    ubuntu
    Keys Combo    Return
