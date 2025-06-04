*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration

# Comments:
# - I make the following assumptions:
#   + The WiFi scanning is enabled by default on the DUT.
#   + It is not connected to any WiFi network.
#   + A WiFi AP named "Canonical" with password "adroitreliable" is available.


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

Go to settings
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/cog.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/templates/wifi_tab.jpg

Go to WiFi tab
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_tab.jpg
    Sleep                   15
    Match                   ${CURDIR}/snapshots/templates/wifi_ap.jpg

Select WiFi AP
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/wifi_ap.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/templates/pwd_dialog.jpg

Enter password and connect
    [Tags]                  yarf:certification_status: blocker
    Type String             adroitreliable 
    Sleep                   1
    Keys Combo              Return
    Sleep                   15
    Match                   ${CURDIR}/snapshots/templates/conn_cnf.jpg

Close window
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/close.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg
