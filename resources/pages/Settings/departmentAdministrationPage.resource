*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Library    DateTime
Library    String
Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource

*** Variables ***
${ADD_DEPARTMENT_BTN}                xpath://button[.//span[normalize-space()='Add Department']]
${ADD_DEPARTMENT_WINDOW_TITLE}       xpath://div[contains(@class,'k-dialog-titlebar')]//span[contains(@class,'k-dialog-title')]
${DEPARTMENT_NAME_INPUT}             xpath://label[normalize-space()='Department Name']/preceding-sibling::input
${COST_CENTER_INPUT}                 xpath://label[normalize-space()='Cost Center']/preceding-sibling::input
${LOCATION_DROPDOWN}                 xpath://label[normalize-space(text())='Location']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${LOCATION_OPTIONS_LOCATOR}          xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${SKILLS_INPUT}                      xpath://label[normalize-space()='Skills']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${SKILLS_OPTIONS}                    xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${SHIFTS_INPUT}                      xpath://label[normalize-space()='Shifts']/preceding-sibling::div//input[contains(@class,'k-input-inner')]
${SHIFTS_OPTIONS}                    xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${SAVE_DEPARTMENT}                   xpath://button[.//span[normalize-space()='ADD DEPARTMENT']]

*** Keywords ***
Verify Department Administration Page Title
    Verify Page Title    Department Administration

Verify Add Department Window Title
    Wait Till Element Visible    ${ADD_DEPARTMENT_WINDOW_TITLE}
    ${title}=    Get Text            xpath=//span[contains(@class,'k-dialog-title')]
    Should Contain    ${title}    Add Department

Select Add Department Button
    Wait For Page Ready
    Wait Till Element Visible    ${ADD_DEPARTMENT_BTN}
    Click Element Safely    ${ADD_DEPARTMENT_BTN}
    Wait For Page Ready
    Verify Add Department Window Title

Input Uniq Department Name
    Wait Till Element Visible    ${DEPARTMENT_NAME_INPUT}
    ${location}=    Generate And Store Global Unique Name    TestDepartmentApprovalFlow    APPROVAL_DEPARTMENT_NAME
    Input Text Safely    ${DEPARTMENT_NAME_INPUT}    ${location}

Select Specified Location for Department Creation
    [Arguments]    ${location}
    Wait For Page Ready
    Sleep    1s
    From Dropdown Verify or Select an Option    ${LOCATION_DROPDOWN}    ${LOCATION_OPTIONS_LOCATOR}    ${location}    select
    Wait For Page Ready

Input Uniq CostCenter for Department Creation
    Wait Till Element Visible    ${COST_CENTER_INPUT}
    ${costCenter}=    Generate And Store Global Unique Name    TestCostCenterApprovalFlow    APPROVAL_COST_CENTER_NAME
    Input Text Safely    ${COST_CENTER_INPUT}    ${costCenter}


Select Specific Value From SKills Field for Department Creation
    [Arguments]    ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${SKILLS_INPUT}
    Scroll To View Element    ${SKILLS_INPUT}
    From Dropdown Verify or Select an Option    ${SKILLS_INPUT}    ${SKILLS_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Sleep    1s

Select Specific Value From Shifts Field for Department Creation
    [Arguments]    ${VALUE}
    Wait For Page Ready
    Wait Till Element Visible    ${SHIFTS_INPUT}
    Scroll To View Element    ${SHIFTS_INPUT}
    From Dropdown Verify or Select an Option    ${SKILLS_INPUT}    ${SHIFTS_OPTIONS}    ${VALUE}    select
    Wait For Page Ready
    Scroll To View Element    xpath://textarea[@name='onboardingMessage']
    Click Element    xpath://textarea[@name='onboardingMessage']
    Sleep    1s

Save new Department
    Wait For Page Ready    
    Wait Till Element Enabled        ${SAVE_DEPARTMENT}
    Click Element Safely    ${SAVE_DEPARTMENT}
    Wait For Page Ready    