*** Settings ***
Documentation    General Gnome Shell tests
Resource        ${Z}/../gnome-shell.resource

Test Tags       robot:exit-on-failure


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Shell Log In
    Log In

Open Files
    Click Circle of Friends
    PlatformHid.Type String     Files
    PlatformVideoInput.Match Text    Files
    ${ret}    Create List    Return
    PlatformHid.Keys Combo    ${ret}
    PlatformVideoInput.Match Text    Recent
    PlatformVideoInput.Match Text    Starred
    Click Text    Recent

Window Switching
    Move Pointer To ${Y}/generic/nautilus.png
    EzRightClick
    PlatformVideoInput.Match Text    New Window
    Click Text   New Window
    Click Image    ${Y}/generic/nautilus.png
    PlatformVideoInput.Match Text    No Recent Files
    ${tab}    Create List    Tab
    PlatformHid.Keys Combo    ${tab}
    ${ret}    Create List    Return
    PlatformHid.Keys Combo    ${ret}

Notification Panel
    Move Pointer To Proportional (0.5, 0)
    EzClick
    PlatformVideoInput.Match Text    Do Not Disturb
    Move Pointer To Proportional (0.5, 0)
    EzClick

Workspace Switching
    # Switch to right workspace with clicks
    Move Pointer To Proportional (0, 0)
    EzClick
    Move Pointer To Proportional (1, 0.5)
    EzClick
    Move Pointer To Proportional (0.5, 0.5)
    EzClick
    PlatformVideoInput.Match Text    Home
    # Switch to left workspace with keyboard
    Workspace Left
    PlatformVideoInput.Match Text    Recent

Shell Lock
    Toggle System Panel
    Click Lock Button
    ${ret}    Create List    Return
    PlatformHid.Keys Combo    ${ret}
    PlatformHid.Type String    ubuntu
    PlatformHid.Keys Combo    ${ret}
    PlatformVideoInput.Match    ${X}/circle-of-friends.png    60

Shell Log Out
    Toggle System Panel
    Click Power Button
    Click Log Out
