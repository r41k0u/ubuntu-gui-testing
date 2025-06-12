*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration
...    yarf:certification_status: blocker
# Comments:
# - I make the following assumptions:
#    + The WiFi scanning is enabled by default on the DUT.
#    + It is not connected to any WiFi network.
#    + A WiFi AP named "Canonical" with password "adroitreliable" is available.


*** Test Cases ***
Assert test init
    Sleep    1
    Match    ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg

Click top right toast
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_toast.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/settings_dock.jpg

Go to settings
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/cog.jpg
    Sleep    3
    Match    ${CURDIR}/snapshots/templates/wifi_tab.jpg

Go to WiFi tab
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_tab.jpg
    Sleep    15
    Match    ${CURDIR}/snapshots/templates/wifi_ap.jpg

Select WiFi AP
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_ap.jpg
    Sleep    3
    Move Pointer To (100, 100)
    Match    ${CURDIR}/snapshots/templates/pwd_dialog.jpg

Enter password and connect
    Type String    adroitreliable
    Sleep    1
    Keys Combo    Return
    Sleep    15
    Match    ${CURDIR}/snapshots/templates/conn_cnf.jpg

Close window
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/close.jpg
    Sleep    3
    Match    ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg
