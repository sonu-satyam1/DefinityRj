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
    Verify Table Has Column    Job Details
    Show All Columns From Menu Filter
    Verify Table Has Column    Shift
    Enable Column From Filter Menu    Hiring Manager
    Verify Table Has Column    Hiring Manager
    ${index}=    Get Grid Column Index   Cost Center
    Log    ${index}


    
