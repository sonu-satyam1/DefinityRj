*** Settings ***
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/LefNavMenu/leftNavigation.resource
Resource    ../../../resources/pages/Job/jobOrderAdministrationListPage.resource

Variables   ../../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Login To HCS Portal
    Login To Portal    HCS    ${HCS}
    Select Navigation Option    Jobs
    Verify Job Order Administration Page Title
    Click Element    xpath://h1
    Get Column Index By Name    Cost Center
    
