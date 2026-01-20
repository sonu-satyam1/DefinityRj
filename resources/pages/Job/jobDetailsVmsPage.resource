*** Settings ***
Library     SeleniumLibrary
Library     String
Library    Collections
Library    ../../../libs/RuntimeData.py
Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource


*** Variables ***
${JOB_STATUS}                      xpath://div[contains(@class,'job-id-section-title')]//span[contains(@class,'status-chips-wrapper')]
${JOB_HEADER}                      xpath://h1[contains(@class,'post-login-heading')]
${JOB_DETAILS_TABS}                xpath://ul[contains(@class,'k-tabstrip-items')]
${SUBMIT_TALENT_BUTTON}            xpath://button[.//span[normalize-space()='Submit Talent']]
${SUBMIT_TALENT_WINDOW_TITLE}      xpath://div[@class='k-window k-dialog']//span[text()='Submit Talent']
${SUBMIT_NEW_TALENT_BUTTON}        xpath://button[.//span[normalize-space()='Submit New Talent']]

*** Keywords ***
Verify Job Details Page Title in Vms
    [Arguments]    ${JOB_TITLE}
    Verify Page Title    ${JOB_TITLE}

Check for Open Job Status in Vms
    Wait For Page Ready
    Wait Until Element Is Visible    ${JOB_STATUS}    50s
    ${status}=    Get Text    ${JOB_STATUS}
    Should Be Equal As Strings    ${status}    Open

Switch to Specified tab in Details Page in Vms
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Click Element Safely        ${JOB_DETAILS_TABS}//li[.//span[normalize-space()='${tab}']]
    Wait For Page Ready

Select Submit Talent in Vms
    Wait Till Element Visible    ${SUBMIT_TALENT_BUTTON}
    Click Element Safely    ${SUBMIT_TALENT_BUTTON}
    Wait For Page Ready

Verify Submit Talent Window Title in Vms
    Wait For Page Ready
    Verify Dialog Header Text    Submit Talent

Select Submit Talent New Talent in Vms
    Wait Till Element Visible    ${SUBMIT_NEW_TALENT_BUTTON}
    Click Element Safely    ${SUBMIT_NEW_TALENT_BUTTON}
    Wait For Page Ready

#View Pay Package Rate Details
#    Wait For Page Ready
#    Scroll To View Element    ${VIEW_RATE_DETAILS_BUTTON}
#    Wait Till Element Visible    ${VIEW_RATE_DETAILS_BUTTON}
#    Click Element Safely    ${VIEW_RATE_DETAILS_BUTTON}
#    Wait For Page Ready
#
#Fetch And Store Vendor Expected Weekly Pay And Hours
#    Wait For Page Ready
#    Scroll To View Element    xpath://div[contains(@class,'paypackage-card-header')]//h3[contains(@class,'title')]
#    ${text}=    Get Text    xpath=//div[contains(@class,'paypackage-card-header')]//h3[contains(@class,'title')]
#    Log    Full Pay Text: ${text}
#
#    # Example text: $35.00 Expected Weekly Pay, 35 Hours
#
#    ${pay}=    Evaluate    re.search(r'\\$(\\d+\\.\\d+)', """${text}""").group(1)    re
#    ${hours}=  Evaluate    re.search(r',\\s*(\\d+)\\s*Hours', """${text}""").group(1)    re
#
#    Log    ExpectedWeeklyPay = ${pay}
#    Log    ExpectedWeeklyHours = ${hours}
#
#    RuntimeData.Save Value    EXPECTED_WEEKLY_PAY      ${pay}
#    RuntimeData.Save Value    EXPECTED_WEEKLY_HOURS    ${hours}
#
#Validate Expected Weekly Pay And Hours From Shifts
#    Wait For Page Ready
#    # ---------- HEADER ----------
#    Wait Till Element Visible    ${HEADER_PAY_HOURS}
#    ${header}=    Get Text    ${HEADER_PAY_HOURS}
#    # example: $35.00 Expected Weekly Pay, 35 Hours
#
#    ${pay}=       Fetch From Right    ${header}    $
#    ${pay}=       Fetch From Left     ${pay}       Expected
#    ${pay}=       Convert To Number   ${pay}
#
#    ${hrs}=       Fetch From Right    ${header}    ,
#    ${hrs}=       Fetch From Left     ${hrs}       Hours
#    ${hrs}=       Convert To Integer  ${hrs}
#
#    # ---------- SHIFTS ----------
#    Wait Till Element Visible    ${SHIFT_TEXT}
#    ${shift_txt}=    Get Text    ${SHIFT_TEXT}
#    # example: 5 x 7 Shifts
#
#    ${a}=    Fetch From Left     ${shift_txt}    x
#    ${a}=    Convert To Integer  ${a}
#
#    ${b}=    Fetch From Right    ${shift_txt}    x
#    ${b}=    Fetch From Left     ${b}            Shifts
#    ${b}=    Convert To Integer  ${b}
#
#    # ---------- RATE ----------
#    Wait Till Element Visible    ${REGULAR_RATE_TEXT}
#    ${rate_txt}=    Get Text    ${REGULAR_RATE_TEXT}
#    # example: $1.00 Regular Rate
#
#    ${rate}=    Fetch From Right    ${rate_txt}    $
#    ${rate}=    Fetch From Left     ${rate}        Regular
#    ${rate}=    Convert To Number   ${rate}
#
#    # ---------- CALCULATIONS ----------
#    ${calc_hours}=    Evaluate    ${a} * ${b}
#    ${calc_pay}=      Evaluate    ${a} * ${b} * ${rate}
#
#    # ---------- VALIDATIONS ----------
#    Should Be Equal As Integers    ${calc_hours}    ${hrs}
#    Should Be Equal As Numbers     ${calc_pay}      ${pay}
#
#    Log    Weekly Hours OK: ${calc_hours}
#    Log    Weekly Pay OK: ${calc_pay}
#
#
#Store Additional Rates From UI
#    ${rates}=    Create Dictionary
#
#    @{els}=    Get WebElements
#    ...    xpath=//h3[.//text()='Additional Rates']/following-sibling::div//p
#
#    FOR    ${el}    IN    @{els}
#        ${txt}=    Get Text    ${el}
#        Log    RAW = ${txt}
#
#        # name = text before :
#        ${name}=    Replace String Using Regexp
#        ...    ${txt}
#        ...    ^\\s*([^:]+):.*$
#        ...    \\1
#        ${name}=    Strip String    ${name}
#
#        # value = number after $
#        ${num}=     Replace String Using Regexp
#        ...    ${txt}
#        ...    .*\\$([0-9]+(?:\\.[0-9]+)?).*
#        ...    \\1
#        ${value}=   Convert To Number    ${num}
#
#        Set To Dictionary    ${rates}    ${name}=${value}
#    END
#
#    RuntimeData.Save Value    ADDITIONAL_RATES    ${rates}
#
#
#
#Get Overtime Rules
#    Wait Until Element Is Visible
#    ...    xpath=//h3[normalize-space()='Overtime Rules']/following-sibling::div
#    ...    20s
#
#    @{daily}=    Create List
#    @{weekly}=   Create List
#    @{cons}=     Create List
#
#    &{overtimeRules}=    Create Dictionary
#    ...    Daily=${daily}
#    ...    Weekly=${weekly}
#    ...    Consecutive Days=${cons}
#
#    @{period_divs}=    Get WebElements
#    ...    xpath=//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')]
#
#    ${p_count}=    Get Length    ${period_divs}
#
#    FOR    ${i}    IN RANGE    1    ${p_count + 1}
#
#        ${period}=    Get Text
#        ...    xpath=(//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')])[${i}]/h3
#
#        @{rows}=    Get WebElements
#        ...    xpath=(//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')])[${i}]/table/tbody/tr
#
#        ${r_count}=    Get Length    ${rows}
#
#        FOR    ${j}    IN RANGE    1    ${r_count + 1}
#
#            ${cell1}=    Get Text
#            ...    xpath=(//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')])[${i}]/table/tbody/tr[${j}]/td[1]
#
#            IF    '${cell1}' == '-'
#                CONTINUE
#            END
#
#            ${td_count}=    Get Element Count
#            ...    xpath=(//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')])[${i}]/table/tbody/tr[${j}]/td
#
#            IF    ${td_count} < 2
#                CONTINUE
#            END
#
#            ${cell2}=    Get Text
#            ...    xpath=(//h3[normalize-space()='Overtime Rules']/following-sibling::div/div[contains(@class,'w-50')])[${i}]/table/tbody/tr[${j}]/td[2]
#
#            ${rule}=    Replace String    ${cell1}    For    ${EMPTY}
#            ${rule}=    Strip String    ${rule}
#
#            ${parts}=    Split String    ${cell2}    :
#            ${type}=     Strip String    ${parts}[0]
#            ${rate}=     Convert To Number    ${parts}[1]
#
#            &{r}=    Create Dictionary    rule=${rule}    type=${type}    rate=${rate}
#
#            ${list}=    Get From Dictionary    ${overtimeRules}    ${period}
#            Append To List    ${list}    ${r}
#
#        END
#    END
#
#    Log    ${overtimeRules}
#    RuntimeData.Save Value    OVERTIME_RULES    ${overtimeRules}
#    RETURN    ${overtimeRules}
#
#
