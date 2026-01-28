*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${JOB_TYPE_DROPDOWN_LOCATOR}             xpath://label[normalize-space(text())='Job Type']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${JOB_TYPE_OPTIONS_TEXT_LOCATOR}         xpath://ul[@id='contractTypelist']//li//span[@class='k-list-item-text']
${HIRING_MANAGER_DROPDOWN_LOCATOR}       xpath://label[normalize-space(text())='Hiring Manager']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${HIRING_MANAGER_OPTIONS_LOCATOR}        xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${LOCATION_DROPDOWN_LOCATOR}             xpath://label[normalize-space(text())='Location']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${LOCATION_OPTIONS_LOCATOR}              xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${DEPARTMENT_DROPDOWN_LOCATOR}           xpath://label[normalize-space(text())='Department']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${DEPARTMENT_OPTIONS_LOCATOR}            xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${SKILL_DROPDOWN_LOCATOR}                xpath://label[normalize-space(text())='Skill']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${SKILL_OPTIONS_LOCATOR}                 xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${SHIFT_DROPDOWN_LOCATOR}                xpath://label[normalize-space(text())='Shift']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${SHIFT_OPTIONS_LOCATOR}                 xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${NO_OF_POSITIONS_INPUT_TXT}             xpath://input[@name='noOfPosition']
${VENDOR_HIRING_PROCESS_LOCATOR}         xpath://input[@id='vendorHiringProcess']
${EARLIEST_DATE_CALENDAR_ICON}           xpath:(//div[@class='d-flex flex-wrap']//div[@class='MuiFormControl-root MuiTextField-root css-1eeu2ag'])[1]//button
${CALENDAR_LOCATOR}                      xpath://div[contains(@class,'MuiDateCalendar-root')]
${EARLIEST_DATE_INPUT_TXT}               xpath://input[@name='earliestStartDate']
${MINI_WK_DUR_INPUT_TXT}                 xpath://input[@id='minimumWeeksDuration']
${EXPECTED_WKLY_SHIFTS_INPUT_TXT}        xpath://input[@id='expectedWeeklyShifts']
${HOURS_PER_SHIFT_INPUT_TXT}             xpath://input[@id='hoursPerShift']
${YEARS_OF_EXP_INPUT_TXT}                xpath://input[@id='experience']
${PAY_PACKAGE_TAB}                       xpath://form//ul[@role='tablist']//li[.//span[starts-with(normalize-space(.), 'Pay Package')]]
${REG_RATE_INPUT_TXT}                    xpath://input[@id='regularRate']
${FIRST_CRED_DROPDOWN}                   xpath:(//table[@class='k-table k-grid-table k-table-md']//tr)[1]//td[@class='no-ellipsis']//button
${CRED_REQ_OPTIONS}                      xpath://ul[contains(@class,'k-list-ul')]//li//span[contains(@class,'k-list-item-text')]
${EXPEDITED_OPTION}                      xpath://section/ul//li[text()='Expedited']
${SUBMIT_BUTTON}                         xpath://button[@type='submit']/span[text()='Submit']
${JOB_SUBMISSION_WINDOW}                 xpath://div[@class='k-window k-dialog']
${JOB_SUBMISSION_WINDOW_CLOSE_BUTTON}    xpath://div[@class='k-window k-dialog']//button[@type='button']/span[text()='CLOSE']
${JOB_STATUS}                            xpath://div[contains(@class,'job-id-section-title')]//span[contains(@class,'status-chips-wrapper')]
*** Keywords ***
Verify Create a Job Order Page Title
    Verify Page Title    Create a Job Order

Verify Rapid Contract Job Type is Present
    From Dropdown Verify or Select an Option    ${JOB_TYPE_DROPDOWN_LOCATOR}    ${JOB_TYPE_OPTIONS_TEXT_LOCATOR}    Rapid Contract    verify

Select Rapid Contract Job Type
    Wait For Page Ready
    Sleep    1s
    From Dropdown Verify or Select an Option    ${JOB_TYPE_DROPDOWN_LOCATOR}    ${JOB_TYPE_OPTIONS_TEXT_LOCATOR}    Rapid Contract    select
    Wait For Page Ready

Select Standard Contract Job Type
    Wait For Page Ready
    Sleep    1s
    From Dropdown Verify or Select an Option    ${JOB_TYPE_DROPDOWN_LOCATOR}    ${JOB_TYPE_OPTIONS_TEXT_LOCATOR}    Standard Contract    select
    Wait For Page Ready

Select Specified Hiring Manager
    [Arguments]    ${hiringManager}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${HIRING_MANAGER_DROPDOWN_LOCATOR}
    From Dropdown Verify or Select an Option    ${HIRING_MANAGER_DROPDOWN_LOCATOR}    ${HIRING_MANAGER_OPTIONS_LOCATOR}    ${hiringManager}    select
    Wait For Page Ready

Select Specified Location
    [Arguments]    ${location}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${LOCATION_DROPDOWN_LOCATOR}
    From Dropdown Verify or Select an Option    ${LOCATION_DROPDOWN_LOCATOR}    ${LOCATION_OPTIONS_LOCATOR}    ${location}    select
    Wait For Page Ready
    Sleep    0.5s

Select Specified Department
    [Arguments]    ${department}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${DEPARTMENT_DROPDOWN_LOCATOR}
    From Dropdown Verify or Select an Option    ${DEPARTMENT_DROPDOWN_LOCATOR}    ${DEPARTMENT_OPTIONS_LOCATOR}    ${department}    select
    Wait For Page Ready
    Sleep    0.5s

Select Specified Skill
    [Arguments]    ${skill}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${SKILL_DROPDOWN_LOCATOR}
    From Dropdown Verify or Select an Option    ${SKILL_DROPDOWN_LOCATOR}    ${SKILL_OPTIONS_LOCATOR}    ${skill}    select
    Wait For Page Ready
    Sleep    0.5s

Select Specified Shift
    [Arguments]    ${shift}
    Wait For Page Ready
    Sleep    2s
    Wait Till Element Visible    ${SHIFT_DROPDOWN_LOCATOR}    80s
    From Dropdown Verify or Select an Option    ${SHIFT_DROPDOWN_LOCATOR}    ${SHIFT_OPTIONS_LOCATOR}    ${shift}    select
    Wait For Page Ready
    Sleep    0.5s

Select Specified Shift in Create Job From Template
    [Arguments]    ${shift}
    Wait For Page Ready
    Sleep    3s
    Wait Till Element Visible    ${SHIFT_DROPDOWN_LOCATOR}    80s
    From Dropdown Verify or Select an Option    ${SHIFT_DROPDOWN_LOCATOR}    ${SHIFT_OPTIONS_LOCATOR}    ${shift}    select
    Wait For Page Ready
    Sleep    0.5s
    
Provide Num of Positions
    [Arguments]    ${positions}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible        ${NO_OF_POSITIONS_INPUT_TXT}    50 sec
    Click Element Safely        ${NO_OF_POSITIONS_INPUT_TXT}
    SeleniumLibrary.Press Keys       ${NO_OF_POSITIONS_INPUT_TXT}    CTRL+A    BACKSPACE
    Input Text Safely        ${NO_OF_POSITIONS_INPUT_TXT}    ${positions}
    Wait For Page Ready
    Sleep    0.5s

Verify Vendor Hiring Process is Disabled for Rapid Contract Type
    Scroll To View Element        ${VENDOR_HIRING_PROCESS_LOCATOR}
    Wait Till Element Disabled        ${VENDOR_HIRING_PROCESS_LOCATOR}

Select Earliest Start Date as Next Day
    Sleep    0.5s
    # Step 1 — Calculate tomorrow's day number
    ${tomorrow}=    Evaluate    (datetime.date.today() + datetime.timedelta(days=1)).day    modules=datetime
    Log    Tomorrow's day: ${tomorrow}
    # Step 2 — Open the date picker
    Wait For Page Ready    
    Scroll To View Element    ${EARLIEST_DATE_CALENDAR_ICON}    80s
    Wait Till Element Visible    ${EARLIEST_DATE_CALENDAR_ICON}
    Wait Till Element Enabled    ${EARLIEST_DATE_CALENDAR_ICON}
    Click Element Safely    ${EARLIEST_DATE_CALENDAR_ICON}
    Wait For Page Ready
    Sleep    0.5s
    # Step 3 — Select tomorrow's date
    Wait Till Element Visible    ${CALENDAR_LOCATOR}
    Click Element    ${CALENDAR_LOCATOR}//button[normalize-space(text())='${tomorrow}']
    # Optional — Confirm the date is selected
    ${selected}=    SeleniumLibrary.Get Value        xpath=//input[@name='earliestStartDate']
    Log    Selected date is: ${selected}
    Wait For Page Ready
    Sleep    0.5s

Provide Minimum Week Duration
    [Arguments]    ${minWkDur}
    Sleep    0.5s
    Scroll To View Element        ${MINI_WK_DUR_INPUT_TXT}    50 sec
    Click Element Safely        ${MINI_WK_DUR_INPUT_TXT}
    SeleniumLibrary.Press Keys       ${MINI_WK_DUR_INPUT_TXT}    CTRL+A    BACKSPACE
    Input Text Safely        ${MINI_WK_DUR_INPUT_TXT}    ${minWkDur}
    Wait For Page Ready
    Sleep    0.5s

Provide Expected Weekly Shift
    [Arguments]    ${expWkSh}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${EXPECTED_WKLY_SHIFTS_INPUT_TXT}
    Scroll To View Element        ${EXPECTED_WKLY_SHIFTS_INPUT_TXT}    50 sec
    Click Element Safely        ${EXPECTED_WKLY_SHIFTS_INPUT_TXT}
    SeleniumLibrary.Press Keys       ${EXPECTED_WKLY_SHIFTS_INPUT_TXT}    CTRL+A    BACKSPACE
    Input Text Safely        ${EXPECTED_WKLY_SHIFTS_INPUT_TXT}    ${expWkSh}
    Wait For Page Ready
    Sleep    0.5s

Provide Hours Per Shift
    [Arguments]    ${hrsPerSh}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${HOURS_PER_SHIFT_INPUT_TXT}
    Scroll To View Element        ${HOURS_PER_SHIFT_INPUT_TXT}    50 sec
    Click Element Safely        ${HOURS_PER_SHIFT_INPUT_TXT}
    SeleniumLibrary.Press Keys       ${HOURS_PER_SHIFT_INPUT_TXT}    CTRL+A    BACKSPACE
    Input Text Safely        ${HOURS_PER_SHIFT_INPUT_TXT}    ${hrsPerSh}
    Wait For Page Ready
    Press Keys    ${YEARS_OF_EXP_INPUT_TXT}    TAB
    Sleep    0.5s

Provide Years of Relevant Experience
    [Arguments]    ${exp}
    Sleep    0.5s
    Wait For Page Ready
    Wait Till Element Visible    ${YEARS_OF_EXP_INPUT_TXT}
    Scroll To View Element    ${YEARS_OF_EXP_INPUT_TXT}    50 sec
    Click Element Safely        ${YEARS_OF_EXP_INPUT_TXT}
    SeleniumLibrary.Press Keys       ${YEARS_OF_EXP_INPUT_TXT}    CTRL+A    BACKSPACE
    Input Text Safely        ${YEARS_OF_EXP_INPUT_TXT}    ${exp}
    Wait For Page Ready
    Sleep    0.5s

Switch to Pay Package tab
    Wait For Page Ready
    Sleep    5s
    Wait Till Element Enabled    xpath://form//ul[@role='tablist']//li[.//span[starts-with(normalize-space(.), '${tab}')]]    80s
    Click Element Safely        ${PAY_PACKAGE_TAB}
    Wait For Page Ready
    Sleep    0.5s

Switch to Specified tab in CreateJob
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Wait Till Element Enabled    xpath://form//ul[@role='tablist']//li[.//span[starts-with(normalize-space(.), '${tab}')]]    80s
    Click Element Safely        xpath://form//ul[@role='tablist']//li[.//span[starts-with(normalize-space(.), '${tab}')]]
    Sleep    0.5s
    
Set Regular Rate If Empty
    [Arguments]    ${regRate}
    Sleep    0.5s
    ${locator}=    Set Variable    xpath=//input[@id='regularRate']
    Wait Till Element Visible       ${locator}
    Scroll To View Element    ${locator}
    ${val}=    SeleniumLibrary.Get Value    ${locator}
    Log    Current Regular Rate value: '${val}'

    IF    '${val}' == ''
        Input Text    ${locator}    ${regRate}
        Press Keys    ${locator}    TAB
        Log    Regular Rate set to ${regRate}
    ELSE
        Log    Regular Rate already present: ${val}
    END
    Sleep    0.5s

Select First Credential Value as Optional
    Wait For Page Ready
    Sleep    0.5s
    Wait Till Element Visible    ${FIRST_CRED_DROPDOWN}
    From Dropdown Verify or Select an Option    ${FIRST_CRED_DROPDOWN}    ${CRED_REQ_OPTIONS}    Optional    select
    Wait For Page Ready
    Sleep    0.5s

Select Expedited Option From Vendor tab
    Wait For Page Ready
    Sleep    0.5s
    Wait Till Element Visible    ${EXPEDITED_OPTION}
    Click Element Safely    ${EXPEDITED_OPTION}
    Wait For Page Ready
    Sleep    0.5s

Submit Job Details
    Wait For Page Ready
    Sleep    0.5s
    Wait Till Element Visible    ${SUBMIT_BUTTON}
    Click Element Safely    ${SUBMIT_BUTTON}
    Sleep    0.5s

Close Submission window
    Wait For Page Ready
    Sleep    0.5s
    Wait Till Element Visible        ${JOB_SUBMISSION_WINDOW}    50s
    Click Element Safely        ${JOB_SUBMISSION_WINDOW_CLOSE_BUTTON}
    Wait For Page Ready
    Sleep    0.5s

