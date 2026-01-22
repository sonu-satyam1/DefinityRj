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
${REQ_EXT_BTN}                              xpath://button[.//span[normalize-space()='Request Extension']]
${REQ_EXT_HEADER}                           xpath://div[contains(@class,'k-dialog')]//span[normalize-space()='Request Extension']
${REQ_EXT_COMMENT_BOX}                      xpath://textarea[@name='extensionComment']
${REQ_EXT_SUBMIT_BTN}                       xpath://div[contains(@class,'k-dialog')]//button[@type='submit']
${NO_RECORDS}                      No records available

*** Keywords ***
Verify Talent Name Matches Stored Name in Vms
    Wait For Page Ready
    Wait Till Element Visible    ${JOB_TALENT_HEADER_LOCATOR}
    Sleep    3s
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


Check for Job is Offered Status in Vms
    Wait For Page Ready
    Wait Until Element Is Visible    ${STATUS_TEXT}
    ${actual}=    Get Text    ${STATUS_TEXT}
    ${actual}=    Strip String    ${actual}
    ${actual}=    Convert To Lower Case    ${actual}
    ${expected}=    Set Variable    job is offered
    Log    Status Actual:${actual},Expected:${expected}
    Should Contain    ${actual}    ${expected}

Accept the Offer in Vms
    Wait For Page Ready    
    Wait Till Element Enabled    ${ACCEPT_OFFER_BTN}
    Click Element Safely    ${ACCEPT_OFFER_BTN}
    Sleep    10s
    Wait For Page Ready

Reject the Offer in Vms
    Wait For Page Ready
    Wait Till Element Enabled    ${REJECT_OFFER_BTN}
    Click Element Safely    ${REJECT_OFFER_BTN}
    Sleep    10s
    Wait For Page Ready

Request Extension If Eligible
    ${status_ok}=    Run Keyword And Return Status
    ...    Wait Till Element Visible
    ...    ${STATUS_ON_ASSIGN}

    IF    ${status_ok}
        ${btn_present}=    Run Keyword And Return Status
        ...    Wait Till Element Visible
        ...    ${REQ_EXT_BTN}

        IF    ${btn_present}
            Click Element Safely    ${REQ_EXT_BTN}
            Wait For Page Ready
            Log    Clicked Request Extension button

            # ----- Wait for dialog -----
            Wait Till Element Visible        ${REQ_EXT_HEADER}

            # ----- Enter comments -----
            Wait Till Element Visible    ${REQ_EXT_COMMENT_BOX}
            Input Text Safely       ${REQ_EXT_COMMENT_BOX}    Requesting extension till end of next month. No planned leave.

            # ----- Wait until submit enabled -----
            Wait Until Keyword Succeeds    30s    1s
            ...    Element Should Be Enabled    ${REQ_EXT_SUBMIT_BTN}

            Click Element Safely        ${REQ_EXT_SUBMIT_BTN}
            Sleep    5s
            Wait For Page Ready
            Log    Submitted extension request

        ELSE
            Log    Status is On Assignment but Request Extension button not visible
        END
    ELSE
        Log    Status is not On Assignment — skipping Request Extension
    END

