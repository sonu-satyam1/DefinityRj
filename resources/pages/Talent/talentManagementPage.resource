*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Library     String



*** Variables ***
${TALENT_MGMT_HEADER}        //h1[normalize-space()='Talent Management']
${TALENT_MANAGEMENT_TABS}    //ul[contains(@class,'k-tabstrip-items')]
${SEARCH_BOX}                //label[normalize-space()='Search']/preceding::input[1]
${HEADER_TITLES}             //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                //table[contains(@class,'k-grid-table')]//tbody//tr
${NO_RECORDS_TEXT}           No records available
${TALENT_STATUS_DETAILS_PAGE_XPATH}    //div[@class='d-flex']//span[contains(@class,'status-chips')]
${SHOW_COMPLETED_XPATH}      //span[@role='switch' and @id='Show Completed Placements']


*** Keywords ***
Verify Talent Management Page Title
    Verify Page Title    Talent Management
    

Switch to Specified tab in Talent Management Page
    [Arguments]    ${tab}
    Wait Until Page Ready
    Sleep    5s
    Click Element Safely        ${TALENT_MANAGEMENT_TABS}//li[.//span[normalize-space()='${tab}']]
    Wait Until Page Ready

Select Specified Talent From List
    [Arguments]    ${talent_name}
    Search And Select First Result By Column    ${SEARCH_BOX}    ${talent_name}    ${HEADER_TITLES}    Talent Name    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait Until Page Ready

enable toggle show completed
    Wait Until Page Ready
    Wait Till Element Visible    ${SHOW_COMPLETED_XPATH} 
    Scroll Element Into View     ${SHOW_COMPLETED_XPATH} 
    Wait Until Page Ready
    Sleep    2s
    Click Element Safely         ${SHOW_COMPLETED_XPATH} 
    Wait Until Page Ready
    

validate talent status
    [Arguments]    @{expected_talent_statuses}
    Wait Until Page Ready
    Wait Till Element Visible    ${TALENT_STATUS_DETAILS_PAGE_XPATH}
    ${actual_talent_status}=    Get Text    ${TALENT_STATUS_DETAILS_PAGE_XPATH}
    ${actual_talent_status}=    Strip String    ${actual_talent_status}
    Log    Talent Status Captured: ${actual_talent_status}
    Log    Expected Status Options: @{expected_talent_statuses}
    List Should Contain Value    ${expected_talent_statuses}    ${actual_talent_status}
    

