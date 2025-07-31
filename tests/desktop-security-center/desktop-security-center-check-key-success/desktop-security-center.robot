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

Check Recovery Key Success
    Check Recovery Key Success
