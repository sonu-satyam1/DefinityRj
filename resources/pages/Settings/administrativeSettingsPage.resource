*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${SKILLS_CREDENTIALS_RATES_HEADER}    xpath://h2[.//span[normalize-space()='Skills, Credentials and Pay Rates']]


*** Keywords ***
Verify Administrative Settings Page Title
    Verify Page Title    Administrative Settings

Select Option from Skills Credentials and Pay Rates
    [Arguments]    ${OPTION}
    Wait For Page Ready
    Wait Till Element Visible    ${SKILLS_CREDENTIALS_RATES_HEADER}
    Click Element Safely    xpath=//h2[.//span[normalize-space()='Skills, Credentials and Pay Rates']]/following-sibling::ul//a[normalize-space()='${OPTION}']
    Wait For Page Ready
