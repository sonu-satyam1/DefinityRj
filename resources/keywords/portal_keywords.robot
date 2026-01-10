*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Portal And Login
    [Arguments]    ${PORTAL}

    Open Browser    ${PORTAL['url']}    chrome
    Maximize Browser Window

    Input Text     id=username    ${PORTAL['user']}
    Input Text     id=password    ${PORTAL['pass']}
    Click Button   id=login
