*** Settings ***
Library    String
Library    ../../../libs/RuntimeData.py
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/Welcome/welcomePage.resource
Resource    ../../../resources/pages/Job/jobOrderAdministrationListPage.resource


Variables   ../../../resources/variables/environment/qa2.py

Test Teardown    Close Browser Safely

*** Test Cases ***
Validate Bulk Edit for Open Jobs of Rapid Contract
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Apply Filter for Open Jobs and Job Type    Status    Open
    Enable Column From Filter Menu    Job Type
    Apply Filter for Open Jobs and Job Type    Job Type    Rapid Contract
    Select Jobs for Bulk Edit    5
    Update Hot Job Option For Bulk Edit    Add Hot Job Flag
    Submit Bulk Edit Changes
    