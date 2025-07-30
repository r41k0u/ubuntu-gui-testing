*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource
Library             String
Library             OperatingSystem


*** Variables ***
${Y}                ${CURDIR}
${RECOVERY_KEY}     27923-40354-64135-46675-37087-49770-10618-41883


*** Keywords ***
Open Security Center
    Open Terminal

    # Open Security Center via sudo
    PlatformHid.Type String    desktop-security-center
    PlatformHid.Keys Combo    Return

Open Disk Encryption Tab
    Move Pointer To ${Y}/generic/disk-icon.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/disk-icon-selected.png

Check Recovery Key Success
    Move Pointer To Check
    EzClick
    Move Pointer To XXXX
    EzClick
    PlatformHid.Type String    ${RECOVERY_KEY}
    Move Pointer To ${Y}/generic/check-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/check-recovery-key-success.png

Change Passphrase
    [Arguments]    ${old}    ${new}
    Move Pointer To Change passphrase...
    EzClick
    Move Pointer To Current Passphrase
    EzClick
    PlatformHid.Type String    ${old}
    Move Pointer To New Passphrase
    EzClick
    PlatformHid.Type String    ${new}
    Move Pointer To Confirm Passphrase
    EzClick
    PlatformHid.Type String    ${new}
    Move Pointer To ${Y}/generic/change-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/change-passphrase-success.png

Boot With Passphrase
    [Arguments]    ${passphrase}
    PlatformVideoInput.Match Text    Please enter the passphrase for volume    120
    PlatformHid.Type String    ${passphrase}
    PlatformHid.Keys Combo    Return

Check Recovery Key Failure
    Move Pointer To Check
    EzClick
    Move Pointer To XXXX
    EzClick
    PlatformHid.Type String    00000-00000-00000-00000-00000-00000-00000-00000
    Move Pointer To ${Y}/generic/check-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/check-recovery-key-failure.png

Replace Recovery Key
    Move Pointer to Replace
    EzClick
    Authenticate With Polkit
    ${text}=    Read Text

    # Catch the recovery key line
    ${recovery_key_text}=    String.Get Line    ${text}    -11

    # String whitespace
    ${recovery_key}=    Replace String    ${recovery_key_text}    ${space}    ${empty}
   
    # QR code generates and shows recovery key
    Move Pointer to "Show QR code"
    EzClick
    PlatformVideoInput.Match Text    ${recovery_key}
    Move Pointer To ${Y}/generic/cross-button.png
    EzClick

    # We can save to a file
    Move Pointer to "Save to file"
    EzClick
    Move Pointer To ${Y}/generic/save-orange.png
    EzClick

    Move Pointer to "I saved"
    EzCLick
    Move Pointer To ${Y}/generic/replace-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/replace-recovery-key-success.png
    Move Pointer To ${Y}/generic/cross-button.png
    EzCLick
    Move Pointer To ${Y}/generic/cross-button.png
    EzCLick

    # cat recovery-key.txt to validate we saved the key
    PlatformHid.Type String    cat /home/ubuntu/recovery-key.txt 
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match Text    ${recovery_key}

    RETURN    ${recovery_key}

Test Unlock With Recovery Key
    [Arguments]    ${recovery_key}
    Start Application    reboot
    Sleep    25
    PlatformVideoInput.Match Text    "Please enter the passphrase"
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match Text    "Please enter the recovery"
    PlatformHid.Type String    ${recovery_key}
    PlatformHid.Keys Combo    Return
    Log In

Authenticate With Polkit
    PlatformVideoInput.Match Text    "Authentication Required"
    Move Pointer To Password
    EzCLick
    PlatformHid.Type String    ubuntu
    Move Pointer To Authenticate
    EzCLick
