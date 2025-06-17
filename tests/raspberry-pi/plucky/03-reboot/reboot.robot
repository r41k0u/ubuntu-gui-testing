*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration
...    yarf:certification_status: blocker


*** Test Cases ***
Assert test init
    Sleep    1
    Match    ${CURDIR}/../rpi-common/screens/big_circle_of_friends.jpg

Click top right toast
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_toast.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/settings_dock.jpg

Click power button
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_btn.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/pwr_opts.jpg

Click Reboot Option
    Click LEFT Button on ${CURDIR}/snapshots/templates/restart_txt.jpg
    Sleep    3
    Match    ${CURDIR}/snapshots/screens/screen_01.jpg

Click Reboot Button
    Click LEFT Button on ${CURDIR}/snapshots/templates/restart_btn.jpg
    Sleep    75
    Match    ${CURDIR}/snapshots/screens/screen_02.jpg

Login
    Keys Combo    Return
    Sleep    1
    Type String    redactedpwd
    Sleep    1
    Keys Combo    Return
    Sleep    10
    Match    ${CURDIR}/../rpi-common/screens/big_circle_of_friends.jpg
