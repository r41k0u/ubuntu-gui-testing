*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration
...    yarf:certification_status: blocker


*** Test Cases ***
Assert Test init
    Sleep    1
    Match    ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg

Sleep
    Keys Combo    Meta_L    l
    Sleep    5
    Match    ${CURDIR}/../rpi-common/screens/no_signal.jpg

Login Prompt
    Move Pointer To (100, 100)
    Sleep    1
    Click LEFT Button
    Sleep    1
    Match    ${CURDIR}/snapshots/screens/screen_01.jpg

Desktop
    Type String    redactedpwd
    Sleep    1
    Keys Combo    Return
    Sleep    5
    Match    ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg
