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
    Match                   ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg

Click top right toast
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/pwr_toast.jpg
    Sleep                   3
    Match                   ${CURDIR}/../rpi-common/screens/settings_dock.jpg

Go to settings
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/cog.jpg
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
    Click LEFT Button on ${CURDIR}/../rpi-common/templates/close.jpg
    Sleep                   3
    Match                   ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg
