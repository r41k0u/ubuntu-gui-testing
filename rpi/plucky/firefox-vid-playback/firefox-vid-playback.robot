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

Open Firefox and open a new tab
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/firefox.jpg
    Sleep                   15
    Keys Combo              Control_L       t
    Sleep                   1
    Match                   ${CURDIR}/snapshots/templates/new_tab.jpg

Run video and match first frame
    [Tags]                  yarf:certification_status: blocker
    Type String             https://people.ubuntu.com/~r41k0u/output_video.mp4
    Sleep                   1
    Keys Combo              Return
    Sleep                   1
    Match                   ${CURDIR}/snapshots/templates/firefox_frame.jpg

Match last frame
    [Tags]                  yarf:certification_status: blocker
    Sleep                   16
    Match                   ${CURDIR}/snapshots/templates/ubu_frame.jpg

Close Firefox
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/close.jpg
    Sleep                   3
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg
