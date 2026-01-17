*** Settings ***
Library     SeleniumLibrary
Library    Collections
Resource    ../variables/global_variables.resource
Resource    ../errors/common_assertions.resource

*** Keywords ***
Wait For Page Loader To Disappear
    [Arguments]    ${TIMEOUT}=${LONG_TIMEOUT}
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${PAGE_LOADER}    ${TIMEOUT}

Wait For Page Ready
    [Arguments]    ${TIMEOUT}=${LONG_TIMEOUT}
    Wait For Page Loader To Disappear    ${TIMEOUT}

Open Browser And Maximize
    [Arguments]    ${URL}    ${BROWSER_NAME}=${BROWSER}
    Open Browser    ${URL}    ${BROWSER_NAME}
    Maximize Browser Window
    Wait For Page Ready

Close Browser Safely
    Run Keyword And Ignore Error    Close Browser

Wait Till Element Visible
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait For Page Ready
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}

Wait Till Element Disappear
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Page Does Not Contain Element    ${LOCATOR}    ${TIMEOUT}

Wait Till Element Enabled
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait For Page Ready
    Wait Until Element Is Enabled    ${LOCATOR}    ${TIMEOUT}

Wait For Spinner To Disappear
    [Arguments]    ${PAGE_LOADER}    ${TIMEOUT}=${LONG_TIMEOUT}
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${PAGE_LOADER}    ${TIMEOUT}

Get Text Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    ${text}=    Get Text    ${LOCATOR}
    RETURN    ${text}

Get Element Count Safely
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}
    ${count}=    Get Element Count    ${LOCATOR}
    RETURN    ${count}

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
    Wait For Page Ready
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

#just want to confirm text exists anywhere
Verify Text Is Visible
    [Arguments]    ${EXPECTED_TEXT}    ${TIMEOUT}=30s
    Wait For Page Ready
    Wait Until Page Contains    ${EXPECTED_TEXT}    ${TIMEOUT}

#exact match node
Verify Exact Text Is Visible
    [Arguments]    ${EXPECTED_TEXT}    ${TIMEOUT}=30s
    ${LOCATOR}=    Set Variable
    ...    xpath=//*[normalize-space()='${EXPECTED_TEXT}']
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}

#validating popup titles
Verify Dialog Header Text
    [Arguments]    ${EXPECTED_TEXT}    ${TIMEOUT}=30s
    ${LOCATOR}=    Set Variable
    ...    xpath=//span[contains(@class,'k-dialog-title') and normalize-space()='${EXPECTED_TEXT}']
    Wait Till Element Visible    ${LOCATOR}    ${TIMEOUT}

Scroll to View Element
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait For Page Ready
    Wait Till Element Visible    ${LOCATOR}    50s
    Scroll Element Into View    ${LOCATOR}

Verify Table Has Column
    [Arguments]    ${column_name}
    Wait For Page Ready
    Page Should Contain Element
    ...    xpath=//th//span[@class='k-column-title' and normalize-space()='${column_name}']

Show All Columns From Menu Filter
    [Arguments]    ${TIMEOUT}=30s
    Wait And Click With Retry    ${FILTER_MENU_BTN}
    Wait Till Element Visible    ${FILTER_MENU_PANEL}    50s
    Click Element Safely    ${SHOW_ALL_BTN}
    Wait For Page Ready
    Press Keys    NONE    ESC
    Wait For Page Ready

Enable Column From Filter Menu
    [Arguments]    ${column_name}    ${TIMEOUT}=30s
    Wait And Click With Retry    ${FILTER_MENU_BTN}
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
    Wait For Page Ready

From Dropdown Verify or Select an Option
    [Arguments]    ${DROPDOWN_LOCATOR}    ${OPTIONS_TEXT_LOCATOR}    ${OPTION_TEXT}    ${ACTION}=select

    Wait And Click With Retry    ${DROPDOWN_LOCATOR}
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
                Wait For Page Ready
            END
            EXIT FOR LOOP
        END
    END

    IF    not ${found}
        Fail    Option '${OPTION_TEXT}' not found in dropdown.
    END

Select Random Element And Return Index And Text
    [Arguments]    ${ELEMENTS_LOCATOR}    ${CLICK}=False    ${TIMEOUT}=60s

    Wait Until Element Is Visible    ${ELEMENTS_LOCATOR}    ${TIMEOUT}
    @{elements}=    Get WebElements    ${ELEMENTS_LOCATOR}

    ${count}=    Get Length    ${elements}
    Run Keyword If    ${count} == 0
    ...    Fail    No elements found using locator: ${ELEMENTS_LOCATOR}

    ${index}=    Evaluate    random.randint(0, ${count}-1)    modules=random
    ${element}=  Get From List    ${elements}    ${index}

    Scroll Element Into View    ${element}
    ${text}=    Get Text    ${element}

    Run Keyword If    '${CLICK}'=='True'    Click Element    ${element}

    ${one_based_index}=    Evaluate    ${index} + 1

    RETURN    ${one_based_index}    ${text}

Get Column Index By Header Text
    [Arguments]    ${HEADER_TITLES_LOCATOR}    ${HEADER_TEXT}
    Wait Till Element Visible    ${HEADER_TITLES_LOCATOR}    50s
    @{headers}=    Get WebElements    ${HEADER_TITLES_LOCATOR}

    ${index}=    Set Variable    0

    FOR    ${h}    IN    @{headers}
        ${index}=    Evaluate    ${index} + 1
        ${txt}=    Get Text    ${h}
        ${txt}=    Evaluate    '${txt}'.strip()
        IF    '${txt}'.lower() == '${HEADER_TEXT}'.lower()
            RETURN    ${index}
        END
    END

    Fail    Header '${HEADER_TEXT}' not found

Verify All Rows In Column Have Element
    [Arguments]
    ...    ${HEADER_TITLES_LOCATOR}
    ...    ${HEADER_TEXT}
    ...    ${ROWS_XPATH}
    ...    ${CELL_ELEMENT_XPATH}

    Wait For Page Ready

    ${col_index}=    Get Column Index By Header Text
    ...    ${HEADER_TITLES_LOCATOR}
    ...    ${HEADER_TEXT}

    @{rows}=    Get WebElements    xpath=${ROWS_XPATH}
    ${row_count}=    Get Length    ${rows}

    FOR    ${i}    IN RANGE    1    ${row_count}+1
        ${count}=    Get Element Count
        ...    xpath=(${ROWS_XPATH})[${i}]/td[${col_index}]${CELL_ELEMENT_XPATH}

        IF    ${count} == 0
            Fail    Element not found in row ${i} under column '${HEADER_TEXT}'
        END
    END

    Log    All rows under '${HEADER_TEXT}' contain required element

