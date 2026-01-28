*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${SKILLS_CREDENTIALS_RATES_HEADER}    xpath://h2[.//span[normalize-space()='Skills, Credentials and Pay Rates']]
${ORG_RULED_RELATIONSHIPS_HEADER}    xpath://h2[.//span[normalize-space()='Organization Rules & Relationships']]
${BUILDING_BLOCKS_HEADER}            xpath://h2[.//span[normalize-space()='Building Blocks']]
*** Keywords ***
Verify Administrative Settings Page Title
    Verify Page Title    Administrative Settings

Select Option from Skills Credentials and Pay Rates
    [Arguments]    ${OPTION}
    Wait For Page Ready
    Wait Till Element Visible    ${SKILLS_CREDENTIALS_RATES_HEADER}
    Click Element Safely    xpath=//h2[.//span[normalize-space()='Skills, Credentials and Pay Rates']]/following-sibling::ul//a[normalize-space()='${OPTION}']
    Wait For Page Ready

Select Option from Organization Rules & Relationships
    [Arguments]    ${OPTION}
    Wait For Page Ready
    Wait Till Element Visible    ${ORG_RULED_RELATIONSHIPS_HEADER}
    Scroll To View Element     xpath=//h2[.//span[normalize-space()='Organization Rules & Relationships']]/following-sibling::ul//li
    Click Element Safely    xpath=//h2[.//span[normalize-space()='Organization Rules & Relationships']]/following-sibling::ul//li//a[normalize-space()='${OPTION}']
    Wait For Page Ready

Select Option from Building Blocks
    [Arguments]    ${OPTION}
    Wait For Page Ready
    Wait Till Element Visible    ${BUILDING_BLOCKS_HEADER}
    Click Element Safely    ${BUILDING_BLOCKS_HEADER}/following-sibling::ul//a[normalize-space()='${OPTION}']
    Wait For Page Ready