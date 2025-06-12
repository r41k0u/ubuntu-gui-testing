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
    Match    ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg

Click top right toast
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_toast.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/settings_dock.jpg

Click power button
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_btn.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/pwr_opts.jpg

Click Power off Option
    Click LEFT Button on ${CURDIR}/snapshots/templates/pwr_off_txt.jpg
    Sleep    3
    Match    ${CURDIR}/snapshots/screens/screen_01.jpg

Click Power off Button
    Click LEFT Button on ${CURDIR}/snapshots/templates/pwr_off_btn.jpg
    Sleep    20
    Match    ${CURDIR}/../rpi-common/screens/no_signal.jpg
