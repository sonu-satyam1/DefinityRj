*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource
Resource    jobDetailsPage.resource


*** Variables ***
${HEADER_JOB_ORDER_ADMINISTRATION}                  xpath://h1[normalize-space()='Job Order Administration']
${ADD_NEW_JOB_BTN}                                  xpath://button[.//span[normalize-space(.)='Add New Job']]
${ADD_NEW_JOB_DROPDOWN_LOCATOR}                     xpath://div[contains(@class,'k-split-button') and .//span[text()='Add New Job']]//span[contains(@class,'k-svg-i-caret-alt-down')]
${ADD_NEW_JOB_OPTIONS}                              xpath://ul[contains(@id,'accessibility-id')]//li
${SELECT_TEMPLATE_WINDOW_TITLE}                     xpath://span[normalize-space(.)='Select a Template']
${SIDE_PANEL_TITLE}                                 xpath://div[contains(@class,'slide-pane-job-details')]//h2
${BULK_EDIT_BTN}                                    xpath://button[.//span[normalize-space(.)='Bulk edit']]
${FILTER_OPTION_DPDWN}                              xpath://span[contains(@class,'icon-play')]
${CALENDAR_BODY}                                    xpath://div[contains(@class,'MuiDateCalendar-root')]
${COLUMN_FILTER_BTN}                                xpath://button[.//span[contains(@class,'icon-play')]]
${SHOW_ALL_BTN}                                     xpath://button[.//span[normalize-space(.)='Show All']]
${LAST_USED_TEMPLATE_NAME_OPTIONS}                  xpath://h2[.//span[normalize-space()='Last Used']]/following-sibling::div[contains(@class,'k-grid')][1]//tbody/tr
${SELECT_BUTTON}                                    xpath://button[@type='submit']/span[text()='SELECT']
${JOB_DETAILS_LIST_OPTIONS}                         xpath://tbody//span[contains(@class,'name-col') and @role='button']
${SEARCH_BOX}                                       xpath://label[normalize-space()='Search']/preceding::input[1]
${HEADER_TITLES}                                    xpath://table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                                       //table[contains(@class,'k-grid-table')]//tbody//tr
${NO_RECORDS_TEXT}                                  No records available
${FILTER_BUTTON}                                    xpath://div[contains(@class,'k-filter-menu-container')]//button[.//span[text()='Filter']]
${FIRST_CHECKBOX_BULK_EDIT}                         xpath:(//tbody[@role='rowgroup']//input[@type='checkbox'])[1]
${EDIT_SELECTED_ROWS_BUTTON}                        xpath://button[.//span[normalize-space()='Edit Selected Rows']]
${HOT_JOB_DROPDOWN_LOCATOR}                         xpath://label[normalize-space(text())='Hot Job']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${HOT_JOB_OPTIONS_TEXT_LOCATOR}                     xpath://ul[@id='hotJoblist'] //li/span
${BULK_EDIT_SUBMIT_BUTTON}                          xpath://button[@type='submit']/span[text()='Submit']
${BULK_EDIT_WINDOW_HEADER}                          xpath://span[contains(@class,'k-dialog-title') and normalize-space()='Edit Job Orders']
${BULK_EDIT_SUCCESS_MESSAGE}                        xpath://p[contains(@class,'success-msg-content') and contains(normalize-space(),'Job Orders have been updated')]
${CLOSE_BUTTON}                                     xpath://button[@type='button']/span[text()='Close']
${JOB_ORDER_ADMIN_TABS}                                 xpath://ul[contains(@class,'k-tabstrip-items')]
*** Keywords ***
Verify Job Order Administration Page Title
    Verify Page Title    Job Order Administration

Switch to Specified tab in Job Order Administration Page
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Click Element Safely        ${JOB_ORDER_ADMIN_TABS}//li[.//span[normalize-space()='${tab}']]
    Wait For Page Ready

Select Specified Job From List for Pending Approval
    [Arguments]    ${jobName}
    Search And Select First Result By Column    ${SEARCH_BOX}    ${jobName}    ${HEADER_TITLES}    Job Details    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait For Page Ready
    Wait Till Element Visible    xpath://div[@class='vm-right-pane-container']//h1
    Verify Job Details Page Title    ${jobName}



Select Add New Job From Template Option
    Sleep    5s
    Wait Till Element Visible   ${ADD_NEW_JOB_DROPDOWN_LOCATOR}    50s
    From Dropdown Verify or Select an Option    ${ADD_NEW_JOB_DROPDOWN_LOCATOR}    ${ADD_NEW_JOB_OPTIONS}    Add New Job Order From Template    select

Verify Select a Template Window Title
    Verify Dialog Header Text    Select a Template

Select Random Template from LastUsed
    Wait Till Element Visible   ${LAST_USED_TEMPLATE_NAME_OPTIONS}    50s
    ${i}    ${txt}=    Select Random Element And Return Index And Text    ${LAST_USED_TEMPLATE_NAME_OPTIONS}    True
    Log    Selected index: ${i}
    Log    Selected text: ${txt}
    Click Element Safely    ${SELECT_BUTTON}
    Wait For Page Ready    50s

Select a Random Job Details from List
    Wait Till Element Visible   ${JOB_DETAILS_LIST_OPTIONS}    50s
    ${i}    ${txt}=    Select Random Element And Return Index And Text    ${JOB_DETAILS_LIST_OPTIONS}    True
    Log    Selected index: ${i}
    Log    Selected text: ${txt}
    Wait For Page Ready    50s
    Sleep    2s
    RETURN    ${i}    ${txt}

Open Job Details By Selecting Right Side Panel Header of Selected Random Job
    Wait For Page Ready    50s
    ${i}    ${txt}=    Select a Random Job Details from List
    Wait For Page Ready    50s
    Wait Till Element Visible    ${SIDE_PANEL_TITLE}
    Wait For Page Ready    50s
    Click Element Safely    ${SIDE_PANEL_TITLE}    50s
    Wait For Page Ready    50s
    Verify Job Details Page Title    ${txt}
    Wait For Page Ready    50s

Select Specified Job From List in Right Side Panel
    [Arguments]    ${jobName}
    Search And Select First Result By Column    ${SEARCH_BOX}    ${jobName}    ${HEADER_TITLES}    Job Details    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait For Page Ready
    Wait Till Element Visible    ${SIDE_PANEL_TITLE}
    Click Element Safely    ${SIDE_PANEL_TITLE}    50s
    Wait For Page Ready

Scroll Grid To Column
    [Arguments]    ${Header}
    ${xpath}=    Set Variable
    ...    //th[.//span[@class='k-column-title' and normalize-space()='${Header}']]

    Execute Javascript
    ...    var el = document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    el.scrollIntoView({behavior: "instant", block: "nearest", inline: "center"});

Scroll Grid To Bulk Column
    ${xpath}=    Set Variable    //th//input[@id='bulkCheck']

    Execute Javascript
    ...    var el = document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    el.scrollIntoView({behavior: "instant", block: "nearest", inline: "start"});

Click Column Filter Menu
    [Arguments]    ${Header}
    ${menu_xpath}=    Set Variable
    ...    //th[.//span[@class='k-column-title' and normalize-space()='${Header}']]//a[contains(@class,'k-grid-column-menu')]
    Wait Till Element Visible    xpath:${menu_xpath}
    Click Element Safely         xpath:${menu_xpath}


Apply Filter for Open Jobs and Job Type
    [Arguments]    ${Header}    ${Option}
    Wait For Page Ready
    Scroll Grid To Column    ${Header}
    Click Column Filter Menu    ${Header}
    Wait For Page Ready
    Wait Till Element Visible
    ...    xpath://li[.//label[normalize-space()='${Option}']]//input[@type='checkbox']
    Wait For Page Ready
    Click Element Safely
    ...    xpath://li[.//label[normalize-space()='${Option}']]//input[@type='checkbox']
    Wait For Page Ready
    Click Element Safely    ${FILTER_BUTTON}
    Wait For Page Ready
    Sleep    2s

Select Jobs for Bulk Edit
    [Arguments]    ${noOfJobs}
    Wait For Page Ready
    Wait Till Element Visible    ${BULK_EDIT_BTN}
    Click Element Safely         ${BULK_EDIT_BTN}
    Wait For Page Ready
    Scroll Grid To Bulk Column

    FOR    ${index}    IN RANGE    1    ${noOfJobs}
        Click Element Safely
        ...    xpath=(//tbody[@role='rowgroup']//input[@type='checkbox'])[${index}]
        Sleep    0.5s
    END

    Wait For Page Ready
    Click Element Safely    ${EDIT_SELECTED_ROWS_BUTTON}

    
Update Hot Job Option For Bulk Edit
    [Arguments]    ${Option}
    From Dropdown Verify or Select an Option    ${HOT_JOB_DROPDOWN_LOCATOR}    ${HOT_JOB_OPTIONS_TEXT_LOCATOR}    ${Option}    select

Submit Bulk Edit Changes
    Wait For Page Ready
    Wait Till Element Enabled        ${BULK_EDIT_SUBMIT_BUTTON}
    Click Element Safely    ${BULK_EDIT_SUBMIT_BUTTON}
    Wait For Page Ready
    Wait Till Element Disappear    ${BULK_EDIT_WINDOW_HEADER}    80s
    Wait Till Element Visible    ${BULK_EDIT_SUCCESS_MESSAGE}
    Wait Till Element Enabled        ${CLOSE_BUTTON}
    Click Element Safely    ${CLOSE_BUTTON}
    Wait For Page Ready
    

