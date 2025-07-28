*** Settings ***
Documentation           Log in, open Firefox, open a new tab
Resource        ${Z}/../firefox-example.resource

Test Tags       exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    [Documentation]     Log in to the desktop environment
    Log In

Open Firefox
    [Documentation]     Open the Firefox browser
    Open Firefox

Open New Tab
    [Documentation]     Open a new tab
    Open New Tab
