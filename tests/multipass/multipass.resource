*** Settings ***
Documentation       Shared resources for Multipass testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
Install Multipass
    [Documentation]    Install Multipass as a snap
    Install Snap Package    multipass

Open Multipass
    [Documentation]    Open Multipass and verify that it has loaded
    Start Application    /snap/bin/multipass.gui
    Match Text    Multipass
    Match Text    Welcome to Multipass
    Match Text    Get an instant VM or application in seconds

Verify No Instances
    [Documentation]    Verify that there are no instances currently, starting from the catalogue screen.
    Move Pointer To ${Y}/generic/instances.png
    Match Text    Instances
    EzClick
    Match Text    Zero Intances
    Move Pointer To ${Y}/generic/catalogue.png
    EzClick

Prevent Sleep
    [Documentation]    Prevent the system from sleeping during the test
    Open Terminal
    Run Command In Terminal    gsettings set org.gnome.desktop.session idle-delay 0
    Close Terminal

Launch Instance
    [Documentation]    Launch a random instance and ensure it ends up in a running state
    Move Pointer To ${y}/generic/launch.png
    EzClick
    Match Text    Launching
    Match Text    Downloading Image
    Move Pointer To ${y}/generic/instance-details.png
    EzClick
    Move Pointer To Proportional (0, 0)
    Wait Until Keyword Succeeds
    ...    600 seconds
    ...    5 seconds
    ...    Match
    ...    ${y}/generic/instance-details-running.png

Return to Catalogue
    [Documentation]    Return to the Catalogue from Instances
    Move Pointer To ${Y}/generic/catalogue.png
    Match Text    Catalogue
    EzClick
    Match Text    Welcome to Multipass

Delete Single Instance
    [Documentation]    Delete a single existing instance
    Move Pointer To ${Y}/generic/instances-1.png
    Match Text    Instances
    EzClick
    Move Pointer To Proportional (0, 0)
    Move Pointer To ${Y}/generic/instances-checkbox.png
    EzClick
    Move Pointer To ${Y}/generic/instances-delete.png
    EzClick
    BuiltIn.Sleep    1
    Move Pointer To ${Y}/generic/instances-delete.png
    EzClick
    Wait Until Keyword Succeeds    15 seconds    3 seconds    Match Text    Zero Instances

Close Multipass
    [Documentation]    Close Multipass
    Move Pointer To ${Y}/generic/app-exit.png
    EzClick
    Wait Until Keyword Succeeds
    ...    10 seconds
    ...    2 seconds
    ...    Run Keyword And Expect Error
    ...    *
    ...    Match Text
    ...    Multipass
