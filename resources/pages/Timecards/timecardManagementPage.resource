*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Library    ../../../libs/RuntimeData.py
Library    String

*** Variables ***
# Main Tabs
${XPATH_TAB_ALL_TIMECARDS}                  xpath=//li[@role='tab'][.//span[text()='All timecards']]
${XPATH_TAB_PENDING_APPROVAL}               xpath=//li[@role='tab'][.//span[text()='Pending approval']]

# Quick Filter Cards (Summary Statistics)
${XPATH_CARD_DISPUTE_REJECTED}              xpath=//div[@role='button'][.//span[text()='Dispute Rejected']]
${XPATH_CARD_DISPUTED}                      xpath=//div[@role='button'][.//span[text()='Disputed']]
${XPATH_CARD_REJECTED_INVOICE}              xpath=//div[@role='button'][.//span[text()='Rejected Invoice']]

# View Toggle Buttons (Summary / Detailed)
${XPATH_VIEW_SUMMARY}                       xpath=//li[contains(text(),'Summary View')]
${XPATH_VIEW_DETAILED}                      xpath=//li[contains(text(),'Detailed View')]

# Primary Action Buttons
${XPATH_BTN_ADD_NEW_EXPENSE}                xpath=//button[.//span[contains(text(),'ADD NEW EXPENSE')]]
${XPATH_BTN_VIEWS_DROPDOWN}                 xpath=//button[@aria-label='views']
${XPATH_BTN_SAVE}                           xpath=//button[@aria-label='save']
${XPATH_BTN_EXPORT}                         xpath=//button[@aria-label='export']
${XPATH_BTN_COLUMN_CHOOSER}                 xpath=//button[contains(@class,'custom-flat-btn')][.//span[contains(@class,'column')]]
${XPATH_BTN_BULK_APPROVE}                   xpath=//button[.//span[contains(text(),'BULK APPROVE')]]

#views dropdown values
${XPATH_BTN_VIEWS_DROPDOWN_VALUES}         xpath=//li[contains(@class,'k-item k-menu-item')]

# Search Input
${XPATH_INPUT_SEARCH}                       xpath=//input[contains(@class,'k-input') and contains(@class,'k-input-md')]

# Filters
${XPATH_BTN_ADD_FILTER}                     xpath=//button[contains(text(),'Add Filter')]
${XPATH_TOGGLE_SHOW_INVOICED}               xpath=//span[@id='Show Invoice'][@role='swiXPATHh']
${XPATH_LABEL_SHOW_INVOICED}                xpath=//label[contains(@class,'swiXPATHh-label')][contains(text(),'Show Invoiced')]

# Table Headers (Column Titles)
${XPATH_HEADER_LOCATION}                    xpath=//th[@role='columnheader']//span[text()='Location']
${XPATH_HEADER_LOCATION_ID}                 xpath=//th[@role='columnheader']//span[text()='Location ID']
${XPATH_HEADER_DEPARTMENT}                  xpath=//th[@role='columnheader']//span[text()='Department']
${XPATH_HEADER_COST_CENTER}                 xpath=//th[@role='columnheader']//span[text()='Cost Center']
${XPATH_HEADER_SKILL}                       xpath=//th[@role='columnheader']//span[text()='Skill']
${XPATH_HEADER_PLACEMENT_ID}                xpath=//th[@role='columnheader']//span[text()='Placement ID']
${XPATH_HEADER_TALENT_NAME}                 xpath=//th[@role='columnheader']//span[text()='Talent Name']
${XPATH_HEADER_VENDOR}                      xpath=//th[@role='columnheader']//span[text()='Vendor']
${XPATH_HEADER_TIMECARD_PERIOD}             xpath=//th[@role='columnheader']//span[text()='Timecard Period']
${XPATH_HEADER_STATUS}                      xpath=//th[@role='columnheader']//span[text()='Status']
${XPATH_HEADER_HOURS}                       xpath=//th[@role='columnheader']//span[text()='Hours']
${XPATH_HEADER_REGULAR_RATE}                xpath=//th[@role='columnheader']//span[text()='Regular Rate']
${XPATH_HEADER_TIMECARD_AMOUNT}             xpath=//th[@role='columnheader']//span[text()='Timecard Amount']

# Table Column Menu Buttons (for column filtering/sorting)
${XPATH_COLMENU_LOCATION}                   xpath=//a[@aria-label='Location Column menu']
${XPATH_COLMENU_LOCATION_ID}                xpath=//a[@aria-label='Location ID Column menu']
${XPATH_COLMENU_DEPARTMENT}                 xpath=//a[@aria-label='Department Column menu']
${XPATH_COLMENU_COST_CENTER}                xpath=//a[@aria-label='Cost Center Column menu']
${XPATH_COLMENU_SKILL}                      xpath=//a[@aria-label='Skill Column menu']
${XPATH_COLMENU_PLACEMENT_ID}               xpath=//a[@aria-label='Placement ID Column menu']
${file_path}                                ${CURDIR}${/}resume.jpg
${document_name}                            resume.jpg
${HCS_FILTER_POPOVER}           css:.MuiPopover-paper
${HCS_FILTER_FORM}              xpath://form[contains(@action, "#")]
${HCS_COLUMN_DROPDOWN}          xpath://label[text()="Column"]/preceding-sibling::span//input[@role="combobox"]
${HCS_OPERATOR_DROPDOWN}        xpath://label[text()="Operator"]/preceding-sibling::span//input[@role="combobox"]
${HCS_VALUE_INPUT}              xpath://label[text()="Value"]/preceding-sibling::div//input[@role="combobox"]
${HCS_TEXT_VALUE_INPUT}         //input[contains(@class,'k-input') and @name='value']
${HCS_APPLY_BUTTON}             xpath://button[contains(@class, "pr-btn-primary")]//span[text()="Apply"]
${HCS_LINE_ITEMS_STATUSES_ELEMENTS}    //span[contains(@class,'status-chips-wrapper tal')]

# Pagination Controls
${XPATH_PAGER_NEXT}                         xpath=//button[@title='Go to the next page']
${XPATH_PAGER_LAST}                         xpath=//button[@title='Go to the last page']
${XPATH_PAGER_PREVIOUS}                     xpath=//button[@title='Go to the previous page']
${XPATH_PAGER_FIRST}                        xpath=//button[@title='Go to the first page']
${XPATH_PAGER_PAGE_SIZE}                    xpath=//span[@role='combobox'][@aria-label='Page size']

# Pending Approval Tab - Specific Elements
${XPATH_PENDING_SELECT_ALL_CHECKBOX}        xpath=//th[@role='columnheader']//input[@type='checkbox']
${XPATH_PENDING_ROW_CHECKBOX}               xpath=//td[@role='gridcell']//input[@type='checkbox']


# Split Button Menu Arrows (next to Views/Save/Export)
${XPATH_SPLIT_BTN_VIEWS_ARROW}              xpath=//button[@aria-label='views']/following-sibling::button[@aria-label='menu toggling button']
${XPATH_SPLIT_BTN_SAVE_ARROW}              xpath=//button[@aria-label='save']/following-sibling::button[@aria-label='menu toggling button']
${XPATH_SPLIT_BTN_EXPORT_ARROW}            xpath=//button[@aria-label='export']/following-sibling::button[@aria-label='menu toggling button']

# Header / Navigation Elements (shared across pages)
${XPATH_HEADER_NOTIFICATIONS}               xpath=//button[contains(@class,'notification-icon-wrap')]
${XPATH_HEADER_USER_PROFILE}                xpath=//button[contains(@class,'user-icon')]

# Data Row Elements (Dynamic - use with index or parameterization)
${XPATH_TABLE_FIRST_ROW}                    xpath=(//tr[@role='row' and @aria-rowindex])[1]
${XPATH_TABLE_ROW_PLACEMENT_LINK}           xpath=//td[@role='gridcell']//a[contains(@href,'/talents/')]
${XPATH_TABLE_ROW_TALENT_LINK}              xpath=//td[@role='gridcell']//a[contains(@href,'/timecard/detail/')]
${XPATH_TABLE_ROW_FIRST_TALENT_LINK}        xpath=(//td[@role='gridcell']//a[contains(@href,'/timecard/detail/')])[1]

# rateCard Page Locators
${HCS_TAB_RATE_CARD}            //li[@role='tab'][.//span[text()='RATE CARD']]
${HCS_RATECARD_TOTAL_AMOUNT}    //th[normalize-space()='Amount']/ancestor::table//tbody/tr/td[last()]
${HCS_BTN_SUBMIT_TIMECARD}      //button[.//span[normalize-space()='APPROVE WITH EDITS']]

${reject_request_reason_dropdown_arrow}                //input[@aria-controls='rejectReasonlist']/following-sibling::button
${first_reject_request_reason}                         //ul[@id='rejectReasonlist']/li[1]
${reject_request_reason_text}                          //textarea[@name='reason']
${reject_timecard_on_request_reason_window}            //button[@type='submit' and .//span[normalize-space()='Reject Timecard']]

#rescind xpaths
${MORE_BUTTON}         //button[.//span[contains(@class,'k-i-more')]]
${RESCIND_APPROVAL}    //span[normalize-space()='Rescind Approval' and contains(@class,'k-menu-link')]
${CONTINUE_BUTTON}     //button[@type='submit']//span[normalize-space()='Continue']

*** Keywords ***
Verify Timecard Management Page Title
    Wait Until Page Ready
    Verify Page Title    Timecard Management
    

#navigate to default view
#    Wait Until Page Ready
#    From Dropdown Verify or Select an Option    ${XPATH_BTN_VIEWS_DROPDOWN}    ${XPATH_BTN_VIEWS_DROPDOWN_VALUES}    Default    select
#    Wait Until Page Ready


navigate to default view
    Wait Until Page Ready
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${XPATH_BTN_VIEWS_DROPDOWN}
    ${is_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${XPATH_BTN_VIEWS_DROPDOWN}
    Run Keyword If    ${is_visible} and ${is_enabled}
    ...    From Dropdown Verify or Select an Option
    ...    ${XPATH_BTN_VIEWS_DROPDOWN}
    ...    ${XPATH_BTN_VIEWS_DROPDOWN_VALUES}
    ...    Default
    ...    select
    Wait Until Page Ready
    

apply quick filter on timecards listing page
    [Arguments]    ${quick_filter_name}
    Wait Until Page Ready
    Wait Till Element Visible    //div[@role='button'][.//span[text()='${quick_filter_name}']]
    Wait Until Page Ready
    Click Element Safely         //div[@role='button'][.//span[text()='${quick_filter_name}']]
    Wait Until Page Ready
    
open first timecard details from listing and store talent name
    Wait Until Page Ready
    Wait Till Element Visible    ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    ${first_timecard_talent_name}=    Get Text    ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    Set Suite Variable    ${first_timecard_talent_name}    ${first_timecard_talent_name}
    Log                   First Talent Stored: ${first_timecard_talent_name}
    Wait Until Page Ready
    Scroll Element Into View     ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    Click Element Safely         ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
#    Wait Until Page Ready

Filter Timecard By Column by selecting dropdown on HCS
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

    Wait Till Element Visible    ${HCS_FILTER_POPOVER}

    # Enter filter value
    Wait Till Element Visible    ${HCS_VALUE_INPUT}
    Input Text                   ${HCS_VALUE_INPUT}    ${column_value}

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
    Wait Till Element Visible    ${HCS_APPLY_BUTTON}
    Wait Till Element Enabled    ${HCS_APPLY_BUTTON}
    Click Element Safely         ${HCS_APPLY_BUTTON}
    Wait Until Page Ready

Filter Timecard By Column by entering text on HCS
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
    Wait Till Element Visible    ${HCS_FILTER_POPOVER}
    # Enter text value
    Wait Till Element Visible    ${HCS_TEXT_VALUE_INPUT}
    Input Text                   ${HCS_TEXT_VALUE_INPUT}    ${column_value}

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
    Wait Till Element Visible    ${HCS_APPLY_BUTTON}
    Wait Till Element Enabled    ${HCS_APPLY_BUTTON}
    Sleep    3s
    Click Element Safely         ${HCS_APPLY_BUTTON}

    # Wait for grid refresh (important for Kendo)
    Wait Until Page Ready
    Sleep    3s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    //div[contains(@class,'k-grid-content')]//tr

    Scroll Element Into View        (//tr[@class='k-table-row']//th)[1]

Validate Timecards Line Items Statuses on HCS
    [Arguments]    ${expected_line_item_status}

    Wait Until Page Ready
    Wait Till Element Visible    ${HCS_LINE_ITEMS_STATUSES_ELEMENTS}

    # Normalize expected value once
    ${expected_line_item_status}=    Strip String    ${expected_line_item_status}
    ${expected_upper}=               Convert To Upper Case    ${expected_line_item_status}

    # Get all matching elements
    ${elements}=    Get WebElements    ${HCS_LINE_ITEMS_STATUSES_ELEMENTS}
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

Validate Timecards Disputed Line Items Statuses on HCS
    [Arguments]    ${expected_line_item_status}    ${expected_count}
    Wait Until Page Ready
    Wait Till Element Visible    ${HCS_LINE_ITEMS_STATUSES_ELEMENTS}
    # Normalize expected value
    ${expected_line_item_status}=    Strip String    ${expected_line_item_status}
    ${expected_upper}=               Convert To Upper Case    ${expected_line_item_status}
    # Get all matching elements
    ${elements}=        Get WebElements    ${HCS_LINE_ITEMS_STATUSES_ELEMENTS}
    ${total_count}=     Get Length    ${elements}
    Log    Found ${total_count} line item status elements. Validating first ${expected_count}.
    # Safety check
    Should Be True    ${total_count} >= ${expected_count}    Not enough line item statuses present.
    ${index}=    Set Variable    0
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    ${index} >= ${expected_count}
        Scroll Element Into View    ${element}
        Wait Till Element Visible   ${element}
        ${status}=          Get Text    ${element}
        ${status}=          Strip String    ${status}
        ${status_upper}=    Convert To Upper Case    ${status}
        ${display_index}=   Evaluate    ${index} + 1
        Log    Line item ${display_index} status: ${status}
        Should Be Equal    ${status_upper}    ${expected_upper}
        ${index}=    Evaluate    ${index} + 1

    END

upload document and save on HCS
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

Capture Rate card Details Details while submitted Timecard from HCS
    [Documentation]    Navigates to Ratecard tab, captures Hours and Total Amount, and sets suite variables.

    Wait Until Page Ready
    # Retry scrolling to Schedule & Rate section
    Wait Until Keyword Succeeds    5x    2s
    ...    Scroll Element Into View    //h3[normalize-space()='Schedule & Rate']
    Wait Till Element Visible          //h3[normalize-space()='Schedule & Rate']
    # Try clicking heading (safe attempt since it is just text)
    Run Keyword And Ignore Error    Click Element    //h3[normalize-space()='Schedule & Rate']
    Sleep    2s
    Wait Till Element Visible               ${HCS_TAB_RATE_CARD}
    Wait Until Page Ready
    Scroll Element Into View                ${HCS_TAB_RATE_CARD}
    Wait Till Element Visible               ${HCS_TAB_RATE_CARD}
    Wait Till Element Enabled               ${HCS_TAB_RATE_CARD}
    Click Element Safely                    ${HCS_TAB_RATE_CARD}
    Sleep    2s
    Scroll Element Into View                ${HCS_RATECARD_TOTAL_AMOUNT}
    Wait Till Element Visible               ${HCS_RATECARD_TOTAL_AMOUNT}
    # RateCard content might take even longer to load
    ${amount}=    Get Text                  ${HCS_RATECARD_TOTAL_AMOUNT}
    Set Suite Variable    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${amount}
    Log    Captured Amount While Submitting Timecard: ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}

submit timecard from HCS
    Wait Until Page Ready
    Sleep    2s
    Wait Till Element Visible          ${HCS_BTN_SUBMIT_TIMECARD}
    Wait Till Element Enabled          ${HCS_BTN_SUBMIT_TIMECARD}
    # Retry clicking until successful
    Wait Until Keyword Succeeds    30s    3s
    ...    Click Element Safely    ${HCS_BTN_SUBMIT_TIMECARD}
    Sleep    2s
    # Wait until button disappears after submission
    Wait Until Keyword Succeeds    30s    3s
    ...    Page Should Not Contain Element    ${HCS_BTN_SUBMIT_TIMECARD}
    Wait Until Page Ready

Capture Rate card Details Details and validate after submitting Timecard in HCS
    [Documentation]    Navigate to Ratecard tab, capture amount and validate.

    Wait Until Page Ready

    # Retry scrolling to Schedule & Rate section
    Wait Until Keyword Succeeds    5x    2s
    ...    Scroll Element Into View    //h3[normalize-space()='Schedule & Rate']

    Wait Till Element Visible    //h3[normalize-space()='Schedule & Rate']

    # Try clicking heading (safe attempt since it is just text)
    Run Keyword And Ignore Error    Click Element    //h3[normalize-space()='Schedule & Rate']

    Sleep    2s

    # Scroll to Rate Card tab
    Wait Until Keyword Succeeds    5x    2s
    ...    Scroll Element Into View    ${HCS_TAB_RATE_CARD}

    Wait Till Element Visible    ${HCS_TAB_RATE_CARD}
    Wait Till Element Enabled    ${HCS_TAB_RATE_CARD}

    # Retry clicking Rate Card tab until success
    Wait Until Keyword Succeeds    5x    2s
    ...    Click Element Safely    ${HCS_TAB_RATE_CARD}

    Wait Until Page Ready
    Sleep    2s

    # Scroll to total amount
    Wait Until Keyword Succeeds    5x    2s
    ...    Scroll Element Into View    ${HCS_RATECARD_TOTAL_AMOUNT}

    Wait Till Element Visible    ${HCS_RATECARD_TOTAL_AMOUNT}

    ${amount}=    Get Text    ${HCS_RATECARD_TOTAL_AMOUNT}

    Set Suite Variable    ${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}    ${amount}

    Log    Captured Amount Before Submitting Timecard: ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Log    Captured Amount After Submitting Timecard: ${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}

    Should Be Equal
    ...    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    ...    ${RATECARD_TOTAL_AMOUNT_AFTER_SUBMISSION}


Approve or Reject timecard from HCS
    [Arguments]    ${action}
    Wait Until Page Ready
    ${button_xpath}=    Set Variable
    ...    //button[.//span[normalize-space()='${action}']]
    # Retry clicking until successful
    Wait Until Keyword Succeeds    30s    3s
    ...    Click Timecard Action Button    ${button_xpath}
    # Wait until button disappears (action completed)
    Sleep    2s
    Wait Until Page Ready

Click Timecard Action Button
    [Arguments]    ${button_xpath}

    Wait Till Element Visible    ${button_xpath}
    Scroll Element Into View     ${button_xpath}
    Wait Till Element Enabled    ${button_xpath}
    Click Element Safely         ${button_xpath}

Select reject request reason from dropdown enter text and click on reject timecard
    Wait Until Page Ready

    Wait Till Element Visible         ${reject_request_reason_dropdown_arrow}
    Scroll Element Into View          ${reject_request_reason_dropdown_arrow}
    Wait Till Element Enabled         ${reject_request_reason_dropdown_arrow}
    Click Element Safely              ${reject_request_reason_dropdown_arrow}

    Wait Till Element Visible         ${first_reject_request_reason}
    Scroll Element Into View          ${first_reject_request_reason}
    Wait Till Element Enabled         ${first_reject_request_reason}
    Click Element Safely              ${first_reject_request_reason}

    Wait Till Element Visible         ${reject_request_reason_text}
    Scroll Element Into View          ${reject_request_reason_text}
    Wait Till Element Enabled         ${reject_request_reason_text}
    Input Text                        ${reject_request_reason_text}    Document is not valid

    Wait Till Element Visible         ${reject_timecard_on_request_reason_window}
    Scroll Element Into View          ${reject_timecard_on_request_reason_window}
    Wait Till Element Enabled         ${reject_timecard_on_request_reason_window}

    # Retry clicking until success
    Wait Until Keyword Succeeds       20s    2s    Click Element Safely    ${reject_timecard_on_request_reason_window}

    # Wait until reject window/button disappears
    Wait Until Page Does Not Contain Element    ${reject_timecard_on_request_reason_window}    timeout=60s
    Sleep    2s
    Wait Until Page Ready


Click Rescind Approval From Menu
    Sleep    2s
    Wait Until Page Ready
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${MORE_BUTTON}
    Wait Until Page Ready
    Wait Till Element Visible  ${RESCIND_APPROVAL}
    Wait Until Page Ready
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${RESCIND_APPROVAL}
    Wait Until Page Ready
    Wait Until Element Is Not Visible     ${RESCIND_APPROVAL}     30s

Validate Rescind Approval Not Available
    Wait Until Page Ready
    ${more_present}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${MORE_BUTTON}
    IF    ${more_present}
        Fail    RESCIND button is present. Negative scenario failed.
    ELSE
        Log    RESCIND button is not present as expected. Rescind Approval cannot be performed.
    END

Click Continue When Clickable
    Wait Until Page Ready
    Wait Till Element Visible     ${CONTINUE_BUTTON}
    Wait Till Element Enabled     ${CONTINUE_BUTTON}
    Sleep    2s
    Wait Until Keyword Succeeds     15s     1s     Click Element     ${CONTINUE_BUTTON}
    Wait Until Page Ready
    Wait Until Element Is Not Visible     ${CONTINUE_BUTTON}     30s
    Wait Until Page Ready
    

     