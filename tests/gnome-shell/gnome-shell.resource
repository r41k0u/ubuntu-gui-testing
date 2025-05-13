*** Settings ***
Documentation       Shared resources for Gnome Shell testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
Toggle System Panel
    [Documentation]    Opens the top right system panel
    Move Pointer To ${Y}/generic/system-panel.png
    EzClick

Click Power Button
    [Documentation]    Click the power button in the system panel
    Move Pointer To ${Y}/generic/power-button.png
    EzClick
    # Match Text doesn't seem to work well in the dialog, so ignore for now
    # PlatformVideoInput.Match Text    "Log out..."

Click Lock Button
    [Documentation]    Click the lock button in the system panel
    Move Pointer To ${Y}/generic/lock.png
    EzClick

Click Log Out
    [Documentation]    Click the log out button in the power system panel
    Move Pointer To ${Y}/generic/log-out.png
    EzClick
    Move Pointer To ${Y}/generic/log-out-confirm.png
    EzClick
    PlatformVideoInput.Match Text    "Not listed"

Click Circle of Friends
    [Documentation]    Click the circle of friends in the dock
    Move Pointer To ${Y}/generic/circle-of-friends.png
    EzClick
    PlatformVideoInput.Match Text    "Type to search"

EzRightClick
    [Documentation]    EZClick but with right click
    BuiltIn.Sleep    0.5
    Click RIGHT Button
    BuiltIn.Sleep    0.5
    Move Pointer To (100, 100)

Workspace Left
    [Documentation]    Switch to the left workspace via the keyboard
    ${left}    Create List    Super    Page_Up
    PlatformHid.Keys Combo    ${left}

Workspace Right
    [Documentation]    Switch to the right workspace via the keyboard
    ${left}    Create List    Super    Page_Down
    PlatformHid.Keys Combo    ${left}

# https://github.com/canonical/ubuntu-gui-testing/pull/5/files#diff-88f4ce867cfe634d1771f32a4f5b3ebc70348744992fc4305d79d3e422845524R68-R73
Move Pointer To Text
    [Arguments]    ${text}
    ${match}    PlatformVideoInput.Match Text    ${text}
    PlatformHid.Move Pointer To Absolute
    ...    x=${{(${match[0]['region'].right} + ${match[0]['region'].left})//2}}
    ...    y=${{(${match[0]['region'].bottom} + ${match[0]['region'].top})//2}}

Click Text
    [Documentation]    Left-click on the specified text
    [Arguments]    ${text}
    Move Pointer To Text    ${text}
    EzClick

Click Image
    [Documentation]    Left-click on an image
    [Arguments]    ${destination}
    Move Pointer To ${destination}
    EzClick
