*** Settings ***
Resource    ../../keywords/common_keywords.resource

*** Keywords ***
Select Navigation Option
    [Arguments]    ${OPTION}
    ${path}=    Set Variable
    ...    //nav[contains(@class,'nav-section')]//a[.//span[normalize-space()='${OPTION}']]
    Wait Till Element Visible    xpath:${path}    50s
    Click Element Safely    xpath:${path}
    Wait Till Element Visible    xpath://h1    50s
    Click Element Safely    xpath://h1

Select Bottom Navigation Option
    [Arguments]    ${OPTION}
    ${DROPDOWN_BTN}=    Set Variable    xpath://button[contains(@class,'ats-bottom-dropdown-button')]
    ${OPTION_XPATH}=    Set Variable
    ...    //ul[contains(@class,'ats-bottom-dropdown-menu')]//span[normalize-space()='${OPTION}']
    Wait Till Element Visible    ${DROPDOWN_BTN}    50s
    Click Element Safely    ${DROPDOWN_BTN}
    Wait Till Element Visible    xpath:${OPTION_XPATH}    10s
    Click Element Safely    xpath:${OPTION_XPATH}
