*** Settings ***
Documentation         Open firefox browser
Resource        ${Z}/../firefox-example.resource

Test Tags           robot:exit-on-failure    # robocop: off=tag-with-reserved-word


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    [Documentation]         Log in to desktop environment
    Log In

Open Firefox
    [Documentation]         Open firefox browser
    Open Firefox
