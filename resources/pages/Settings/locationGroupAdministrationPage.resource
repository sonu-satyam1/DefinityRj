*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Library    DateTime
Library    String
Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource

*** Variables ***
${ADD_GROUP_BTN}                     xpath://button[.//span[normalize-space()='ADD GROUP']]
${ADD_GROUP_WINDOW_TITLE}            xpath://div[contains(@class,'k-dialog-titlebar')]//span[contains(@class,'k-dialog-title')]
${GROUP_NAME_INPUT}                  xpath://label[normalize-space()='Group Name']/preceding-sibling::input
${GROUP_CODE_INPUT}                 xpath://label[normalize-space()='Group Code']/preceding-sibling::input
${LEVEL_DROPDOWN}                 xpath://label[normalize-space(text())='Level']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${LEVEL_OPTIONS_LOCATOR}          xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${PARENT_GROUP_DROPDOWN}            xpath://label[normalize-space(text())='Select Parent Group']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${PARENT_GROUP_OPTIONS}                    xpath://ul[@role='listbox']//span[contains(@class,'k-list-item-text')]
${SAVE_GROUP}                   xpath://button[.//span[normalize-space()='Add Group']]

*** Keywords ***
Verify Location Group Administration Page Title
    Verify Page Title    Location Group Administration

Verify Add Group Window Title
    Wait Till Element Visible    ${ADD_GROUP_WINDOW_TITLE}
    ${title}=    Get Text            xpath=//span[contains(@class,'k-dialog-title')]
    Should Contain    ${title}    Add Group

Select Add Group Button
    Wait For Page Ready
    Wait Till Element Visible    ${ADD_GROUP_BTN}
    Click Element Safely    ${ADD_GROUP_BTN}
    Wait For Page Ready
    Verify Add Group Window Title

Input Uniq Group Name
    Wait Till Element Visible    ${GROUP_NAME_INPUT}
    ${group}=    Generate And Store Global Unique Name    TestGroupApprovalFlow    APPROVAL_GROUP_NAME
    Input Text Safely    ${GROUP_NAME_INPUT}    ${group}

Select Market as Level and Placeholder Group as Parent Group for Group Creation
    Wait For Page Ready
    Sleep    1s
    From Dropdown Verify or Select an Option    ${LEVEL_DROPDOWN}    ${LEVEL_OPTIONS_LOCATOR}    Market    select
    Wait Till Element Visible    ${PARENT_GROUP_DROPDOWN}
    Sleep    1s
    From Dropdown Verify or Select an Option    ${PARENT_GROUP_DROPDOWN}    ${PARENT_GROUP_OPTIONS}    Placeholder Group    select
    Wait For Page Ready


Input Group Code for Group Creation
    [Arguments]    ${code}
    Wait Till Element Visible    ${GROUP_CODE_INPUT}
    Input Text Safely    ${GROUP_CODE_INPUT}    ${code}


Save new Group
    Wait For Page Ready    
    Wait Till Element Enabled        ${SAVE_GROUP}
    Click Element Safely    ${SAVE_GROUP}
    Wait For Page Ready    