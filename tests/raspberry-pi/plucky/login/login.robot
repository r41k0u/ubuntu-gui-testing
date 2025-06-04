*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration


*** Test Cases ***
Assert test init
    [Tags]                  yarf:certification_status: blocker
    Sleep                   240
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Enter password screen
    [Tags]                  yarf:certification_status: blocker
    Keys Combo              Return
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_02.jpg

Login
    [Tags]                  yarf:certification_status: blocker
    Type String             redactedpwd
    Sleep                   1
    Keys Combo              Return
    Sleep                   20
    Match                   ${CURDIR}/snapshots/screens/screen_03.jpg
