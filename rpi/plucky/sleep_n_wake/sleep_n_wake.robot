*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration


*** Test Cases ***
Assert Test init
    [Tags]                  yarf:certification_status: blocker
    Sleep                   1
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Sleep
    [Tags]                  yarf:certification_status: blocker
    Keys Combo		        Meta_L		    l
    Sleep		            5
    Match		            ${CURDIR}/snapshots/screens/screen_02.jpg

Login Prompt
    [Tags]                  yarf:certification_status: blocker
    Move Pointer To (100, 100)
    Sleep		            1
    Click LEFT Button
    Sleep                   1
    Match		            ${CURDIR}/snapshots/screens/screen_03.jpg

Desktop
    [Tags]		            yarf:certification_status: blocker
    Type String		        redactedpwd
    Sleep                   1
    Keys Combo              Return
    Sleep		            5
    Match		            ${CURDIR}/snapshots/screens/screen_01.jpg
