*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py

Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource


*** Variables ***
${SKILL_HEADERS}              //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${SKILL_ROWS_LOCATOR}         //table[contains(@class,'k-grid-table')]//tbody//tr
${ADD_SKILL_BUTTON}           xpath://button[.//span[normalize-space()='Add Skill']]
${SKILL_NAME_LOCATOR}         xpath://input[@name='name']
${SKILL_CATEGORY_DROPDOWN}    xpath://label[normalize-space(.)="Skill Category"]/preceding::button[@aria-label="expand combobox"][1]
${SKILL_CATEGORY_OPTIONS}     xpath://ul[@id='skillCategorylist']//span[@class='k-list-item-text']
${SKILL_TYPE_DROPDOWN}        xpath://label[normalize-space(.)="Skill Type"]/preceding::button[@aria-label="expand combobox"][1]
${SKILL_TYPE_OPTIONS}         xpath://ul[@id='skillTypelist']//span[@class='k-list-item-text']
${JOB_TYPE_LOCATOR}           xpath:.//label[normalize-space()='Job Type']/preceding::input[1]
${JOB_TYPE_OPTION}            //ul[@role='listbox']//span[@class='k-list-item-text']
${TALENT_TYPE_LOCATOR}        xpath:.//label[normalize-space()='Talent Type']/preceding::input[1]
${TALENT_TYPE_OPTION}            //ul[@role='listbox']//span[@class='k-list-item-text']
${HIRING_PROCESS_DROPDOWN}    xpath://label[normalize-space()='Hiring Process']/preceding::button[1]
${HIRING_PROCESS_OPTION}            //ul[@role='listbox']//span[@class='k-list-item-text']
${SAVE_BUTTON}                xpath://button[@type='submit']/span[text()='Save']
${SEARCH_BOX}                 xpath://label[normalize-space()='Search']/preceding::input[1]
${HEADER_TITLES}              xpath://table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                 //table[contains(@class,'k-grid-table')]//tbody//tr
${NO_RECORDS_TEXT}            No records available
${EDIT_BUTTON}                xpath://button[.//span[normalize-space()='Edit']]
${ADD_RULE_BUTTON}            xpath://button[normalize-space()='+ Add Rule']
${RULE_BLOCKS}                (//p[starts-with(normalize-space(),'Rule')]/ancestor::div[contains(@class,'d-flex')]/parent::div)
${ERROR_MESSAGE}              Each combination of job type and talent type can be assigned to only one hiring process.


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

Select Add Skill Button
    Wait Till Element Visible    ${ADD_SKILL_BUTTON}
    Click Element Safely    ${ADD_SKILL_BUTTON}
    Verify Text Is Visible    Add Skill
    Wait For Page Ready

Input Uniq Skill Name
    Wait Till Element Visible    ${SKILL_NAME_LOCATOR}
    ${skill}=    Generate And Store Global Unique Name    TestSkill    SKILL_NAME
    Input Text Safely    ${SKILL_NAME_LOCATOR}    ${skill}

select Clinical Option For Skill Category
    From Dropdown Verify Or Select An Option  ${SKILL_CATEGORY_DROPDOWN}    ${SKILL_CATEGORY_OPTIONS}    Clinical    select
    Wait For Page Ready

select Clinical Option For Skill Type
    From Dropdown Verify Or Select An Option  ${SKILL_TYPE_DROPDOWN}    ${SKILL_TYPE_OPTIONS}    Clinical    select
    Wait For Page Ready

Select Provided Job Type
    [Arguments]    ${option}
    Wait Till Element Visible    ${JOB_TYPE_LOCATOR}
    From Dropdown Verify or Select an Option    ${JOB_TYPE_LOCATOR}    ${JOB_TYPE_OPTION}    ${option}    select
    Wait For Page Ready

Select Provided Talent Type
    [Arguments]    ${option}
    Wait Till Element Visible    ${TALENT_TYPE_LOCATOR}
    From Dropdown Verify or Select an Option    ${TALENT_TYPE_LOCATOR}    ${TALENT_TYPE_OPTION}    ${option}    select
    Wait For Page Ready

Select Provided Hiring Process
    [Arguments]    ${option}
    Wait Till Element Visible    ${HIRING_PROCESS_DROPDOWN}
    From Dropdown Verify or Select an Option    ${HIRING_PROCESS_DROPDOWN}    ${HIRING_PROCESS_OPTION}    ${option}    select
    Wait For Page Ready

Save Skill Details
    Wait Till Element Visible    ${SAVE_BUTTON}
    Click Element Safely    ${SAVE_BUTTON}
    Wait For Page Ready

Select Specified Skill
    [Arguments]    ${name}
    Search And Select First Result By Column    ${SEARCH_BOX}    ${name}    ${HEADER_TITLES}    Skill Name    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait For Page Ready

Edit Skill Details
    Wait For Page Ready
    Wait Till Element Visible    ${EDIT_BUTTON}
    Click Element Safely    ${EDIT_BUTTON}
    Wait For Page Ready

Clear Inputs Rules
    Wait For Page Ready
    Wait Till Element Visible        xpath://div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//div[contains(@class,'d-flex align-items-center justify-content-start mb-2')]    50s

    ${rule_count}=    Get Element Count    xpath=//div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//div[contains(@class,'d-flex align-items-center justify-content-start mb-2')]

    WHILE    ${rule_count} > 1
        ${remove_buttons}=    Get WebElements    xpath=//div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//span[contains(@class,'icon-minus-circle')]
        Click Element Safely        ${remove_buttons}[0]    # remove the first extra rule
        Sleep    0.5s    # wait for DOM to update
        ${rule_count}=    Get Element Count    xpath=//div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//div[contains(@class,'d-flex align-items-center justify-content-start mb-2')]
    END
    Clear Single Rule Inputs

Clear Single Rule Inputs
    Wait For Page Ready
    Wait Until Element Is Visible    ((//div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//div)[1]//span[@class='k-clear-value'])[1]    50s
    ${clear_buttons}=    Get WebElements    xpath=(//div[@class='w-75 add-skill-right-wrapper pe-0 ps-3']//div)[1]//span[@class='k-clear-value']
    FOR    ${btn}    IN    @{clear_buttons}
        Run Keyword And Ignore Error    Click Element    ${btn}
        Sleep    1s
    END

Add Rule
    Sleep    2s
    Wait Till Element Visible        ${ADD_RULE_BUTTON}    50s
    Click Element Safely        ${ADD_RULE_BUTTON}
    Wait Till Element Visible        xpath:(//div[contains(@class,'d-flex') and contains(@class,'mb-2')]/p)[last()]    50s
    ${last_rule}=    Get Text    xpath=(//div[contains(@class,'d-flex') and contains(@class,'mb-2')]/p)[last()]
    Log    Last added rule is: ${last_rule}

Select Multi Options In Rule
    [Arguments]    ${rule_index}    ${field_label}    @{option_texts}

    ${dropdown_xpath}=    Set Variable
    ...    (//div[contains(@class,'d-flex align-items-start')])[${rule_index}]//label[normalize-space(.)="${field_label}"]/preceding::input[@aria-haspopup='listbox'][1]

    Wait Until Element Is Visible    ${dropdown_xpath}    50s
    Click Element    ${dropdown_xpath}
    Sleep    1s

    ${checkboxes}=    Get WebElements    //ul[@role='listbox']//input[@type='checkbox']
    ${count}=    Get Length    ${checkboxes}
    Should Be True    ${count} > 0    msg=Dropdown is not multi-select for ${field_label}

    FOR    ${option_text}    IN    @{option_texts}
        ${option_xpath}=    Set Variable    //li[.//span[normalize-space(text())="${option_text}"]]
        Wait Until Element Is Visible    ${option_xpath}    10s

        ${checkbox_xpath}=    Set Variable    ${option_xpath}//input[@type='checkbox']

        ${is_checked}=    Run Keyword And Return Status
        ...    Element Attribute Value Should Be    ${checkbox_xpath}    checked    true

        IF    not ${is_checked}
            Click Element    ${checkbox_xpath}
            Log To Console    Selected: ${option_text}
            Sleep    0.5s
        ELSE
            Log To Console    Already selected: ${option_text}
        END
    END

Select Single Option In Rule
    [Arguments]    ${rule_index}    ${field_label}    ${option_text}

    ${dropdown_btn_xpath}=    Set Variable
    ...    (//div[contains(@class,'d-flex align-items-start')])[${rule_index}]//label[normalize-space(.)="${field_label}"]/preceding::input[1]/following-sibling::button

    Wait Until Element Is Visible    ${dropdown_btn_xpath}    50s
    Click Element    ${dropdown_btn_xpath}
    Sleep    1s

    ${checkboxes}=    Get WebElements    //ul[@role='listbox']//input[@type='checkbox']
    ${count}=    Get Length    ${checkboxes}
    Should Be True    ${count} == 0    msg=Expected single-select for ${field_label}

    ${option_xpath}=    Set Variable    //li[.//span[normalize-space(text())="${option_text}"]]
    Wait Until Element Is Visible    ${option_xpath}    30s

    ${is_selected}=    Get Element Attribute    ${option_xpath}    aria-selected

    IF    '${is_selected}' != 'true'
        Click Element    ${option_xpath}
        Log To Console    Selected: ${option_text}
    ELSE
        Log To Console    Already selected: ${option_text}
    END

Input Hours to Offer Value
    [Arguments]    ${rule_index}    ${number}
    Sleep    2s
    ${hrstoOffer_txt_xpath}=    Set Variable    //input[@name='hiringProcessRules[${rule_index}].autoOfferHours']
    Wait Until Element Is Visible    ${hrstoOffer_txt_xpath}    50s
    Sleep    1s
    Click Element    ${hrstoOffer_txt_xpath}
    SeleniumLibrary.Press Keys       ${hrstoOffer_txt_xpath}    CTRL+A    BACKSPACE
    Input Text    ${hrstoOffer_txt_xpath}    ${number}
    Sleep    2 sec

Validate Error Message
    Wait Until Element Is Visible    xpath=//div[@class='notification-right']//span[@class='notify-msg']    10s
    ${msg}=    Get Text    xpath=//div[@class='notification-right']//span[@class='notify-msg']
    Should Be Equal As Strings    ${msg}    ${ERROR_MESSAGE}
    Wait For Page Ready
