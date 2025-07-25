*** Settings ***
Documentation               Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
Open Firefox
    [Documentation]         Open the firefox browser
    Start Application    firefox
    PlatformVideoInput.Match Text    Firefox    60

Open New Tab
    [Documentation]         Open a new tab
    Move Pointer To ${Y}/generic/new-tab.png
    EzClick
    PlatformVideoInput.Match    ${Y}/firefox-example-new-tab/new-tab.png
    # PlatformVideoInput.Match Text    New Tab    40
