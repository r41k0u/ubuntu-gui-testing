*** Settings ***
Resource        ${Z}/../multipass.resource

Test Tags       robot:exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    Log In

Install Multipass
    Install Multipass

Open Multipass
    Open Multipass

Verify No Instances
    Verify No Instances

Prevent Sleep
    Prevent Sleep

Launch Instance
    [Timeout]    600
    Launch Instance

Return to Catalogue
    Return to Catalogue

Delete Instance
    Delete Single Instance

Close Multipass
    Close Multipass
