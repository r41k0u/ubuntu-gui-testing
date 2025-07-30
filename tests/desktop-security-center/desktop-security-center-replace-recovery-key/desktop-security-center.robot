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

Test Replace Recovery Key
    ${recovery_key}=    Replace Recovery Key
    Test Unlock With Recovery Key    ${recovery_key}
