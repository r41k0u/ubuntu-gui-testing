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
    ${first_part}    ${second_part}=    Replace Recovery Key
    Test Unlock With Recovery Key    ${first_part}    ${second_part}
