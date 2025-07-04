*** Settings ***
Resource        ${Z}/../desktop-security-center.resource

Test Tags       robot:exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    Log In

Open Security Center
    Open Security Center

Open Disk Encryption Tab
    Open Disk Encryption Tab

Change Passphrase
    Change Passphrase    myoldpassphrase    mynewpassphrase

Reboot
    Start Application    reboot

Boot With Passphrase
    Boot With Passphrase    mynewpassphrase

Log In After Reboot
    Log In
