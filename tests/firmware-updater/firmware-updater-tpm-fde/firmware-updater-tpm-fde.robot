*** Settings ***
Documentation         Test the firmware updater snap
Resource        ${Z}/../firmware-updater.resource

Test Tags       exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    [Documentation]         Log in to desktop environment
    Log In

Install fwupd tests
    [Documentation]         Install fwupd-tests deb package
    Install Debian Package    fwupd-tests

Open Firmware Updater
    [Documentation]         Open the firmware-updater snap
    Open Firmware Updater

Update Fake Webcam
    [Documentation]         Update the fake webcam application
    Update Fake Webcam
