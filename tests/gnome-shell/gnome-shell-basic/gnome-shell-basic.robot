*** Settings ***
Documentation       General Gnome Shell tests

Resource            ${Z}/../gnome-shell.resource

Test Tags           robot:exit-on-failure    # robocop: off=tag-with-reserved-word


*** Variables ***
${Z}    ${CURDIR}


*** Test Cases ***
Setup
    [Documentation]         Use rapidocr rather than tesseract-ocr in yarf
    Set Ocr Method    rapidocr

Shell Log In
    [Documentation]         Log in to desktop environment
    User Log In    ubuntu    ubuntu

Open Apps
    [Documentation]         Open app centre
    Click On Dock App    Files
    PlatformVideoInput.Match Text    Files
    PlatformVideoInput.Match Text    Home
    PlatformVideoInput.Match Text    Recent
    Click On Dock App    App Center
    PlatformVideoInput.Match Text    App Center
    PlatformVideoInput.Match Text    Explore
    PlatformVideoInput.Match Text    Featured

Alt Tab
    [Documentation]         Alt tab back to Nautilus
    PlatformHid.Keys Combo    Alt    Tab
    PlatformVideoInput.Match Text    Files
    PlatformVideoInput.Match Text    Home
    PlatformVideoInput.Match Text    Recent
    Close All Windows

Open Files
    [Documentation]         Open Nautilus again
    Click Circle of Friends
    PlatformHid.Type String    Files
    PlatformVideoInput.Match Text    Files
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match Text    Recent
    PlatformVideoInput.Match Text    Starred
    Click Text    Recent

Window Switching
    [Documentation]         Switch between windows of Nautilus
    Move Pointer To ${Y}/generic/nautilus.png
    EzRightClick
    PlatformVideoInput.Match Text    New Window
    Click Text    New Window
    Click Image    ${Y}/generic/nautilus.png
    PlatformVideoInput.Match Text    No Recent Files
    PlatformHid.Keys Combo    Tab
    PlatformHid.Keys Combo    Return

Notification Panel
    [Documentation]         Open the notification panel
    Move Pointer To Proportional (0.5, 0)
    EzClick
    PlatformVideoInput.Match Text    Do Not Disturb
    Move Pointer To Proportional (0.5, 0)
    EzClick

Workspace Switching
    [Documentation]         Switch to a new workspace, and then back again
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
    [Documentation]         Lock the screen, and log back in
    Toggle System Panel
    Click Lock Button
    PlatformHid.Keys Combo    Return
    PlatformHid.Type String    ubuntu
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match    ${X}/circle-of-friends.png    60

Shell Log Out
    [Documentation]         Log out of desktop environment
    Toggle System Panel
    Click Power Button
    Click Log Out
