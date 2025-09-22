*** Settings ***
Documentation       Shared resources for application testing

Resource            kvm.resource
Resource            ${Y}/common/common.resource


*** Variables ***
${Y}    ${CURDIR}


*** Keywords ***
User Log In
    [Documentation]    Log in a given user with password
    [Arguments]    ${username}    ${password}
    Match Text    ${username}
    Keys Combo    Return
    Match Text    Password
    Type String    ${password}
    Keys Combo    Return
    BuiltIn.Sleep    5

Clear Terminal
    [Documentation]    Clear terminal from previous commands
    Type String    clear
    Keys Combo     Return
    Match Text     ${PROMPT}    30

Delete Request Rules
    [Documentation]    Delete current request rules for prompting
    Run Sudo Command In Terminal    echo '{"action": "remove", "selector": {"interface": "camera"}}' | sudo snap debug api -X POST -H 'Content-Type: application/json' "/v2/interfaces/requests/rules?user-id=$UID"
    Match Text    ${PROMPT}    30

Run Simple Command
    [Documentation]    Run command in terminal without verifying the exit status
    [Arguments]    ${cmd}
    Type String    ${cmd}
    Keys Combo    Return

Press Button
    [Documentation]    Press action button on the prompt
    [Arguments]    ${text}
    Click LEFT Button On ${text}

Cheese Prompt Is Present
    [Documentation]    Find camera prompt for "cheese"
    Match    ${Y}/generic/cheese_prompt.png    30

Cheese No Device
    [Documentation]    Find "cheese" application open with no device message
    Match    ${Y}/generic/cheese_no_device.png    30

Cheese With Video
    [Documentation]    Find "cheese" application open with fake test video
    Match    ${Y}/generic/cheese_with_video.png    30

Close Application
    [Documentation]    Click on the close application button
    Click LEFT Button On ${Y}/generic/close_button.png
