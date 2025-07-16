*** Settings ***
Resource        ${Z}/../firmware-updater.resource

Test Tags       robot:exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Log In
    Log In

Install fwupd tests
    Install Debian Package    fwupd-tests

Open Firmware Updater
    Open Firmware Updater

Update Fake Webcam
    Update Fake Webcam
