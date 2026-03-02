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



*** Keywords ***
Verify Timecard Management Page Title
    Wait For Page Ready
    Verify Page Title    Timecard Management
    

navigate to default view
    Wait For Page Ready
    From Dropdown Verify or Select an Option    ${XPATH_BTN_VIEWS_DROPDOWN}    ${XPATH_BTN_VIEWS_DROPDOWN_VALUES}    Default    select 
    Wait For Page Ready
    

apply quick filter on timecards listing page
    [Arguments]    ${quick_filter_name}
    Wait For Page Ready
    Wait Till Element Visible    //div[@role='button'][.//span[text()='${quick_filter_name}']]
    Wait For Page Ready
    Click Element Safely         //div[@role='button'][.//span[text()='${quick_filter_name}']]
    Wait For Page Ready
    
open first timecard details from listing and store talent name
    Wait For Page Ready
    Wait Till Element Visible    ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    ${first_timecard_talent_name}=    Get Text    ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    Set Suite Variable    ${first_timecard_talent_name}    ${first_timecard_talent_name}
    Log                   First Talent Stored: ${first_timecard_talent_name}
    Wait For Page Ready
    Scroll Element Into View     ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
    Click Element Safely         ${XPATH_TABLE_ROW_FIRST_TALENT_LINK}
#    Wait For Page Ready

Filter Timecard By Column by selecting dropdown on HCS
    [Arguments]    ${column_name}    ${column_value}

    Wait For Page Ready

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

    Wait For Page Ready

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
    Wait For Page Ready

Filter Timecard By Column by entering text on HCS
    [Arguments]    ${column_name}    ${column_value}
    Wait For Page Ready
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
    Wait For Page Ready
    Sleep    3s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible    //div[contains(@class,'k-grid-content')]//tr

    Scroll Element Into View        (//tr[@class='k-table-row']//th)[1]

Validate Timecards Line Items Statuses on HCS
    [Arguments]    ${expected_line_item_status}

    Wait For Page Ready
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
    
