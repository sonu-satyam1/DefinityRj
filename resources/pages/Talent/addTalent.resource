*** Settings ***
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource
Library    ../../../libs/test_data_generator.py

*** Variables ***
${talentName_header}  xpath://h1[text()='Talent Name']
${EMAIL_TEXTBOX}  xpath://input[@name='emailAddress']
${MOBILE_TEXTBOX}  xpath://input[@id='mobilePhone']
${FIRST_NAME_TEXTBOX}  xpath://input[@name='firstName']
${LAST_NAME_TEXTBOX}  xpath://input[@name='lastName']
${ADDRESS1_TEXTBOX}  xpath://input[@name='address1']
${CITY_TEXTBOX}  xpath://input[@name='city']
${STATE_LIST}    xpath://ul[@id="statelist"]
${sex_dropdown}    xpath://label[normalize-space(.)="Sex"]/preceding::button[@aria-label="expand combobox"][1]
${gender_dropdown}    xpath://label[normalize-space(.)="Gender"]/preceding::button[@aria-label="expand combobox"][1]
${STATE_DROPDOWN}    xpath://label[normalize-space(.)="State"]/preceding::button[@aria-label="expand combobox"][1]
${recruiter_dropdown}    xpath://label[normalize-space(.)="Recruiter"]/preceding::button[@aria-label="expand combobox"][1]
${referralSource_dropdown}    xpath://label[normalize-space(.)="Referral Source"]/preceding::button[@aria-label="expand combobox"][1]
${zip_txtbox}  xpath://input[@name='zip']
${professionalSummary_tab}  xpath://ul[@role='tablist']//li/span[text()='Professional Summary']
${skills_option}  xpath://span[@role="combobox" and @aria-label="Skills"]
${dynamicElement}    xpath=//div[@class="k-animation-container vm-form-select-popup w-396 k-animation-container-shown"]
${skilldpdw_list}    xpath=//div[@id=':r3k:']
${CHECKBOX_BASE}     //div[contains(@class,'k-treeview')]//li
${yearsOfExperience_txtbox}  xpath://input[@id='yearsOfExperience']
${save_btn}  xpath://button[@type='submit']
${STATE}    ${state}



*** Keywords ***
Add Talent Page Should Be Open
    ${title}=    Get Text Safely    xpath://span[text()='Add Talent']
    Generic Assert Element Text Equals    ${title}    Add Talent
    Sleep    2 sec

Add Talent emailAddress Details
    [Arguments]    ${email}=None
    Sleep    1s
    IF    '${email}' == 'None'
        ${email}=    Generate Random Email
    END
    Input Text Safely    ${EMAIL_TEXTBOX}    ${email}
    Wait Till Element Disappear    ${PAGE_LOADER}    50s
    Sleep    2s

Add Talent Mobile Number
    [Arguments]    ${mobile}=None
    Sleep    1s
    IF    '${mobile}' == 'None'
        ${mobile}=    Generate Random Mobile
    END
    Input Text Safely    ${MOBILE_TEXTBOX}    ${mobile}
    Sleep    2s

Add Talent First And Last Name
    Sleep    1s
    ${first_name}    ${last_name}    ${full_name}=    Generate Unique Name Details
    Wait Till Element Visible    ${FIRST_NAME_TEXTBOX}    50s
    Input Text Safely    ${FIRST_NAME_TEXTBOX}    ${first_name}
    Wait Till Element Visible    ${LAST_NAME_TEXTBOX}    50s
    Input Text Safely    ${LAST_NAME_TEXTBOX}     ${last_name}
    Log    Talent Full Name Created: ${full_name}

Add Talent Address Details
    [Arguments]    ${address}=None
    IF    '${address}' == 'None'
        ${address}=    Set Variable    Test Address
    END
    Click Outside To Close Popup
    Wait Till Element Visible    ${ADDRESS1_TEXTBOX}    50s
    Input Text Safely            ${ADDRESS1_TEXTBOX}    ${address}

Add Talent City
    [Arguments]    ${city}=None
    IF    '${city}' == 'None'
        ${city}=    Set Variable    Test City
    END
    Click Outside To Close Popup
    Wait Till Element Visible    ${CITY_TEXTBOX}    50s
    Input Text Safely            ${CITY_TEXTBOX}    ${city}

Add Talent State Details
    [Arguments]    ${state}
    Sleep    1 sec
    Wait Till Element Visible    ${STATE_DROPDOWN}    50s
    Click Element               ${STATE_DROPDOWN}
    Sleep    2 sec
    Wait Till Element Disappear    ${PAGE_LOADER}     50s
    Wait Till Element Visible   ${STATE_LIST}     50s
    Sleep    2 sec
    Click Element    xpath=//ul[@id="statelist"]/li/span[normalize-space(.)="${STATE}"]
    Sleep    2 sec

Add Talent first State Details from dropdown
    Sleep    2 sec
    Wait Until Element Is Visible    ${state_dropdown}    50 sec
    Click Element    ${state_dropdown}
    Sleep    2 sec
    Wait Until Page Does Not Contain Element    xpath=//div[contains(@class,"page-loader")]    50s
    Wait Until Element Is Visible    xpath=//ul[@id="statelist"]    50s
    Sleep    2 sec
    Click Element    xpath=//ul[@id="statelist"]/li[1]
    Sleep    2 sec

Add Talent Zip Details
    Sleep    2 sec
    Wait Until Element Is Visible    ${zip_txtbox}    50 sec
    Input Text    ${zip_txtbox}    ${zip}
    Sleep    2 sec
select Talent Professional Summary tab
    Sleep    2 sec
    Wait Until Element Is Visible    ${professionalSummary_tab}    50 sec
    Click Element    ${professionalSummary_tab}
    Sleep    2 sec
Add Talent Skills Details in Professional Summary tab
    Sleep    2 sec
    Wait Until Element Is Visible    ${professionalSummary_tab}    50 sec
    Wait Until Element Is Visible    ${skills_option}    50 sec
    Sleep    2 sec
    Click Element    ${skills_option}
    Sleep    2 sec
    Wait Until Element Is Visible    ${dynamicElement}    50 sec
    Sleep    2 sec
    Wait Until Element Is Visible    xpath=${CHECKBOX_BASE}    10s
    Click Element    xpath=//body
    Sleep    1s
    Wait Until Element Is Visible    ${CHECKBOX_BASE}    20s
    Sleep    1s
    FOR    ${index}    IN RANGE    6
    ${locator}=    Set Variable    xpath=(${CHECKBOX_BASE})[${index + 1}]//input[@type="checkbox"]
    Run Keyword And Ignore Error    Checkbox Should Be Selected    ${locator}
    ${status}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${locator}
        IF    '${status}' == 'False'
            Scroll Element Into View    ${locator}
            Click Element                ${locator}
        END
    END
    Sleep    2 sec
Add Talent yearsOfExperience Details in Professional Summary tab
    Sleep    2 sec
    Wait Until Element Is Visible    ${professionalSummary_tab}    50 sec
    Wait Until Element Is Visible    ${yearsOfExperience_txtbox}    50 sec
    Input Text    ${yearsOfExperience_txtbox}    5
    Sleep    2 sec
Save Talent Details
    Sleep    2 sec
    Wait Until Element Is Visible    ${save_btn}    50 sec
    Wait Until Element Is Enabled    ${save_btn}    50 sec
    Click Button    ${save_btn}
    Sleep    5 sec

