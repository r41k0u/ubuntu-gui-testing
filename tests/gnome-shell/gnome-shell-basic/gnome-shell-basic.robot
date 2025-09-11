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
    Match Text    Files
    Match Text    Home
    Match Text    Recent
    Click On Dock App    App Center
    Match Text    App Center
    Match Text    Explore
    Match Text    Featured

Alt Tab
    [Documentation]         Alt tab back to Nautilus
    Keys Combo    Alt    Tab
    Match Text    Files
    Match Text    Home
    Match Text    Recent
    Close All Windows

Open Files
    [Documentation]         Open Nautilus again
    Click Circle of Friends
    Type String    Files
    Match Text    Files
    Keys Combo    Return
    Match Text    Recent
    Match Text    Starred
    Click Text    Recent

Window Switching
    [Documentation]         Switch between windows of Nautilus
    Move Pointer To ${Y}/generic/nautilus.png
    EzRightClick
    Match Text    New Window
    Click Text    New Window
    Click Image    ${Y}/generic/nautilus.png
    Match Text    No Recent Files
    Keys Combo    Tab
    Keys Combo    Return

Notification Panel
    [Documentation]         Open the notification panel
    Move Pointer To Proportional (0.5, 0)
    EzClick
    Match Text    Do Not Disturb
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
    Match Text    Home
    # Switch to left workspace with keyboard
    Workspace Left
    Match Text    Recent

Shell Lock
    [Documentation]         Lock the screen, and log back in
    Toggle System Panel
    Click Lock Button
    Keys Combo    Return
    Type String    ubuntu
    Keys Combo    Return
    Match    ${X}/circle-of-friends.png    60

Shell Log Out
    [Documentation]         Log out of desktop environment
    Toggle System Panel
    Click Power Button
    Click Log Out
