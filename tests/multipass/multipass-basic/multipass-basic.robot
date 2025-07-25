*** Settings ***
Documentation         Basic tests for the Multipass snap
Resource        ${Z}/../multipass.resource

Test Tags       exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    [Documentation]         Log in to desktop environment
    Log In

Install Multipass
    [Documentation]         Install the Multipass snap
    Install Multipass

Open Multipass
    [Documentation]         Open Multipass
    Open Multipass

Verify No Instances
    [Documentation]         Ensure no instances are listed
    Verify No Instances

Prevent Sleep
    [Documentation]         Change gnome settings to disable sleeping from desktop environment
    Prevent Sleep

Launch Instance
    [Documentation]         Launch a Multipass instance
    [Timeout]    600
    Launch Instance

Return to Catalogue
    [Documentation]         Return to catalogue page in Multipass snap
    Return to Catalogue

Delete Instance
    [Documentation]         Delete the previously spawned instance
    Delete Single Instance

Close Multipass
    [Documentation]         Close the multipass snap
    Close Multipass
