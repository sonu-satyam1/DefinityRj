*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/global_variables.py

*** Keywords ***
Open Browser And Maximize
    [Arguments]    ${URL}    ${BROWSER_NAME}=${BROWSER}
    Open Browser    ${URL}    ${BROWSER_NAME}
    Maximize Browser Window

Close Browser Safely
    Run Keyword And Ignore Error    Close Browser

Wait Till Element Visible
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}

Wait Till Element Enabled
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${LOCATOR}    ${TIMEOUT}

Wait Till Element Disappears
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Not Visible    ${LOCATOR}    ${TIMEOUT}

Wait For Spinner To Disappear
    [Arguments]    ${SPINNER_LOCATOR}    ${TIMEOUT}=${LONG_TIMEOUT}
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${SPINNER_LOCATOR}    ${TIMEOUT}

Wait Till Page Loaded
    [Arguments]    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Page Contains Element    xpath=//body    ${TIMEOUT}

Click Element Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Enabled    ${LOCATOR}    ${TIMEOUT}
    Click Element                ${LOCATOR}

Input Text Safely
    [Arguments]    ${LOCATOR}    ${TEXT}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    Clear Element Text           ${LOCATOR}
    Input Text                   ${LOCATOR}    ${TEXT}

Wait And Click With Retry
    [Arguments]    ${LOCATOR}
    Wait Until Keyword Succeeds
    ...    ${RETRY_COUNT}
    ...    ${POLLING_INTERVAL}
    ...    Click Element Safely    ${LOCATOR}