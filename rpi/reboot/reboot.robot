*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration


*** Test Cases ***
Assert test init
    [Tags]                  yarf:certification_status: blocker
    Sleep                   1
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Click top right toast
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/pwr_toast.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_02.jpg

Click power button
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/pwr_btn.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_03.jpg

Click Reboot Option
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/restart_txt.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_04.jpg

Click Reboot Button
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/restart_btn.jpg
    Sleep                   75
    Match                   ${CURDIR}/snapshots/screens/screen_05.jpg

Login
    [Tags]                  yarf:certification_status: blocker
    Keys Combo              Return
    Sleep                   1
    Type String             redactedpwd
    Sleep                   1
    Keys Combo              Return
    Sleep                   10
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg
