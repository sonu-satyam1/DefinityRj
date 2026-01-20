*** Settings ***
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource
Library    ../../../libs/RuntimeData.py

Resource    ../../keywords/common_utils.resource

*** Variables ***
${EMAIL_TEXTBOX}          xpath://label[normalize-space()='Email Address']/preceding-sibling::input
${SSN_INPUT}              xpath://input[@name='ssn']
${SSN_POPUP}              xpath://div[contains(@class,'k-dialog')]//span[text()='SSN exists']
${SSN_NO_BTN}             xpath://span[text()='No']/ancestor::button
${DOB_INPUT}              xpath://input[@name='dateOfBirth']
${PHONE_INPUT}            xpath://input[@id='phoneNumber']
${FIRSTNAME_INPUT}        xpath://input[@name='firstName']
${LASTNAME_INPUT}         xpath://input[@name='lastName']
${ADDRESS_INPUT}          xpath://input[@name='address1']
${CITY_INPUT}             xpath://input[@name='city']
${ZIP_INPUT}              xpath://input[@name='zip']
${SUMMARY_INPUT}          xpath://textarea[@id="professionalSummary"]
${STATE_DROPDOWN}         xpath://label[normalize-space()='State']/parent::span[contains(@class,'k-floating-label-container')]//button
${STATE_OPTIONS}          xpath://ul[contains(@class,'k-list-ul')]//li
${YOE_INPUT}              xpath://label[normalize-space()='Years of Experience']/preceding::input[1]
${LICENSE_UPLOAD}         xpath://h4[normalize-space()='Upload License / Identification']/following::input[@type='file'][1]
${RESUME_UPLOAD}          xpath://h4[normalize-space()='Upload Resume / References']/following::input[@type='file'][1]
${STEP2_BUTTON}          xpath://button[.//span[text()='STEP 2']]
${gender_dropdown}    xpath://label[normalize-space(.)="Gender"]/preceding::button[@aria-label="expand combobox"][1]
${recruiter_dropdown}    xpath://label[normalize-space(.)="Recruiter"]/preceding::button[@aria-label="expand combobox"][1]
${referralSource_dropdown}    xpath://label[normalize-space(.)="Referral Source"]/preceding::button[@aria-label="expand combobox"][1]
${skills_option}  xpath://span[@role="combobox" and @aria-label="Skills"]
${dynamicElement}    xpath=//div[@class="k-animation-container vm-form-select-popup w-396 k-animation-container-shown"]
${skilldpdw_list}    xpath=//div[@id=':r3k:']
${CHECKBOX_BASE}     //div[contains(@class,'k-treeview')]//li
${yearsOfExperience_txtbox}  xpath://input[@id='yearsOfExperience']
${save_btn}  xpath://button[@type='submit']



*** Keywords ***
Verify Submit Talent Form Title in Vms
    Wait For Page Ready
    Verify Text Is Visible    Submit Talent Form

Input Uniq Email Address For Talent in Vms
    Wait For Page Ready
    Wait Till Element Visible    ${EMAIL_TEXTBOX}
    ${email}=    Generate And Store Global Unique Email    TestUser    TEST_EMAIL_ADDRESS
    Input Text Safely    ${EMAIL_TEXTBOX}    ${email}
    Wait For Page Ready

Generate Random SSN
    ${num}=    Evaluate    random.randint(100000000, 999999999)    random
    RETURN    ${num}

Enter Unique SSN For Talent in Vms
    [Arguments]    ${runtime_key}

    ${max_retry}=    Set Variable    15
    ${attempt}=      Set Variable    0

    WHILE    ${attempt} < ${max_retry}

        ${ssn}=    Generate Random SSN
        Log    Trying SSN: ${ssn}
        
        Clear Element Text    ${SSN_INPUT}
        Input Text            ${SSN_INPUT}    ${ssn}
        Wait For Page Ready
        # trigger validation if needed
        Press Keys    ${SSN_INPUT}    TAB
        Sleep    1s

        ${popup}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${SSN_POPUP}    2s

        IF    ${popup}
            Log    SSN exists — clicking No and retrying
            Click Element    ${SSN_NO_BTN}
            Sleep    1s
            ${attempt}=    Evaluate    ${attempt}+1
        ELSE
            Log    Unique SSN accepted: ${ssn}

            # ✅ store in suite variable (optional)
            Set Suite Variable    ${${runtime_key}}    ${ssn}

            # ✅ store in runtime_data.json
            Save Value    ${runtime_key}    ${ssn}

            BREAK
        END
    END

    Run Keyword If    ${attempt} == ${max_retry}
    ...    Fail    Could not generate unique SSN after ${max_retry} attempts


Select Date Of Birth For Talent in Vms
    [Arguments]    ${dob}
    Wait For Page Ready    
    Wait Till Element Visible    ${DOB_INPUT}
    Clear Element Text           ${DOB_INPUT}
    Input Text                   ${DOB_INPUT}    ${dob}
    Wait For Page Ready    

Providing Random Talent Details in Vms
    Fill Basic Details using Faker    ${FIRSTNAME_INPUT}    ${LASTNAME_INPUT}    ${PHONE_INPUT}    ${ADDRESS_INPUT}    ${CITY_INPUT}    ${ZIP_INPUT}    ${SUMMARY_INPUT}    ${DOB_INPUT}

Input State For Talent in Vms
    [Arguments]    ${STATE}
    Wait For Page Ready
    Wait Till Element Visible    ${STATE_DROPDOWN}
    Click Element Safely                  ${STATE_DROPDOWN}
    Wait For Page Ready
    Wait Till Element Visible   ${STATE_OPTIONS}
    Click Element Safely        xpath://ul[contains(@class,'k-list-ul')]//li//span[normalize-space()='${STATE}']
    Wait For Page Ready
    Save Value    TALENT.STATE    ${STATE}

Input yearsOfExperience For Talent in Vms
    [Arguments]    ${yoe}
    Wait For Page Ready    
    Wait Till Element Visible        ${YOE_INPUT}    50 sec
    Input Text Safely        ${YOE_INPUT}    ${yoe}
    Wait For Page Ready    

Upload License Test Document For Talent in Vms
    Wait For Page Ready
    Scroll To View Element      ${LICENSE_UPLOAD}
    ${file_input}=    Set Variable    ${LICENSE_UPLOAD}
    Choose File    ${file_input}    /home/costrategix/PycharmProjects/DefinityRj/testdata/uploads/testpdf.pdf
    Wait For Page Ready    

Upload Resume Test Document For Talent in Vms
    Wait For Page Ready
    Scroll To View Element      ${RESUME_UPLOAD}
    ${file_input}=    Set Variable    ${RESUME_UPLOAD}
    Choose File    ${file_input}    /home/costrategix/PycharmProjects/DefinityRj/testdata/uploads/testpdf.pdf
    Wait For Page Ready    

Navigate to Step2 For Talent in Vms
    Wait For Page Ready
    Wait Till Element Enabled    ${STEP2_BUTTON}
    Click Element Safely    ${STEP2_BUTTON}
    Wait For Page Ready

Save Talent Details
    Sleep    2 sec
    Wait Until Element Is Visible    ${save_btn}    50 sec
    Wait Until Element Is Enabled    ${save_btn}    50 sec
    Click Button    ${save_btn}
    Sleep    5 sec

