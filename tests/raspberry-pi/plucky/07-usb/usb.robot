*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration

# Comments:
# - I make the following assumptions:
#   + The USB flash drive is connected
#   + It has an Ubuntu logo SVG inside (and that is the only thing)


*** Test Cases ***
Assert test init
    [Tags]                  yarf:certification_status: blocker
    Sleep                   5
    Match                   ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg

Click USB icon
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/usb_icon.jpg
    Move Pointer To (100, 100)
    Sleep                   10
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Click Ubuntu logo
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/svg_icon.jpg
    Click LEFT Button
    Move Pointer To (100, 100)
    Sleep                   5
    Match                   ${CURDIR}/snapshots/templates/final_img.jpg

Exit image viewer
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/dark_cross.jpg
    Move Pointer To (100, 100)
    Sleep                   5
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Exit folder
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/light_cross.jpg
    Move Pointer To (100, 100)
    Sleep                   5
    Match                   ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg
