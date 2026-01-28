*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py

Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource


*** Variables ***
${SKILL_HEADERS}                  //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ADD_WORKFLOW_BTN}               xpath://button[normalize-space(.)='ADD WORKFLOW']
${RULE_NAME_INPUT}                xpath://label[normalize-space(.)='Rule Name']/preceding::input[1]
${NO_RESULT}                      No results
${APPROVERS_DROPDOWN}             xpath://label[.//span[normalize-space()='Approvers']]
${APPROVERS_SEARCH_BOX}           xpath://input[contains(@class,'mbsc-select-filter-input')]
${APPROVERS_SEARCH_OPTIONS}       //div[@role='listbox']//div[@role='option']//input[@type='checkbox']/following-sibling::p
${MARKET_CLEAR_BTN}               xpath://label[normalize-space()='Market']/preceding-sibling::div//span[contains(@class,'k-chip-remove-action')]
${MARKET_INPUT}                   xpath://form//label[normalize-space()='Market']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${MARKET_OPTIONS}                 xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${LOCATION_INPUT}                 xpath://form//label[normalize-space()='Location']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${LOCATION_OPTIONS}               xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${COST_CENTER_INPUT}              xpath://form//label[normalize-space()='Cost Center']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${COST_CENTER_OPTIONS}            xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${SKILL_TYPE_CLEAR_BTN}           xpath://label[normalize-space()='Skill Types']/preceding-sibling::div//span[contains(@class,'k-chip-remove-action')]
${SKILL_TYPE_INPUT}               xpath://form//label[normalize-space()='Skill Types']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${SKILL_TYPE_OPTIONS}             xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${SKILLS_INPUT}                   xpath://form//label[normalize-space()='Skills']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${SKILLS_OPTIONS}                 xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${FILL_TYPE_CLEAR_BTN}            xpath://label[normalize-space()='Fill Type']/preceding-sibling::div//span[contains(@class,'k-chip-remove-action')]
${FILL_TYPE_INPUT}                xpath://form//label[normalize-space()='Fill Type']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${FILL_TYPE_OPTIONS}              xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${NO_RECORDS_FOUND}               NO DATA FOUND.
${ADD-BTN}                        xpath://button[.//span[normalize-space()='ADD']]
${SEARCH_BOX}                 xpath://label[normalize-space()='Search']/preceding::input[1]
${HEADER_TITLES}              xpath://table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                 //table[contains(@class,'k-grid-table')]//tbody//tr
${NO_RECORDS_TEXT}            No records available
${ACTION_RELATIVE_XPATH}     //button[contains(@class,'icon-edit')]
${EDIT_WINDOW_TITLE}             xpath://div[contains(@class,'k-dialog-titlebar')]//span[contains(@class,'k-dialog-title')]


*** Keywords ***
Verify Approval Workflow Administration Page Title
    Verify Page Title    Approval Workflow Administration

Create Approval Workflow
    Wait For Page Ready
    Wait Till Element Visible    ${ADD_WORKFLOW_BTN}
    Click Element Safely    ${ADD_WORKFLOW_BTN}
    Wait For Page Ready

Input Uniq Rule Name in WorkFlow Creation
    Wait Till Element Visible    ${RULE_NAME_INPUT}
    ${rule}=    Generate And Store Global Unique Name    TestRule    WORKFLOW_RULE_NAME
    Input Text Safely    ${RULE_NAME_INPUT}    ${rule}
    Wait For Page Ready
    Sleep    1s

Select provided Approver from Approvers List
    [Arguments]    ${NAME}
    Wait Till Element Visible    ${APPROVERS_DROPDOWN}
    Sleep    1s
    Click Element Safely    ${APPROVERS_DROPDOWN}
    Search And Select First Option From the Resultant Rows     ${APPROVERS_SEARCH_BOX}    ${NAME}    ${APPROVERS_SEARCH_OPTIONS}    ${NO_RESULT}
    Wait For Page Ready
    Sleep    0.5s
    Press Keys    None    ESC
    Sleep    2s


Clear and Select Specific Value From Market Field
    [Arguments]       ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${MARKET_CLEAR_BTN}
    Scroll To View Element    ${MARKET_CLEAR_BTN}
    Click Element Safely    ${MARKET_CLEAR_BTN}
    From Dropdown Verify or Select an Option    ${MARKET_INPUT}    ${MARKET_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Sleep    1s

Select Specific Value From Location Field
    [Arguments]    ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${LOCATION_INPUT}
    Scroll To View Element    ${LOCATION_INPUT}
    From Dropdown Verify or Select an Option    ${LOCATION_INPUT}    ${LOCATION_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Sleep    1s

Select Result Cost Center Value For Applied Location
    Wait For Page Ready
    Sleep    1s
    Wait Till Element Visible    ${COST_CENTER_INPUT}
    Scroll To View Element    ${COST_CENTER_INPUT}
    Sleep    1s
    Click Element Safely    ${COST_CENTER_INPUT}
    Wait Till Element Visible    xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
    Click Element Safely    xpath:(//ul[@role='listbox']//span[contains(@class,'k-list-item-text')])[1]
    Wait For Page Ready
    Sleep    1s

Clear and Select Specific Value From Skill Type Field
    [Arguments]       ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${SKILL_TYPE_CLEAR_BTN}
    Scroll To View Element    ${FILL_TYPE_CLEAR_BTN}
    Click Element Safely    ${SKILL_TYPE_CLEAR_BTN}
    Sleep    2s
    From Dropdown Verify or Select an Option    ${SKILL_TYPE_INPUT}    ${SKILL_TYPE_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Sleep    1s

Select Specific Value From Skills Field
    [Arguments]    ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${SKILLS_INPUT}
    Scroll To View Element    ${SKILLS_INPUT}
    Input Text Safely    ${SKILLS_INPUT}    ${VALUE}
    Wait Till Element Visible    xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
    Click Element Safely    xpath:(//ul[@role='listbox']//span[contains(@class,'k-list-item-text')])[1]
    Wait For Page Ready
    Sleep    1s

Select Specific Value From Fill Type
    [Arguments]    ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${FILL_TYPE_CLEAR_BTN}
    Scroll To View Element    ${FILL_TYPE_CLEAR_BTN}
    Click Element Safely    ${FILL_TYPE_CLEAR_BTN}
    Sleep    2s
    From Dropdown Verify or Select an Option    ${FILL_TYPE_INPUT}    ${FILL_TYPE_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Sleep    2s
    Press Keys    NONE    TAB

Click Add For Workflow Creation
    Wait For Page Ready
    Wait Till Element Enabled    ${ADD-BTN}
    Click Element Safely    ${ADD-BTN}
    Wait For Page Ready
    Sleep    3s

Search and Select for Specified WorkFlow
    [Arguments]    ${name}
    Wait For Page Ready
    Wait Till Element Visible    ${SEARCH_BOX}
    Search Verify And Click Action In Same Row    ${SEARCH_BOX}    ${name}    Rule Name    ${HEADER_TITLES}    ${ROWS_XPATH}    ${ACTION_RELATIVE_XPATH}
#    Search And Verify Specified Column Value    ${SEARCH_BOX}    ${name}    Rule Name    ${HEADER_TITLES}    ${ROWS_XPATH}
    Sleep    2s
    Wait Till Element Visible    ${EDIT_WINDOW_TITLE}
    Generic Assert Element Text Equals    ${EDIT_WINDOW_TITLE}    Edit Workflow




