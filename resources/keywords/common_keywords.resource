*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/global_variables.resource
Resource    ../errors/common_assertions.resource

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

Get Element Count Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    ${count}=    Get Element Count    ${LOCATOR}
    [Return]    ${count}

Input Text Safely
    [Arguments]    ${LOCATOR}    ${TEXT}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    Clear Element Text           ${LOCATOR}
    Input Text                   ${LOCATOR}    ${TEXT}

Click Element Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Enabled    ${LOCATOR}    ${TIMEOUT}
    Click Element                ${LOCATOR}

Scroll to View Element
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    Scroll Element Into View    ${LOCATOR}

Wait And Click With Retry
    [Arguments]    ${LOCATOR}
    Wait Until Keyword Succeeds
    ...    ${RETRY_COUNT}
    ...    ${POLLING_INTERVAL}
    ...    Click Element Safely    ${LOCATOR}

Click Outside To Close Popup
    Wait Till Element Disappear    ${PAGE_LOADER}    30s
    Click Element    xpath=//body

Verify Current Tab Is Active
    [Arguments]    ${TAB_NAME}
    ${locator}=    Set Variable    xpath=//li[@role='tab' and @aria-selected='true']//span[normalize-space()='${TAB_NAME}']
    Wait Till Element Visible    ${locator}    30s

Verify Current Section Is Active
    [Arguments]    ${SECTION_NAME}
    ${locator}=    Set Variable    xpath=//div[contains(@class,'analytics-card') and contains(@class,'active')]//h2[normalize-space()='${SECTION_NAME}']
    Wait Till Element Visible    ${locator}    30s
    
Verify Page Title
    [Arguments]    ${expected_title}    ${TIMEOUT}=30s
    ${locator}=    Set Variable    xpath://h1[normalize-space()='${expected_title}']
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Element Text Should Be    ${locator}    ${expected_title}

Scroll To Column Header
    [Arguments]    ${COLUMN_NAME}

    ${header}=    Set Variable
    ...    xpath=//th//span[@class='k-column-title' and normalize-space()='${COLUMN_NAME}']

    Wait Until Keyword Succeeds    5x    2s
    ...    Scroll Element Into View    ${header}

    Wait Till Element Visible    ${header}    10s


#Get Column Index By Name
#    [Arguments]    ${COLUMN_NAME}
#    ${header}=    Set Variable
#    ...    xpath=//th//span[@class='k-column-title' and normalize-space()='${COLUMN_NAME}']
#    Log    ${header}
#    Scroll to View Element    xpath://th[.//span[text()='${COLUMN_NAME}']]
#
#    ${index}=    Get Element Attribute
#    ...    xpath=//th[.//span[normalize-space()='${COLUMN_NAME}']]
#    ...    aria-colindex
#
#    Should Not Be Empty    ${index}    Column '${COLUMN_NAME}' not found in grid
#    [Return]    ${index}


#Get Column Index By Name
#    [Arguments]    ${COLUMN_NAME}
#    Wait Till Element Disappear    ${PAGE_LOADER}    30s
#
#    @{headers}=    Get WebElements    xpath=//th//span[@class='k-column-title']
#
#    ${col_index}=    Set Variable    -1
#
#    FOR    ${i}    ${h}    IN ENUMERATE    @{headers}
#        ${text}=    Get Text    ${h}
#        IF    '${text}' == '${COLUMN_NAME}'
#            ${col_index}=    Evaluate    ${i} + 1
#            EXIT FOR LOOP
#        END
#    END
#
#    Run Keyword If    ${col_index} == -1
#    ...    Fail    Column '${COLUMN_NAME}' not found
#
#    [Return]    ${col_index}
#
#
