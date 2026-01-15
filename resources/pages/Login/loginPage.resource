*** Settings ***
Resource    ../../keywords/portal_keywords.resource

*** Keywords ***
Login To Portal
    [Arguments]    ${PORTAL_NAME}    ${PORTAL}

    Run Keyword If    '${PORTAL_NAME}' == 'HCS'
    ...    Open Portal And Login To HCS    ${PORTAL}
    ...    ELSE IF    '${PORTAL_NAME}' == 'VMS'
    ...    Open Portal And Login To VMS    ${PORTAL}
    ...    ELSE IF    '${PORTAL_NAME}' == 'MYDEF'
    ...    Open Portal And Login To MYDEF    ${PORTAL}
    ...    ELSE
    ...    Fail    Unsupported portal: ${PORTAL_NAME}

Verify Sign in Page Title
    Verify Page Title    Sign in