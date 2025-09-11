*** Settings ***
Documentation       Shared resources for Chromium testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
Open Chromium
    [Documentation]         Open chromium browser
    Start Application    /snap/bin/chromium
    Match Text    New Tab

Install Mail Client
    [Documentation]         Install evolution debian package
    Install Debian Package    evolution

Install Chromium
    [Documentation]         Install chromium snap package
    Install Snap Package    chromium

Open Chromium Mail Link
    [Documentation]         Affirm the mailto chromium link works and opens evolution
    Start Application    /snap/bin/chromium wiki.ubuntu.com/DesktopTeam/TestPlans/Chromium
    Match Text    Attachments

    ${combo}    Create List    Control_L    f
    Keys Combo    ${combo}
    Type String    mailto
    ${esc}    Create List    Escape
    ${ret}    Create List    Return
    Keys Combo    ${esc}
    Keys Combo    ${ret}

Match Mail Client
    [Documentation]         Ensure evolution is opened
    Match Text    From
    Match Text    To
    Match Text    foobar@nospam.org
