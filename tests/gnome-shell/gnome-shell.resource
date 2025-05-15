*** Settings ***
Documentation       Shared resources for Gnome Shell testing

Library            String

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
Toggle System Panel
    [Documentation]    Opens the top right system panel
    Click Image    ${Y}/generic/system-panel.png

Click Power Button
    [Documentation]    Click the power button in the system panel
    Click Image    ${Y}/generic/power-button.png
    PlatformVideoInput.Match Text    "Log out..."

User Log In
    [Documentation]    Log in a given user with password
    [Arguments]    ${username}    ${password}
    PlatformVideoInput.Match Text    ${username}
    Click Text    ${username}
    PlatformVideoInput.Match Text    Password
    PlatformHid.Type String    ${password}
    PlatformHid.Keys Combo    Return
    PlatformVideoInput.Match    ${X}/circle-of-friends.png    60

Click Lock Button
    [Documentation]    Click the lock button in the system panel
    Click Image    ${Y}/generic/lock.png

Click Log Out
    [Documentation]    Click the log out button in the power system panel
    Click Text    Log Out...
    Click Text Nth    Log Out    1
    PlatformVideoInput.Match Text    "Not listed"

Click Circle of Friends
    [Documentation]    Click the circle of friends in the dock
    Click Image    ${Y}/generic/circle-of-friends.png
    PlatformVideoInput.Match Text    "Type to search"

EzRightClick
    [Documentation]    EZClick but with right click
    BuiltIn.Sleep    0.5
    Click RIGHT Button
    BuiltIn.Sleep    0.5
    Move Pointer To (100, 100)

Workspace Left
    [Documentation]    Switch to the left workspace via the keyboard
    PlatformHid.Keys Combo    Super    Page_Up

Workspace Right
    [Documentation]    Switch to the right workspace via the keyboard
    PlatformHid.Keys Combo    Super    Page_Down

Move Pointer To Text
    [Arguments]    ${text}
    ${match}    PlatformVideoInput.Match Text    ${text}
    Move Point To Text Nth    ${text}    0

Move Point To Text Nth
    [Documentation]    Moves the pointer to the nth occurrence of the text
    [Arguments]    ${text}    ${n}
    # https://github.com/canonical/ubuntu-gui-testing/pull/5/files#diff-88f4ce867cfe634d1771f32a4f5b3ebc70348744992fc4305d79d3e422845524R68-R73
    ${match}    PlatformVideoInput.Match Text    ${text}
    PlatformHid.Move Pointer To Absolute
    ...    x=${{(${match[${n}]['region'].right} + ${match[${n}]['region'].left})//2}}
    ...    y=${{(${match[${n}]['region'].bottom} + ${match[${n}]['region'].top})//2}}

Click Text
    [Documentation]    Left-click on the specified text
    [Arguments]    ${text}
    Move Pointer To Text    ${text}
    EzClick

Click Text Nth
    [Documentation]    Left-click the nth occurence of the specified text
    [Arguments]    ${text}    ${n}
    Move Point To Text Nth    ${text}    ${n}
    EzClick

Click Image
    [Documentation]    Left-click on an image
    [Arguments]    ${destination}
    Move Pointer To ${destination}
    EzClick

Look For Text In Screen
    [Documentation]    Look for the given text on the screen without waiting, returning
        ...    the string, or empty if nothing is found.
    [Arguments]    ${target_txt}
    ${txt}    PlatformVideoInput.Read Text
    ${split}    Split String    ${txt}    \n

    FOR    ${t}    IN    @{split}
        ${strip}    Strip String    ${t}
        IF    "${strip}" == "${target_txt}"
            RETURN     "${t}"
        END
    END

    RETURN    ""

Move Pointer To Dock Icon
    [Documentation]    Moves the pointer over the launcher icon with such label
    [Arguments]    ${label}
    Move Pointer To (5, 0)

    ${screenshot}    Grab Screenshot    # Hacky way to get screen height
    FOR    ${index}    IN RANGE  ${${screenshot.size[1]}/5}
        Walk Pointer To (5, ${{${index}*5}})
        ${txt}    Look For Text In Screen    ${label}

        IF     ${txt}
            BREAK
        END
    END

Click On Dock App
    [Documentation]    Launches an app from the dock, based on its name
    [Arguments]    ${app}
    Move Pointer To Dock Icon    ${app}
    EzClick

RightClick On Dock App
    [Documentation]    Right-clicks an app in the dock, based on its name
    [Arguments]    ${app}
    Move Pointer To Dock Icon    ${app}
    EzRightClick
