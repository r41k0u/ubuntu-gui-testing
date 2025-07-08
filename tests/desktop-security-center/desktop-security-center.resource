*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource
Library             String
Library             OperatingSystem

*** Variables ***
${Y}    ${CURDIR}

*** Keywords ***
Open Security Center
    Open Terminal
    
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

Check Recovery Key Success
    Move Pointer To Check
    EzClick
    Move Pointer To XXXX
    EzClick
    PlatformHid.Type String    27923-40354
    Sleep    1
    PlatformHid.Type String    -64135-46675
    Sleep    1
    PlatformHid.Type String    -37087-49770
    Sleep    1
    PlatformHid.Type String    -10618-41883
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
    PlatformHid.Type String    27923-40354
    Sleep    1
    PlatformHid.Type String    -64135-46675
    Sleep    1
    PlatformHid.Type String    -37087-49770
    Sleep    1
    PlatformHid.Type String    -10618-41888
    Move Pointer To ${Y}/generic/check-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/check-recovery-key-failure.png

Replace Recovery Key
    Move Pointer to Replace
    EzClick
    ${text}=       Read Text
    ${recovery_key_text}=        String.Get Line      ${text}       -7
    ${recovery_key}=    Replace String    ${recovery_key_text}    ${space}    ${empty}  
    Log To Console    ${recovery_key}
    # Split at character 23 and strip whitespace
    ${first_part}=    Get Substring    ${recovery_key}    0    23
    ${second_part}=    Get Substring    ${recovery_key}    23
    ${first_part}=    Strip String    ${first_part}
    ${second_part}=    Strip String    ${second_part}
    Log    First part: "${first_part}"
    Log    Second part: "${second_part}"
    Move Pointer to "I saved"
    EzCLick
    Move Pointer To ${Y}/generic/replace-recovery-key-button.png
    EzClick
    PlatformVideoInput.Match    ${Y}/generic/replace-recovery-key-success.png
    Move Pointer To ${Y}/generic/cross-button.png
    EzCLick
    RETURN    ${first_part}    ${second_part}

Test Unlock With Recovery Key
    [Arguments]    ${first_part}    ${second_part}
    Start Application    reboot
    Sleep    25
    PlatformVideoInput.Match Text    "Please enter the passphrase"
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match Text    "Please enter the recovery"
    PlatformHid.Type String    ${first_part}
    Sleep    1
    PlatformHid.Type String    ${second_part}
    PlatformHid.Keys Combo    Return
    Log In
