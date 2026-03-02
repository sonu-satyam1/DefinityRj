*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${TALENT_MGMT_HEADER}        //h1[normalize-space()='Talent Management']
${TALENT_MANAGEMENT_TABS}    //ul[contains(@class,'k-tabstrip-items')]
${SEARCH_BOX}                //label[normalize-space()='Search']/preceding::input[1]
${HEADER_TITLES}             //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                //table[contains(@class,'k-grid-table')]//tbody//tr
${NO_RECORDS_TEXT}           No records available
${TALENT_STATUS_DETAILS_PAGE_XPATH}    //div[@class='d-flex']//span[contains(@class,'status-chips')]


*** Keywords ***
Verify Talent Management Page Title
    Verify Page Title    Talent Management
    

Switch to Specified tab in Talent Management Page
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Click Element Safely        ${TALENT_MANAGEMENT_TABS}//li[.//span[normalize-space()='${tab}']]
    Wait For Page Ready

Select Specified Talent From List
    [Arguments]    ${talent_name}
    Search And Select First Result By Column    ${SEARCH_BOX}    ${talent_name}    ${HEADER_TITLES}    Talent Name    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait For Page Ready
    
validate talent status
    [Arguments]    ${expected_talent_status}
    Wait For Page Ready
    Wait Till Element Visible    ${TALENT_STATUS_DETAILS_PAGE_XPATH}
    ${actual_talent_status}=    Get Text       ${TALENT_STATUS_DETAILS_PAGE_XPATH}
    Log    talent Status Captured From Talent Details Page: ${actual_talent_status}
    Log    expected Talent Status Required : ${expected_talent_status}
    Should Be Equal        ${actual_talent_status}    ${expected_talent_status}
    

