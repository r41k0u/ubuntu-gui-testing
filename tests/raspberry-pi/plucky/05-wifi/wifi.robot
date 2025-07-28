*** Settings ***
Documentation             Connect to wifi access point
Resource        kvm.resource

Test Tags
...    robot:stop-on-failure
...    yarf:category_id:com.canonical.yarf::basic
...    yarf:test_group_id:com.canonical.yarf::integration
...    yarf:certification_status:blocker
# Comments:
# - I make the following assumptions:
#    + The WiFi scanning is enabled by default on the DUT.
#    + It is not connected to any WiFi network.
#    + A WiFi AP named "Canonical" with password "adroitreliable" is available.


*** Test Cases ***
Assert test init
    [Documentation]         Ensure we're ready to start the test
    Sleep    1
    Match    ${CURDIR}/../rpi-common/screens/big_circle_of_friends.jpg

Click top right toast
    [Documentation]         Click the top right shutdown/reboot widget
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_toast.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/settings_dock.jpg

Go to settings
    [Documentation]         Go to settings part of widget
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/cog.jpg
    Sleep    20
    Match    ${CURDIR}/snapshots/templates/wifi_tab.jpg

Go to WiFi tab
    [Documentation]         Open wifi settings
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_tab.jpg
    Sleep    15
    Match    ${CURDIR}/snapshots/templates/wifi_ap.jpg

Select WiFi AP
    [Documentation]         Choose a wifi access point
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_ap.jpg
    Sleep    15
    Move Pointer To (100, 100)
    Match    ${CURDIR}/snapshots/templates/pwd_dialog.jpg

Enter password and connect
    [Documentation]         Enter password and connect to AP
    Type String    adroitreliable
    Sleep    1
    Keys Combo    Return
    Sleep    15
    Match    ${CURDIR}/snapshots/templates/conn_cnf.jpg

Close window
    [Documentation]         Close wifi settings window
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/close.jpg
    Sleep    10
    Match    ${CURDIR}/../rpi-common/screens/big_circle_of_friends.jpg
