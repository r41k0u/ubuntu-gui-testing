*** Settings ***
Documentation           Ensure mailto links work from Chromium
Resource        ${Z}/../chromium.resource

Test Tags           robot:exit-on-failure    # robocop: off=tag-with-reserved-word


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log-in to Gnome
    [Documentation]         Log in to gnome desktop session
    Log In

Install Mail Client
    [Documentation]         Install email client (evolution)
    Install Mail Client

Install Chromium
    [Documentation]         Install chromium snap
    Install Chromium

Open Chromium Mail Link
    [Documentation]         Open mailto link in chromium
    Open Chromium Mail Link

Match Mail Client
    [Documentation]         Ensure the mail client is opened
    Match Mail Client
