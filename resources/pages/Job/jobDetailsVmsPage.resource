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
${TALENT_SEARCH}                   xpath://div[contains(@class,"k-tabstrip")]//div[contains(@class,"k-tabstrip-content") and contains(@class,"k-active")]//span[label[normalize-space()="Search"]]/input
${SEARCH_RESULTS_ROWS}             //table[contains(@class,"k-grid-table")]//tbody//tr
${TALENT_TABLE_HEADERS}            xpath://table[contains(@class,"k-grid-header-table")]//thead//th//span[contains(@class,"k-column-title")]
${NO_RECORDS}                      No records available
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

Search For Created Talent in Vms
    [Arguments]    ${talentName}
    Wait For Page Ready
    Scroll To View Element    ${TALENT_SEARCH}
    Scroll To View Element    ${SEARCH_RESULTS_ROWS}
    Search And Select First Result By Column    ${TALENT_SEARCH}    ${talentName}    ${TALENT_TABLE_HEADERS}    Talent    ${SEARCH_RESULTS_ROWS}    ${NO_RECORDS}
    Wait For Page Ready