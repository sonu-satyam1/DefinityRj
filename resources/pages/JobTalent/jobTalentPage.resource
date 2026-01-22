*** Settings ***
Library     SeleniumLibrary
Library     String
Library    Collections
Library    ../../../libs/RuntimeData.py
Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource


*** Variables ***
${JOB_TALENT_HEADER_LOCATOR}                xpath://h1[contains(@class,'post-login-heading')]
${STATUS_TEXT}                              xpath://h1[contains(@class,'post-login-heading')]/following-sibling::span[contains(@class,'talent-status-chips')]
${ACCEPT_OFFER_BTN}                         xpath://button[.//span[normalize-space()='ACCEPT OFFER']]
${REJECT_OFFER_BTN}                         xpath://button[.//span[normalize-space()='REJECT OFFER']]
${STATUS_ON_ASSIGN}                         xpath://span[contains(@class,'talent-status-chips') and normalize-space()='On Assignment']
${OFR_EXT_BTN}                              xpath://button[.//span[normalize-space()='Offer Extension']]
${CONTRACT_EXT_HEADER}                      xpath://h1[normalize-space()='Contract Extension']
${SEND_FOR_APPROVAL_BTN}                    xpath://button[.//span[normalize-space()='Send for Approval']]
${NO_RECORDS}                      No records available

*** Keywords ***
Verify Talent Name Matches Stored Name in Hcs
    Wait For Page Ready
    Wait Till Element Visible    ${JOB_TALENT_HEADER_LOCATOR}

    ${first}=    RuntimeData.Get Runtime Field Inside Object    TALENT    FIRST_NAME
    ${last}=     RuntimeData.Get Runtime Field Inside Object    TALENT    LAST_NAME
    ${expected}=    Set Variable    ${first} ${last}

    ${actual}=    Get Text Safely    ${JOB_TALENT_HEADER_LOCATOR}

    ${expected}=    Strip String    ${expected}
    ${actual}=      Strip String    ${actual}

    ${expected}=    Convert To Lower Case    ${expected}
    ${actual}=      Convert To Lower Case    ${actual}

    ${expected}=    Evaluate    " ".join($expected.split())
    ${actual}=      Evaluate    " ".join($actual.split())

    Log    Expected: ${expected}
    Log    Actual: ${actual}

    Should Be Equal As Strings    ${actual}    ${expected}


Check for Job is Offered Status in Hcs
    Wait For Page Ready
    Wait Until Element Is Visible    ${STATUS_TEXT}
    ${actual}=    Get Text    ${STATUS_TEXT}
    ${actual}=    Strip String    ${actual}
    ${actual}=    Convert To Lower Case    ${actual}
    ${expected}=    Set Variable    job is offered
    Log    Status Actual:${actual},Expected:${expected}
    Should Contain    ${actual}    ${expected}

Accept the Offer in Hcs
    Wait For Page Ready    
    Wait Till Element Enabled    ${ACCEPT_OFFER_BTN}
    Click Element Safely    ${ACCEPT_OFFER_BTN}
    Sleep    10s
    Wait For Page Ready

Reject the Offer in Hcs
    Wait For Page Ready
    Wait Till Element Enabled    ${REJECT_OFFER_BTN}
    Click Element Safely    ${REJECT_OFFER_BTN}
    Sleep    10s
    Wait For Page Ready

Switch to Specified tab in Hcs
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Click Element Safely        xpath://form//ul[@role='tablist']//li[.//span[starts-with(normalize-space(.), '${tab}')]]


Offer Extension If Eligible in Hcs
    ${status_ok}=    Run Keyword And Return Status
    ...    Wait Till Element Visible
    ...    ${STATUS_ON_ASSIGN}

    IF    ${status_ok}
        ${btn_present}=    Run Keyword And Return Status
        ...    Wait Till Element Visible
        ...    ${OFR_EXT_BTN}

        IF    ${btn_present}
            Click Element Safely    ${OFR_EXT_BTN}
            Wait For Page Ready
            Log    Clicked Offer Extension button

            # ----- Wait for dialog -----
            Wait Till Element Visible        ${CONTRACT_EXT_HEADER}
            Switch to Specified tab in Hcs    Credentials
            Wait For Page Ready
            # ----- Wait until submit enabled -----
            Wait Until Keyword Succeeds    30s    1s
            ...    Element Should Be Enabled    ${SEND_FOR_APPROVAL_BTN}

            Click Element Safely        ${SEND_FOR_APPROVAL_BTN}
            Sleep    5s
            Wait For Page Ready
            Log    Submitted extension request

        ELSE
            Log    Status is On Assignment but Request Extension button not visible
        END
    ELSE
        Log    Status is not On Assignment — skipping Request Extension
    END

