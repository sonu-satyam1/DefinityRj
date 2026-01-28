*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Library    DateTime
Library    String
Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource

*** Variables ***
${ADD_LOCATION_BTN}                xpath://button[.//span[normalize-space()='Add Location']]
${ADD_LOCATION_WINDOW_TITLE}       xpath://div[contains(@class,'k-dialog-titlebar')]//span[contains(@class,'k-dialog-title')]
${LOCATION_NAME_INPUT}             xpath://label[normalize-space()='Location Name']/preceding-sibling::input
${LOCATION_CODE_INPUT}             xpath://label[normalize-space()='Location Code']/preceding-sibling::input
${ADDRESS_INPUT}                   xpath://label[normalize-space()='Address 1']/preceding-sibling::input
${CITY_INPUT}                      xpath://label[normalize-space()='City']/preceding-sibling::input
${ZIP_INPUT}                       xpath://label[normalize-space()='Zip Code']/preceding-sibling::input
${COUNTRY_INPUT}                   xpath://label[normalize-space()='County']/preceding-sibling::input
${MARKET_DROPDOWN}                 xpath://label[normalize-space(text())='Market']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${MARKET_OPTIONS_LOCATOR}          xpath://ul[@role='listbox']//span[@class='k-list-item-text']
${STATE_DROPDOWN}                  xpath://label[normalize-space()='State']/parent::span[contains(@class,'k-floating-label-container')]//button
${STATE_OPTIONS}                   xpath://ul[contains(@class,'k-list-ul')]//li
${RATE_SETTINGS_SECTION}           xpath://span[normalize-space()='Rate Settings']
${OT_DROPDOWN}                     xpath://label[normalize-space()='Overtime Template']/parent::span[contains(@class,'k-floating-label-container')]//button
${OT_OPTIONS}                      xpath://ul[contains(@class,'k-list-ul')]//li
${RATE_CARD_TEMP_DROPDOWN}         xpath://label[normalize-space()='Rate Card Template']/parent::span[contains(@class,'k-floating-label-container')]//button
${RATE_CARD_TEMP_OPTIONS}          xpath://ul[contains(@class,'k-list-ul')]//li
${SAVE_LOCATION}                   xpath://button[.//span[normalize-space()='ADD LOCATION']]

*** Keywords ***
Verify Location Administration Page Title
    Verify Page Title    Location Administration

Verify Add Location Window Title
    Wait Till Element Visible    ${ADD_LOCATION_WINDOW_TITLE}
    ${title}=    Get Text            xpath=//span[contains(@class,'k-dialog-title')]
    Should Contain    ${title}    Add Location

Select Add Location Button
    Wait For Page Ready
    Wait Till Element Visible    ${ADD_LOCATION_BTN}
    Click Element Safely    ${ADD_LOCATION_BTN}
    Wait For Page Ready
    Verify Add Location Window Title

Input Uniq Location Name
    Wait Till Element Visible    ${LOCATION_NAME_INPUT}
    ${location}=    Generate And Store Global Unique Name    TestLocation    APPROVAL_LOCATION_NAME
    Input Text Safely    ${LOCATION_NAME_INPUT}    ${location}

Input Location Code
    [Arguments]    ${code}
    Wait For Page Ready   
    Wait Till Element Visible     ${LOCATION_CODE_INPUT}
    Input Text Safely    ${LOCATION_CODE_INPUT}    ${code}
    Sleep    0.5s

Providing Random Address Details
    Fill Address Details Using Faker    ${ADDRESS_INPUT}    ${CITY_INPUT}    ${ZIP_INPUT}    ${COUNTRY_INPUT}    ${LOCATION_CODE_INPUT}


Select Approval Location Group
    [Arguments]    ${group}
    Wait For Page Ready
    Sleep    1s
    From Dropdown Verify or Select an Option    ${MARKET_DROPDOWN}    ${MARKET_OPTIONS_LOCATOR}    ${group}    select
    Wait For Page Ready

Input State for Location Creation
    [Arguments]    ${STATE}
    Wait For Page Ready
    Wait Till Element Visible    ${STATE_DROPDOWN}
    Scroll To View Element    ${STATE_DROPDOWN}
    Click Element Safely                  ${STATE_DROPDOWN}
    Wait For Page Ready
    Wait Till Element Visible   ${STATE_OPTIONS}
    Click Element Safely        xpath://ul[contains(@class,'k-list-ul')]//li//span[normalize-space()='${STATE}']
    Wait For Page Ready
    RuntimeData.Update Object Field    ADDRESS_DETAILS    STATE    ${STATE}

#${firstName}=    Get Runtime Field inside Object    TALENT    FIRST_NAME
#${ssn}=    RuntimeData.Get Value    TALENT_SSN
#    RuntimeData.Update Object Field    TALENT    SSN    ${ssn}

Select Specified OverTime Template
    [Arguments]    ${ot}
    Sleep    0.5s
    Wait For Page Ready
    Scroll To View Element    ${OT_DROPDOWN}
    Wait Till Element Visible    ${OT_DROPDOWN}
    From Dropdown Verify or Select an Option    ${OT_DROPDOWN}    ${OT_OPTIONS}    ${ot}    select
    Wait For Page Ready
    Sleep    0.5s

Select Specified Rate Card Template
    [Arguments]    ${rateCard}
    Sleep    0.5s
    Wait For Page Ready
    Scroll To View Element    ${RATE_CARD_TEMP_DROPDOWN}
    Wait Till Element Visible    ${RATE_CARD_TEMP_DROPDOWN}
    From Dropdown Verify or Select an Option    ${RATE_CARD_TEMP_DROPDOWN}    ${RATE_CARD_TEMP_OPTIONS}    ${rateCard}    select
    Wait For Page Ready
    Sleep    0.5s
    
Save new Location
    Wait For Page Ready    
    Wait Till Element Enabled        ${SAVE_LOCATION}
    Click Element Safely    ${SAVE_LOCATION}
    Wait For Page Ready    