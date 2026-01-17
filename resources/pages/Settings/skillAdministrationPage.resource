*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${SKILL_HEADERS}          //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${SKILL_ROWS_LOCATOR}     //table[contains(@class,'k-grid-table')]//tbody//tr

*** Keywords ***
Verify Skill Administration Page Title
    Verify Page Title    Skill Administration

Verify Hiring Process Values have Button
    Wait For Page Ready
    ${col_index}=    Get Column Index By Header Text    ${SKILL_HEADERS}    Hiring Process
    Verify All Rows In Column Have Element    ${SKILL_HEADERS}    Hiring Process    ${SKILL_ROWS_LOCATOR}    //button

Select Random Skill Hiring Process Rules
    Wait Till Element Visible   ${SKILL_HEADERS}    50s
    ${col_index}=    Get Column Index By Header Text    ${SKILL_HEADERS}    Hiring Process
    ${i}    ${txt}=    Select Random Element And Return Index And Text    ${SKILL_ROWS_LOCATOR}    False
    Log    Selected row index: ${i}
    Log    Selected col index: ${col_index}
    Wait Till Element Visible    xpath:((${SKILL_ROWS_LOCATOR})[${i}])//td[${col_index}]    50s
    Click Element Safely    ((${SKILL_ROWS_LOCATOR})[${i}])//td[${col_index}]
    Wait For Page Ready

Verify Hiring Process Window Title
    Verify Text Is Visible    View Rules