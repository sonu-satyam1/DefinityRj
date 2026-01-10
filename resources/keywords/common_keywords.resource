*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/global_variables.resource

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

Wait Till Element Disappear
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Page Does Not Contain Element    ${LOCATOR}    ${TIMEOUT}

Wait Till Element Enabled
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${LOCATOR}    ${TIMEOUT}

Wait For Spinner To Disappear
    [Arguments]    ${PAGE_LOADER}    ${TIMEOUT}=${LONG_TIMEOUT}
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${PAGE_LOADER}    ${TIMEOUT}

Get Text Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    ${text}=    Get Text    ${LOCATOR}
    [Return]    ${text}

Input Text Safely
    [Arguments]    ${LOCATOR}    ${TEXT}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    Clear Element Text           ${LOCATOR}
    Input Text                   ${LOCATOR}    ${TEXT}

Click Element Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Enabled    ${LOCATOR}    ${TIMEOUT}
    Click Element                ${LOCATOR}

Wait And Click With Retry
    [Arguments]    ${LOCATOR}
    Wait Until Keyword Succeeds
    ...    ${RETRY_COUNT}
    ...    ${POLLING_INTERVAL}
    ...    Click Element Safely    ${LOCATOR}

Click Outside To Close Popup
    Wait Till Element Disappear    ${PAGE_LOADER}    30s
    Click Element    xpath=//body
