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
    ${LOCATOR}=    Set Variable    xpath=//li[@role='tab' and @aria-selected='true']//span[normalize-space()='${TAB_NAME}']
    Wait Till Element Visible    ${LOCATOR}    30s

Verify Current Section Is Active
    [Arguments]    ${SECTION_NAME}
    ${LOCATOR}=    Set Variable    xpath=//div[contains(@class,'analytics-card') and contains(@class,'active')]//h2[normalize-space()='${SECTION_NAME}']
    Wait Till Element Visible    ${LOCATOR}    30s
    
Verify Page Title
    [Arguments]    ${expected_title}    ${TIMEOUT}=30s
    ${LOCATOR}=    Set Variable    xpath://h1[normalize-space()='${expected_title}']
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}
    Element Text Should Be    ${LOCATOR}    ${expected_title}

Scroll to View Element
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    50s
    Scroll Element Into View    ${LOCATOR}

Verify Table Has Column
    [Arguments]    ${column_name}
    Sleep    5s
    Page Should Contain Element
    ...    xpath=//th//span[@class='k-column-title' and normalize-space()='${column_name}']

Show All Columns From Menu Filter
    [Arguments]    ${TIMEOUT}=30s
    Wait Till Element Visible    ${FILTER_MENU_BTN}    50s
    Click Element Safely        ${FILTER_MENU_BTN}
    Wait Till Element Visible    ${FILTER_MENU_PANEL}    50s
    Click Element Safely    ${SHOW_ALL_BTN}
    Sleep    3s
    Press Keys    NONE    ESC

Enable Column From Filter Menu
    [Arguments]    ${column_name}    ${TIMEOUT}=30s
    Wait Till Element Visible    ${FILTER_MENU_BTN}    50s
    Click Element Safely       ${FILTER_MENU_BTN}
    Wait Till Element Visible    ${FILTER_MENU_PANEL}    ${TIMEOUT}

    Input Text Safely    ${FILTER_SEARCH_INPUT}    ${column_name}
    Sleep    2s

    ${toggle}=    Set Variable
    ...    xpath://div[contains(@class,'filter-manageCols')]//div[contains(@class,'toggle-wrapper')][.//text()[normalize-space()='${column_name}']]//span[@role='switch']

    Wait Till Element Visible    ${toggle}    ${TIMEOUT}

    ${state}=    Get Element Attribute    ${toggle}    aria-checked
    Run Keyword If    '${state}'=='false'    Click Element    ${toggle}

    Sleep    1s
    Press Keys    NONE    ESC

From Dropdown Verify or Select an Option
    [Arguments]    ${DROPDOWN_LOCATOR}    ${OPTIONS_TEXT_LOCATOR}    ${OPTION_TEXT}    ${ACTION}=select

    Wait Till Element Visible    ${DROPDOWN_LOCATOR}    50s
    Click Element Safely        ${DROPDOWN_LOCATOR}

    Wait Till Element Visible    ${OPTIONS_TEXT_LOCATOR}    50s
    @{elements}=    Get WebElements    ${OPTIONS_TEXT_LOCATOR}

    ${found}=    Set Variable    False

    FOR    ${el}    IN    @{elements}
        ${txt}=    Get Text    ${el}
        ${txt}=    Evaluate    '${txt}'.strip()
        IF    '${txt}'.lower() == '${OPTION_TEXT}'.lower()
            ${found}=    Set Variable    True
            IF    '${ACTION}' == 'select'
                Wait Till Element Enabled    ${el}    50s
                Click Element    ${el}
            END
            EXIT FOR LOOP
        END
    END

    Run Keyword Unless    ${found}
    ...    Fail    Option '${OPTION_TEXT}' not found in dropdown.
