*** Settings ***
Resource        kvm.resource

Task Tags
...    robot:stop-on-failure
...    yarf:category_id: com.canonical.yarf::basic
...    yarf:test_group_id: com.canonical.yarf::integration

# Comments:
# - Initial wait is 240 seconds for boot.
# - Sleep 1 second after each input.
# - Sleep 3 seconds before Match except for exceptions.
# - Exceptions:
#   + Password Screen
#   + Setup Complete
#   + Finish Screen
# - Move Pointer to (100, 100) before Matching so it doesn't
#   interfere with button template Matching.
# - Double tabs in Name Select and Password Select to go over
#   dropdown and "show password" button

# TODO:
# - Shall I add a 1 second Sleep after Move Pointer as well?

*** Test Cases ***
Assert Test init
    [Tags]                  yarf:certification_status: blocker
    Sleep                   240
    Match                   ${CURDIR}/snapshots/screens/screen_01.jpg

Language Select
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/lang_eng.jpg
    Sleep                   1
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_02.jpg

Keyboard Select
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_03.jpg

WiFi Screen
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/skip_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_04.jpg

Timezone Select
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/tz_ind.jpg
    Sleep                   1
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_05.jpg

Name Select
    [Tags]                  yarf:certification_status: blocker
    Type String             testuser
    Sleep                   1
    Keys Combo              Tab
    Sleep                   1
    Type String             raikou
    Sleep                   1
    Keys Combo              Tab
    Sleep                   1
    Keys Combo              Tab
    Sleep                   1
    Type String             pi
    Sleep                   1
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_06.jpg

Password Select
    [Tags]                  yarf:certification_status: blocker
    Type String             redactedpwd
    Sleep                   1
    Keys Combo              Tab
    Sleep                   1
    Keys Combo              Tab
    Type String             redactedpwd
    Sleep                   2
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   10
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_07.jpg

Langpack Download
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/cancel_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_08.jpg

Setup Complete
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/start_btn.jpg
    Sleep                   20
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_09.jpg

Welcome Screen
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_10.jpg

Consent Screen
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/next_btn.jpg
    Sleep                   3
    Move Pointer To (100, 100)
    Match                   ${CURDIR}/snapshots/screens/screen_11.jpg

Finish Screen
    [Tags]                  yarf:certification_status: blocker
    Click LEFT Button on ${CURDIR}/snapshots/templates/finish_btn.jpg
    Sleep                   5
    Match                   ${CURDIR}/../rpi-common/screens/plucky_mascot.jpg
