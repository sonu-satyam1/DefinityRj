*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${TALENT_MGMT_HEADER}    xpath://h1[normalize-space()='Talent Management']

*** Keywords ***
Verify Talent Management Page Title in Vms
    Verify Page Title    Talent Management
