*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource

*** Variables ***
${Y}    ${CURDIR}

*** Keywords ***
Open Security Center
    Open Terminal
    
    # 27923-40354-64135-46675-46675-37087-49770-10618-41883
    # Open Security Center via sudo
    PlatformHid.Type String  sudo /snap/desktop-security-center/current/bin/security
    PlatformHid.Keys Combo    Shift_L    -
    PlatformHid.Type String    center
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match Text    [sudo] password
    PlatformHid.Type String    ubuntu
    PlatformHid.Keys Combo    Return

Open Disk Encryption Tab
    Move Pointer To ${Y}/generic/disk-icon.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/disk-icon-selected.png

Check Recovery Key
    Move Pointer To Check
    EzClick
    Move Pointer To XXXX
    EzClick
    PlatformHid.Type String    27923-40354-64135-46675-37087-49770-10618-41883
    Move Pointer To ${Y}/generic/check-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/check-recovery-key-success.png
