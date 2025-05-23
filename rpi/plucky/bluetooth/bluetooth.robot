*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration

# Comments:
# - I make the following assumptions:
#   + The BT scanning is enabled by default on the DUT.
#   + It is not connected to any BT device.


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
    Match                   ${CURDIR}/snapshots/templates/bt_tab.jpg

Go to BT tab
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/bt_tab.jpg
    Sleep                   30
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/templates/ts_bt.jpg

Connect to TS BT
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/ts_bt.jpg
    Move Pointer To (100, 100)
    Sleep                   30
    Match                   ${CURDIR}/snapshots/templates/conn_cnf.jpg

Close window
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/close.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg
