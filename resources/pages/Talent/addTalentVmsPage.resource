*** Settings ***
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource
Library    ../../../libs/RuntimeData.py
Library    DateTime
Library    String
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
${LICENSE_UPLOAD}         xpath://h4[normalize-space()='Upload License / Identification']/following::input[@type='file' and contains(@class,'k-hidden')][1]
${RESUME_UPLOAD}          xpath://h4[normalize-space()='Upload Resume / References']/following::input[@type='file' and contains(@class,'k-hidden')][1]
${STEP2_BUTTON}           xpath://button[.//span[text()='STEP 2']]
${DOB_CALENDAR_ICON}      xpath://button[@aria-label='Choose date']
${CAL_LOCATOR}            xpath://div[contains(@class,'MuiDateCalendar-root')]
${CAL_YEAR_DROPDOWN}      xpath://button[contains(@class,'MuiPickersCalendarHeader-switchViewButton')]
${CAL_CURR_MON_YEAR}      xpath://div[contains(@class,'MuiPickersCalendarHeader-label')]
${CAL_PREVIOUS_MONTH_BTN}      xpath://button[@aria-label='Previous month']
${CAL_NEXT_MONTH_BTN}          xpath://button[@aria-label='Next month']
${STEP3_BTN}                   xpath://button[.//span[text()='STEP 3']]
${SAVE_SUBMIT_BTN}             xpath://button[normalize-space(.//span/text())='SAVE & SUBMIT']




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



Open DOB Picker
    Wait For Page Ready
    Wait Till Element Visible    ${DOB_CALENDAR_ICON}
    Click Element Safely    ${DOB_CALENDAR_ICON}
    Wait Until Element Is Visible    ${CAL_LOCATOR}

Select Provided Month
    [Arguments]    ${target_month}

    ${MAX_TRIES}=    Set Variable    24

    FOR    ${i}    IN RANGE    ${MAX_TRIES}
        Wait Till Element Visible    ${CAL_CURR_MON_YEAR}
        ${label}=    Get Text    ${CAL_CURR_MON_YEAR}
        ${current_month}=    Convert Month Label To Number    ${label}

        IF    ${current_month} == ${target_month}
            Exit For Loop
        ELSE IF    ${current_month} > ${target_month}
            Wait Till Element Visible    ${CAL_PREVIOUS_MONTH_BTN}
            Click Element Safely    ${CAL_PREVIOUS_MONTH_BTN}
        ELSE
            Wait Till Element Visible    ${CAL_NEXT_MONTH_BTN}
            Click Element Safely    ${CAL_NEXT_MONTH_BTN}
        END

        Sleep    0.3
    END


Convert Month Label To Number
    [Arguments]    ${label}
    ${month_text}=    Split String    ${label}    ${SPACE}
    ${month}=    Set Variable    ${month_text}[0]
    ${month_l}=    Convert To Lower Case    ${month}

    ${months}=    Create List
    ...    january    february    march    april    may    june
    ...    july    august    september    october    november    december

    ${index}=    Get Index From List    ${months}    ${month_l}
    ${month_no}=    Evaluate    ${index} + 1
    RETURN    ${month_no}

Choose DOB From Calendar in Vms
    [Arguments]    ${dob}

    ${month}=    Get Substring    ${dob}    0    2
    ${day}=      Get Substring    ${dob}    3    5
    ${year}=     Get Substring    ${dob}    6    10

    ${month}=    Convert To Integer    ${month}
    ${day}=      Convert To Integer    ${day}
    Open DOB Picker
    # Open year selection
    Wait Till Element Visible    ${CAL_YEAR_DROPDOWN}
    Click Element Safely    ${CAL_YEAR_DROPDOWN}

    # Pick year
    Wait Till Element Visible        xpath=//button[normalize-space()='${year}']
    Click Element Safely    xpath=//button[normalize-space()='${year}']

    # Go to correct month
    Select provided Month    ${month}

    # Pick day (enabled only)
    Wait Till Element Visible
    ...    xpath=//button[@role='gridcell' and not(@disabled) and normalize-space()='${day}']
    Click Element Safely
    ...    xpath=//button[@role='gridcell' and not(@disabled) and normalize-space()='${day}']



Providing Random Talent Details in Vms
    Fill Basic Details using Faker    ${FIRSTNAME_INPUT}    ${LASTNAME_INPUT}    ${PHONE_INPUT}    ${ADDRESS_INPUT}    ${CITY_INPUT}    ${ZIP_INPUT}    ${SUMMARY_INPUT}

Input State For Talent in Vms
    [Arguments]    ${STATE}
    Wait For Page Ready
    Wait Till Element Visible    ${STATE_DROPDOWN}
    Click Element Safely                  ${STATE_DROPDOWN}
    Wait For Page Ready
    Wait Till Element Visible   ${STATE_OPTIONS}
    Click Element Safely        xpath://ul[contains(@class,'k-list-ul')]//li//span[normalize-space()='${STATE}']
    Wait For Page Ready
    RuntimeData.Update Object Field    TALENT    STATE    ${STATE}


Input yearsOfExperience For Talent in Vms
    [Arguments]    ${yoe}
    Wait For Page Ready    
    Wait Till Element Visible        ${YOE_INPUT}    50 sec
    Input Text Safely        ${YOE_INPUT}    ${yoe}
    Wait For Page Ready

Upload License Test Document For Talent in Vms
    Wait For Page Ready
    ${file_input}=    Set Variable    ${LICENSE_UPLOAD}
    Choose File    ${file_input}    ${EXECDIR}/testdata/uploads/testpdf.pdf
    Wait For Page Ready    

Upload Resume Test Document For Talent in Vms
    Wait For Page Ready
    ${file_input}=    Set Variable    ${RESUME_UPLOAD}
    Choose File    ${file_input}    ${EXECDIR}/testdata/uploads/testpdf.pdf
    Wait For Page Ready    

Navigate to Step2 For Talent in Vms
    Wait For Page Ready
    Wait Till Element Enabled    ${STEP2_BUTTON}
    Click Element Safely    ${STEP2_BUTTON}
    Wait For Page Ready

Navigate to Step3 and Save & Submit Talent Details in Vms
    Wait For Page Ready    
    Wait Till Element Enabled    ${STEP3_BTN}
    Click Element Safely    ${STEP3_BTN}
    Wait For Page Ready
    Wait Until Element Is Enabled    ${SAVE_SUBMIT_BTN}
    Click Element Safely        ${SAVE_SUBMIT_BTN}
    Wait For Page Ready

