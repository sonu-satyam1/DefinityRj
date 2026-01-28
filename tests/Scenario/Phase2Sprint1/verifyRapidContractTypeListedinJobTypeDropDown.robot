*** Settings ***
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/Welcome/welcomePage.resource
Resource    ../../../resources/pages/Job/createJobPage.resource
Resource    ../../../resources/pages/Job/jobOrderAdministrationListPage.resource

Variables   ../../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Validate Rapid Contract Option listed in JobType DropDown While Creating New Job
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Add New Job
    Verify Create a Job Order Page Title
    Verify Rapid Contract Job Type is Present

Validate Rapid Contract Option listed in JobType DropDown While Creating New Job Using Template
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Select Add New Job From Template Option
    Verify Select a Template Window Title
    Select Random Template from LastUsed
    Verify Create a Job Order Page Title
    Verify Rapid Contract Job Type is Present

Validate Rapid Contract Option listed in JobType DropDown While Creating New Job by Copying Existing Job
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Open Job Details By Selecting Right Side Panel Header of Selected Random Job
    Select Copy Job Option From Details
    Verify Create a Job Order Page Title
    Verify Rapid Contract Job Type is Present
