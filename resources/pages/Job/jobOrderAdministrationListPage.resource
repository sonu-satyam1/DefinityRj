*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource


*** Variables ***
${HEADER_JOB_ORDER_ADMINISTRATION}    xpath://h1[normalize-space()='Job Order Administration']
${ADD_NEW_JOB_BTN}                    xpath://button[.//span[normalize-space(.)='Add New Job']]
${ADD_NEW_JOB_DPDWN}                  xpath://div[contains(@class,'k-split-button') and .//span[normalize-space(.)='Add New Job']]//span[contains(@class,'k-svg-i-caret-alt-down')]
${ADD_NEW_JOB_OPTIONS}                xpath://ul[contains(@id,'accessibility-id')]//li
${SELECT_TEMPLATE_WINDOW_TITLE}       xpath://span[normalize-space(.)='Select a Template']
${SIDE_PANEL_TITLE}                   xpath://div[contains(@class,'slide-pane-job-details')]//h2
${BULK_EDIT_BTN}                      xpath://button[.//span[normalize-space(.)='Bulk edit']]
${FILTER_OPTION_DPDWN}                xpath://span[contains(@class,'icon-play')]
${CALENDAR_BODY}                      xpath://div[contains(@class,'MuiDateCalendar-root')]
${COLUMN_FILTER_BTN}                  xpath://button[.//span[contains(@class,'icon-play')]]
${SHOW_ALL_BTN}                       xpath://button[.//span[normalize-space(.)='Show All']]


*** Keywords ***
Verify Job Order Administration Page Title
    Verify Page Title    Job Order Administration


