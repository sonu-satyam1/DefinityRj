*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Library     String
Library     Collections
Library     OperatingSystem
Library     BuiltIn
Variables    ../../../testdata/generateRandomData.py



*** Variables ***
${file_path}                        ${CURDIR}${/}resume.jpg
${document_name}                    resume.jpg
# Filter Dialog Locators (Extracted from HTML Snippet)
${VMS_FILTER_POPOVER}           css:.MuiPopover-paper
${VMS_FILTER_FORM}              xpath://form[contains(@action, "#")]
${VMS_COLUMN_DROPDOWN}          xpath://label[text()="Column"]/preceding-sibling::span//input[@role="combobox"]
${VMS_OPERATOR_DROPDOWN}        xpath://label[text()="Operator"]/preceding-sibling::span//input[@role="combobox"]
${VMS_VALUE_INPUT}              xpath://label[text()="Value"]/preceding-sibling::div//input[@role="combobox"]
${VMS_TEXT_VALUE_INPUT}         //input[contains(@class,'k-input') and @name='value']
${VMS_APPLY_BUTTON}             xpath://button[contains(@class, "pr-btn-primary")]//span[text()="Apply"]

# Table/Grid Locators (Assumed based on common patterns and "3 dots" description)
${VMS_STATUS_COLUMN_3DOTS}      xpath://th[aria-label*="Status"]//button[contains(@class, "k-grid-filter-menu")] | xpath://span[text()="Status"]/parent::*//button
${VMS_GRID_ROW}                 xpath://tr[@role="row"]
${VMS_GRID_CELL}                xpath://td[@role="gridcell"]

# Talent Name Locators
${VMS_TALENT_NAME_HEADER}       xpath://span[text()='Talent Name']
${VMS_FIRST_TALENT_LINK}        xpath:(//a[contains(@href, '/timecard/detail/')])[1]

# Talent Details Page Locators
${VMS_TAB_TIMECARD}            xpath=//li[@role='tab'][.//span[text()='TIMECARD']]
${VMS_TAB_RATE_CARD}           xpath=//li[@role='tab'][.//span[text()='RATE CARD']]
${VMS_TIME_IN_BTN}             (//label[text()='Time In']/../..//button)[1]
${VMS_TIME_OUT_BTN}            (//label[text()='Time Out']/../..//button)[1]
${VMS_BTN_ADD_DOCUMENT}        //span[text()='ADD DOCUMENT']
${VMS_BTN_SUBMIT_TIMECARD}     //span[text()='Submit Timecard']
${VMS_TALENT_NAME_XPATH}       //h1[@class='post-login-heading my-0 ms-0 me-2']
${VMS_TIMECARD_DATE_RANGE}     //span[@class='timecard-date']
${VMS_RATECARD_TOTAL_AMOUNT}    //p[contains(@class,'summary-total t')]
${VMS_TIMECARD_STATUS_DETAILS_PAGE}    //div[contains(@class,'d-flex a')]//span[contains(@class,'status-chips')]
${VMS_LINE_ITEMS_STATUSES_ELEMENTS}    //span[contains(@class,'status-chips-wrapper te')]
${error_msg_locator}                   //span[@class='notify-msg']
${DID_NOT_WORK_TOGGLE_XPATH}           //label[text()='Did Not Work']//span[@role='switch']

*** Keywords ***
Verify Timecard Management Page Title in Vms
    Verify Page Title    Timecard Management

Filter Timecard By Column by selecting dropdown
    [Arguments]    ${column_name}    ${column_value}

    Wait Until Page Ready

    # Stable dynamic locator for column menu
    ${column_menu}=    Set Variable
    ...    //th[.//span[normalize-space()='${column_name}']]//a[contains(@class,'k-grid-column-menu')]
    Scroll Element Into View     ${column_menu}
    Wait Till Element Visible    ${column_menu}
    Wait Till Element Enabled    ${column_menu}

    # Stale-safe click on column menu
    Wait Until Keyword Succeeds    5x    1s
    ...    Click Element    ${column_menu}

    Wait Till Element Visible    ${VMS_FILTER_POPOVER}

    # Enter filter value
    Wait Till Element Visible    ${VMS_VALUE_INPUT}
    Input Text                   ${VMS_VALUE_INPUT}    ${column_value}

    # Select first checkbox result
    Wait Till Element Visible    //span[text()='${column_value}']/..//input[@type='checkbox']
    Wait Till Element Enabled    //span[text()='${column_value}']/..//input[@type='checkbox']
    Click Element Safely         //span[text()='${column_value}']/..//input[@type='checkbox']

    Wait Until Page Ready

    # Optional Column label click (as per your logic)
    ${column_visible}=    Run Keyword And Return Status
    ...    Wait Till Element Visible    //label[text()='Column']    3s

    ${column_enabled}=    Run Keyword And Return Status
    ...    Wait Till Element Enabled    //label[text()='Column']    3s

    IF    ${column_visible} and ${column_enabled}
        Run Keyword And Ignore Error    Click Element Safely    //label[text()='Column']
    ELSE
        Log    Column label not interactable. Skipping click.
    END

    # Apply filter
    Wait Till Element Visible    ${VMS_APPLY_BUTTON}
    Wait Till Element Enabled    ${VMS_APPLY_BUTTON}
    Click Element Safely         ${VMS_APPLY_BUTTON}
    Wait Until Page Ready


Filter Timecard By Column by entering text
    [Arguments]    ${column_name}    ${column_value}
    Wait Until Page Ready
    # Stable dynamic locator for column menu
    ${column_menu}=    Set Variable
    ...    //th[.//span[normalize-space()='${column_name}']]//a[contains(@class,'k-grid-column-menu')]
    Sleep    3s
    Scroll Element Into View      ${column_menu}
    Wait Till Element Visible     ${column_menu}
    Wait Till Element Enabled     ${column_menu}

    # Stale-safe click (handles Kendo re-render)
    Wait Until Keyword Succeeds    5x    1s
    ...    Click Element    ${column_menu}
    # Wait for filter popover
    Wait Till Element Visible    ${VMS_FILTER_POPOVER}
    # Enter text value
    Wait Till Element Visible    ${VMS_TEXT_VALUE_INPUT}
    Input Text                   ${VMS_TEXT_VALUE_INPUT}    ${column_value}

    # --- Conditional handling for Column label (same logic) ---
    ${column_visible}=    Run Keyword And Return Status
    ...    Wait Till Element Visible    //label[text()='Column']    3s

    ${column_enabled}=    Run Keyword And Return Status
    ...    Wait Till Element Enabled    //label[text()='Column']    3s

    IF    ${column_visible} and ${column_enabled}
        Run Keyword And Ignore Error    Click Element Safely    //label[text()='Column']
        Log    Column label clicked
    ELSE
        Log    Column label not interactable. Skipping click.
    END

    # Apply filter
    Wait Till Element Visible    ${VMS_APPLY_BUTTON}
    Wait Till Element Enabled    ${VMS_APPLY_BUTTON}
    Sleep    3s
    Click Element Safely         ${VMS_APPLY_BUTTON}

    # Wait for grid refresh (important for Kendo)
    Wait Until Page Ready
    Sleep    3s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    //div[contains(@class,'k-grid-content')]//tr
    
    Scroll Element Into View        (//tr[@class='k-table-row']//th)[1]

Get First Talent Name And Click
    [Documentation]    Returns True if talent found and clicked, else False.
    Wait Until Page Ready
    Sleep    2s
    ${talent_present}=    Run Keyword And Return Status
    ...    Wait Till Element Visible    ${VMS_FIRST_TALENT_LINK}    5s
    IF    not ${talent_present}
        Log    No timecards present in Pending Submission status.
        RETURN    False
    END
    Scroll Element Into View       ${VMS_FIRST_TALENT_LINK}
    Sleep    2s
    ${talent_name}=    Get Text    ${VMS_FIRST_TALENT_LINK}
    Wait Till Element Enabled      ${VMS_FIRST_TALENT_LINK}
    Sleep    3s
    Log    Clicking talent: ${talent_name}
    Click Element    ${VMS_FIRST_TALENT_LINK}
    Wait Until Page Ready
    RETURN    True

Click Talent Name on Listing Page and navigate to Timecards details page
    Wait Until Page Ready
    Sleep    2s
    ${column_menu}=    Set Variable
    ...    //th[.//span[normalize-space()='Placement ID']]//a[contains(@class,'k-grid-column-menu')]
    Scroll Element Into View     ${column_menu}
    Wait Till Element Visible    ${column_menu}
    Wait Till Element Enabled    ${column_menu}
    Wait Till Element Visible             (//tr//td//a)[2]
    Scroll Element Into View              (//tr//td//a)[2]
    Sleep    5s
    Scroll Element Into View              //span[text()='Talent Name']
    ${talent_locator}=    Set Variable    (//tr//td//a)[2]
    ${talent_present}=    Run Keyword And Return Status
    ...    Wait Till Element Visible    ${talent_locator}    5s
    IF    not ${talent_present}
        Log    No talent found with Pending Approval status for: ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
        Fail    Talent '${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}' not found in Pending Approval list.
    END
    Scroll Element Into View    ${talent_locator}
    Wait Till Element Enabled   ${talent_locator}
#    Log    Clicking talent: ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Element    ${talent_locator}
    Wait Until Page Ready

Fill Timecard Hours
    [Arguments]    ${row_index}
    Wait Until Page Ready
    Wait Until Element Is Visible        (//input[contains(@name,'hours')])[${row_index}]
    Scroll Element Into View             (//input[contains(@name,'hours')])[${row_index}]
    ${hours_locator}=    Set Variable    (//input[contains(@name,'hours')])[${row_index}]
    Wait Until Page Ready
    Wait Until Element Is Visible    ${hours_locator}    20s
    Wait Until Element Is Enabled    ${hours_locator}
    Click Element        ${hours_locator}
    Clear Element Text   ${hours_locator}
    Wait Until Element Is Visible    ${hours_locator}
    Sleep    2s
    Input Text           ${hours_locator}    ${hours}
    Sleep    2s
    Press Keys           ${hours_locator}    TAB
    Wait Until Page Ready
    Log    Entered ${hours} hours in row ${row_index}

fill the timecard time in
    Wait Until Page Ready
    Scroll Element Into View            ${VMS_TIME_IN_BTN}
    Wait Until Page Ready
    Wait Till Element Visible           ${VMS_TIME_IN_BTN}
    Wait Till Element Enabled           ${VMS_TIME_IN_BTN}
    Click Element Safely                 ${VMS_TIME_IN_BTN}
    Scroll Element Into View             (//li[contains(text(),'${time_in}')])[1]
    Sleep    2s
    Wait Till Element Visible            (//li[contains(text(),'${time_in}')])[1]
    Wait Until Page Ready
    Wait Till Element Enabled            (//li[contains(text(),'${time_in}')])[1]
    Click Element Safely                 (//li[contains(text(),'${time_in}')])[1]
    Wait Until Page Ready
    Wait Till Element Visible               //button[text()='OK']
    Wait Till Element Enabled               //button[text()='OK']
    Click Element Safely                    //button[text()='OK']
    Wait Until Page Ready

fill the timeout
    Wait Until Page Ready
    Wait Till Element Visible                  ${VMS_TIME_OUT_BTN}   
    Wait Until Page Ready
    Wait Till Element Enabled                  ${VMS_TIME_OUT_BTN}
    Click Element Safely                       ${VMS_TIME_OUT_BTN}
    Wait Until Page Ready
    Scroll Element Into View                   (//li[contains(text(),'06')])[1]
    Sleep    2s
    Wait Till Element Visible                  (//li[contains(text(),'06')])[1]
    Wait Until Page Ready
    Wait Till Element Enabled                  (//li[contains(text(),'06')])[1]
    Click Element Safely                       (//li[contains(text(),'06')])[1]
    Wait Until Page Ready
    Wait Till Element Visible                  //button[text()='OK']     
    Wait Until Page Ready
    Wait Till Element Enabled                  //button[text()='OK']
    Click Element Safely                       //button[text()='OK']


#handle kendo load time
Wait For Kendo Loader To Disappear
    ${overlay}=    Set Variable    //div[contains(@class,'k-overlay')]
    Wait Until Keyword Succeeds    60s    2s    Overlay Should Be Gone

Overlay Should Be Gone
    ${count}=    Get Element Count    //div[contains(@class,'k-overlay') and not(contains(@style,'display: none'))]
    Should Be Equal As Integers    ${count}    0


open add document section
    Wait Until Page Ready
    Wait Till Element Visible                  ${VMS_BTN_ADD_DOCUMENT}
    Wait Until Page Ready
    Wait Till Element Enabled                  ${VMS_BTN_ADD_DOCUMENT}
    Click Element Safely                       ${VMS_BTN_ADD_DOCUMENT}
    Wait Until Page Ready

upload document and save
    ${UPLOAD_DIALOG}=    Set Variable
    ...    (//div[contains(@class,'k-window') and not(contains(@style,'display: none')) and .//span[normalize-space()='Upload / Edit']])[last()]
    Wait Until Page Ready
    Wait Until Page Contains Element    //div[@class='k-upload-button-wrap']    45s
    Sleep                               3s
    Wait Until Page Contains Element    //input[@type='file']    45s
    Sleep                               3s
    # Upload the file
    Choose File                        //input[@type='file']        ${file_path}
    Sleep                              3s
    #save
    Wait Until Page Contains Element    //button[@type='submit' and .//span[text()='Save']]
    Wait Till Element Enabled           //button[@type='submit' and .//span[text()='Save']]
    Click Element                       //button[@type='submit' and .//span[text()='Save']]
    Wait Until Page Ready
    # Wait until this specific dialog disappears
    Wait Until Page Does Not Contain Element    ${UPLOAD_DIALOG}    90s
    Sleep                               5s




submit timecard
    Wait Until Page Ready
    Wait Till Element Visible                  ${VMS_BTN_SUBMIT_TIMECARD}
    Wait Until Page Ready
    Wait Till Element Enabled                  ${VMS_BTN_SUBMIT_TIMECARD}
    Click Element Safely                       ${VMS_BTN_SUBMIT_TIMECARD}
    Wait Until Page Ready
    

## --- Data Capture Keywords ---
Capture Talent Name while submitting Timecard
    [Documentation]    Captures Talent and Vendor names and sets them as suite variables.
    Wait Till Element Visible        ${VMS_TALENT_NAME_XPATH}
    Wait Until Page Ready
    ${talent}=    Get Text           ${VMS_TALENT_NAME_XPATH}
    Set Suite Variable               ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}    ${talent}
    Wait Until Page Ready
    Log    Captured Talent While Submitting Timecard: ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}

Capture Timecard Work Week Date Details while submitting Timecard
    [Documentation]    Captures the date range from the Timecard tab and sets it as a suite variable.
    Wait Till Element Visible    ${VMS_TAB_TIMECARD}    
    Wait Until Page Ready
    Wait Till Element Visible    ${VMS_TAB_TIMECARD}
    Scroll Element Into View                ${VMS_TAB_TIMECARD}
    Wait Till Element Enabled        ${VMS_TAB_TIMECARD}
    Click Element Safely                    ${VMS_TAB_TIMECARD}
    Sleep    2s
    Wait Till Element Visible       ${VMS_TIMECARD_DATE_RANGE}   
    ${date}=    Get Text            ${VMS_TIMECARD_DATE_RANGE}
    Set Suite Variable              ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    ${date}
    Log    Captured Timecard Date While Submitting Timecard: ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}

Capture Rate card Details Details while submitted Timecard
    [Documentation]    Navigates to Ratecard tab, captures Hours and Total Amount, and sets suite variables.
    Wait Till Element Visible               ${VMS_TAB_RATE_CARD}
    Wait Until Page Ready
    Scroll Element Into View                ${VMS_TAB_RATE_CARD}
    Wait Till Element Visible               ${VMS_TAB_RATE_CARD}
    Wait Till Element Enabled                   ${VMS_TAB_RATE_CARD}
    Click Element Safely                    ${VMS_TAB_RATE_CARD}
    Sleep    2s
    Scroll Element Into View                ${VMS_RATECARD_TOTAL_AMOUNT}
    Wait Till Element Visible               ${VMS_RATECARD_TOTAL_AMOUNT}
    # RateCard content might take even longer to load
    ${amount}=    Get Text                  ${VMS_RATECARD_TOTAL_AMOUNT}
    Set Suite Variable    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${amount}
    Log    Captured Amount While Submitting Timecard: ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}

#Capture Talent Name and validate after submitting Timecard
#    [Documentation]    Captures Talent and Vendor names and sets them as suite variables.
#    Wait Till Element Visible        ${VMS_TALENT_NAME_XPATH}
#    Wait Until Page Ready
#    ${talent}=    Get Text           ${VMS_TALENT_NAME_XPATH}
#    Set Suite Variable               ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}    ${talent}
#    Wait Until Page Ready
#    Log    Captured Talent After Submitting Timecard: ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}
#    Log    Captured Talent Before Submitting Timecard:${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
#    Should Be Equal    ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}

Capture Talent Name and validate after submitting Timecard
    Wait Till Element Visible        ${VMS_TALENT_NAME_XPATH}
    Wait Until Page Ready

    ${talent}=    Get Text    ${VMS_TALENT_NAME_XPATH}
    Set Suite Variable    ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}    ${talent}

    Log    After: ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}
    Log    Before: ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}

    # Normalize values
    ${after}=     Strip String    ${TIMECARD_TALENT_NAME_AFTER_SUBMISSION}
    ${before}=    Strip String    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}

    ${after}=     Convert To Lower Case        ${after}
    ${before}=    Convert To Lower Case        ${before}

    Should Be Equal    ${after}    ${before}
    
    
Capture Timecard Work Week Date Details and validate after submitting Timecard
    [Documentation]    Captures the date range from the Timecard tab and sets it as a suite variable.
    Wait Till Element Visible        ${VMS_TAB_TIMECARD}    
    Wait Until Page Ready
    Scroll Element Into View         ${VMS_TAB_TIMECARD}
    Sleep    2s
    Wait Till Element Visible        ${VMS_TAB_TIMECARD}
    Wait Till Element Enabled        ${VMS_TAB_TIMECARD}
    Scroll Element Into View         ${VMS_TAB_TIMECARD}
    Sleep    2s
    Scroll Element Into View         ${VMS_TAB_TIMECARD}
    Sleep    2s
    Click Element Safely             ${VMS_TAB_TIMECARD}
    Sleep    2s
    Wait Till Element Visible       ${VMS_TIMECARD_DATE_RANGE}   
    ${date}=    Get Text            ${VMS_TIMECARD_DATE_RANGE}
    Set Suite Variable              ${TIMECARD_DATE_RANGE_AFTER_SUBMISSION}    ${date}
    Log    Captured Timecard Date After Submitting Timecard: ${TIMECARD_DATE_RANGE_AFTER_SUBMISSION}
    Log    Captured Timecard Date Before Submitting Timecard: ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}
    Should Be Equal    ${TIMECARD_DATE_RANGE_AFTER_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}

Capture Rate card Details Details and validate after submitting Timecard
    [Documentation]    Navigates to Ratecard tab, captures Hours and Total Amount, and sets suite variables.
    Wait Till Element Visible               ${VMS_TAB_RATE_CARD}
    Wait Until Page Ready
    Scroll Element Into View                ${VMS_TAB_RATE_CARD}
    Wait Till Element Visible               ${VMS_TAB_RATE_CARD}
    Wait Till Element Enabled                   ${VMS_TAB_RATE_CARD}
    Click Element Safely                    ${VMS_TAB_RATE_CARD}
    Sleep    2s
    Scroll Element Into View                ${VMS_RATECARD_TOTAL_AMOUNT}
    Wait Till Element Visible               ${VMS_RATECARD_TOTAL_AMOUNT}
    # RateCard content might take even longer to load
    ${amount}=    Get Text                  ${VMS_RATECARD_TOTAL_AMOUNT}
    Set Suite Variable    ${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}    ${amount}
    Log    Captured Amount Before Submitting Timecard: ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Log    Captured Amount After Submitting Timecard:${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}
    Should Be Equal    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}


Validate Timecard Status
    [Arguments]    ${expected_status}
    Wait Until Page Ready
    Scroll Element Into View     ${VMS_TIMECARD_STATUS_DETAILS_PAGE}
    Wait Till Element Visible    ${VMS_TIMECARD_STATUS_DETAILS_PAGE}
    Wait Till Element Enabled    ${VMS_TIMECARD_STATUS_DETAILS_PAGE}

    ${actual_timecard_status}=    Get Text    ${VMS_TIMECARD_STATUS_DETAILS_PAGE}
    ${actual_timecard_status}=    Strip String    ${actual_timecard_status}
    ${expected_status}=           Strip String    ${expected_status}

    # Convert both to upper case for case-insensitive comparison
    ${actual_upper}=    Convert To Upper Case    ${actual_timecard_status}
    ${expected_upper}=  Convert To Upper Case    ${expected_status}

    Set Suite Variable    ${ACTUAL_TIMECARD_STATUS}    ${actual_timecard_status}

    Log    Actual Timecard Status: ${actual_timecard_status}
    Log    Expected Timecard Status: ${expected_status}

    Should Be Equal    ${actual_upper}    ${expected_upper}

Validate Timecards Line Items Statuses
    [Arguments]    ${expected_line_item_status}

    Wait Until Page Ready
    Wait Till Element Visible    ${VMS_LINE_ITEMS_STATUSES_ELEMENTS}

    # Normalize expected value once
    ${expected_line_item_status}=    Strip String    ${expected_line_item_status}
    ${expected_upper}=               Convert To Upper Case    ${expected_line_item_status}

    # Get all matching elements
    ${elements}=    Get WebElements    ${VMS_LINE_ITEMS_STATUSES_ELEMENTS}
    ${count}=       Get Length    ${elements}
    Log    Found ${count} line item status elements.

    FOR    ${element}    IN    @{elements}
        Scroll Element Into View    ${element}
        Wait Till Element Visible   ${element}

        ${status}=    Get Text    ${element}
        ${status}=    Strip String    ${status}
        ${status_upper}=    Convert To Upper Case    ${status}

        Log    Line item status: ${status}

        Should Be Equal    ${status_upper}    ${expected_upper}
    END


Capture All Cells From First Row
    [Documentation]    Captures all column values from first row by handling horizontal scroll (Kendo column virtualization)
    Scroll Element Into View         (//tr[@class='k-table-row']//th)[1]
    Wait Until Page Ready
    Wait Until Element Is Visible    //tbody/tr[1]    20s

    ${grid_content}=    Set Variable    //div[contains(@class,'k-grid-content')]
    ${all_values}=      Create List

    FOR    ${i}    IN RANGE    0    6
        ${cells}=    Get WebElements    //tbody/tr[1]/td

        FOR    ${cell}    IN    @{cells}
            ${text}=    Get Text    ${cell}
            ${text}=    Strip String    ${text}

            IF    '${text}' != '' and '${text}' not in ${all_values}
                ${upper}=    Convert To Upper Case        ${text}
                Append To List    ${all_values}    ${upper}
            END
        END

        # Scroll horizontally to load next columns
        Execute JavaScript
        ...    var grid=document.evaluate("${grid_content}",document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue;
        ...    if(grid){ grid.scrollLeft = grid.scrollLeft + 500; }

        Sleep    1s
    END

    Log    Captured Full Row Values: ${all_values}
    RETURN    ${all_values}


Validate Timecard Row Data
    [Arguments]
    ...    ${expected_talent}
    ...    ${expected_amount}
    ...    ${expected_date}
    ...    ${expected_status}

    ${actual_list}=    Capture All Cells From First Row

    ${talent}=    Convert To Upper Case    ${expected_talent}
    ${status}=    Convert To Upper Case    ${expected_status}

    # Normalize expected amount
    ${expected_amount}=    Replace String    ${expected_amount}    $    ${EMPTY}
    ${expected_amount}=    Replace String    ${expected_amount}    ,    ${EMPTY}
    ${expected_amount}=    Strip String      ${expected_amount}

    # Normalize UI values
    ${normalized_list}=    Evaluate    [str(x).replace('$','').replace(',','').strip() for x in $actual_list]

    # Validations
    List Should Contain Value    ${actual_list}        ${talent}
    List Should Contain Value    ${normalized_list}    ${expected_amount}
    List Should Contain Value    ${actual_list}        ${expected_date}
    List Should Contain Value    ${actual_list}        ${status}

Validate Error Message for Timecards on VMS Page
    Wait Until Page Ready
    Wait Till Element Visible    ${error_msg_locator}

    ${actual_text}=    Get Text    ${error_msg_locator}
    ${actual_text}=    Strip String    ${actual_text}
    ${actual_text}=    Replace String    ${actual_text}    \n    ${SPACE}
    ${actual_text}=    Convert To Upper Case    ${actual_text}

    Log    Actual error message: ${actual_text}

    # Expected messages
    @{expected_messages}=    Create List
    ...    PLEASE COMPLETE ALL REQUIRED FIELDS PRIOR TO SUBMITTING.
    ...    MINIMUM 1 TIMECARD ENTRY IS REQUIRED TO SUBMIT THE TIMECARD.
    ...    PLEASE ATTACH REQUIRED SUPPORTING DOCUMENTS PRIOR TO SUBMITTING.
    ...    PLEASE ATTACH REQUIRED SUPPORTING DOCUMENTS PRIOR TO SUBMITTING

    ${match_found}=    Set Variable    False

    FOR    ${msg}    IN    @{expected_messages}
        ${msg_upper}=    Convert To Upper Case    ${msg}
        ${status}=    Run Keyword And Return Status
        ...    Should Contain    ${actual_text}    ${msg_upper}
        IF    ${status}
            Log    Matched expected message: ${msg}
            ${match_found}=    Set Variable    True
            Exit For Loop
        END
    END

    IF    not ${match_found}
        Fail    None of the expected validation messages matched. Actual message: ${actual_text}
    END

enable toggle Did Not Work and click on continue
    Wait Until Page Ready
    Wait Till Element Visible    ${DID_NOT_WORK_TOGGLE_XPATH}
    Wait Till Element Enabled    ${DID_NOT_WORK_TOGGLE_XPATH}
    Scroll Element Into View     ${DID_NOT_WORK_TOGGLE_XPATH}
    Sleep    2s
    Click Element Safely         ${DID_NOT_WORK_TOGGLE_XPATH}
    Wait Until Page Ready
    Wait Till Element Visible    //button[normalize-space()='Continue']
    Wait Till Element Enabled    //button[normalize-space()='Continue']
    Sleep    2s
    Click Element Safely         //button[normalize-space()='Continue']
    Wait Until Page Ready

Validate Button State By Text
    [Arguments]    ${button_text}    ${expected_state}
    # expected_state: enabled / disabled

    ${locator}=    Set Variable    //button[.//span[normalize-space()='${button_text}']]

    Wait Until Page Ready
    Wait Until Element Is Visible    ${locator}    20s

    ${class}=            Get Element Attribute    ${locator}    class
    ${aria_disabled}=    Get Element Attribute    ${locator}    aria-disabled
    ${disabled_attr}=    Get Element Attribute    ${locator}    disabled

    # Check conditions separately (safer than Evaluate with complex strings)
    ${class_disabled}=       Run Keyword And Return Status    Should Contain    ${class}    k-disabled
    ${aria_disabled_flag}=   Set Variable If    '${aria_disabled}'=='true'    True    False
    ${attr_disabled_flag}=   Set Variable If    '${disabled_attr}'!='None'    True    False

    ${is_disabled}=    Evaluate    ${class_disabled} or ${aria_disabled_flag} or ${attr_disabled_flag}

    IF    '${expected_state}'=='disabled'
        Should Be True    ${is_disabled}    Button '${button_text}' is NOT disabled
        Log    Button '${button_text}' is disabled as expected
    ELSE IF    '${expected_state}'=='enabled'
        Should Be True    not ${is_disabled}    Button '${button_text}' is disabled but expected enabled
        Log    Button '${button_text}' is enabled as expected
    ELSE
        Fail    Invalid expected_state: ${expected_state}. Use 'enabled' or 'disabled'
    END

    
    



