*** Settings ***
Library     SeleniumLibrary
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
${LAST_USED_TEMPLATE_NAME_OPTIONS}                  xpath://h2[.//span[normalize-space()='Last Used']]/following-sibling::div//tbody//span[@class='name-col']
${SELECT_BUTTON}                                    xpath://button[@type='submit']/span[text()='SELECT']
${JOB_DETAILS_LIST_OPTIONS}                         xpath://tbody//span[contains(@class,'name-col') and @role='button']
*** Keywords ***
Verify Job Order Administration Page Title
    Verify Page Title    Job Order Administration

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
    RETURN    ${i}    ${txt}

Open Job Details By Selecting Right Side Panel Header of Selected Random Job
    ${i}    ${txt}=    Select a Random Job Details from List
    Wait For Page Ready    50s
    Wait Till Element Visible    ${SIDE_PANEL_TITLE}
    Click Element Safely    ${SIDE_PANEL_TITLE}    50s
    Wait For Page Ready    50s
    Verify Job Details Page Title    ${txt}
