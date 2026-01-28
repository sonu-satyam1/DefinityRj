*** Settings ***
Library    String
Library    ../../../libs/RuntimeData.py
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/Welcome/welcomePage.resource
Resource    ../../../resources/pages/Job/createJobPage.resource
Resource    ../../../resources/pages/Job/jobDetailsPage.resource
Resource    ../../../resources/variables/jobEntities.resource
Resource    ../../../resources/pages/Job/jobOrderAdministrationListPage.resource


Variables   ../../../resources/variables/environment/qa2.py

Test Teardown    Close Browser Safely

*** Test Cases ***
Validate Job Creation With Job Type as Rapid Contract Using Normal Flow
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Add New Job
    Verify Create a Job Order Page Title
    Select Rapid Contract Job Type
    Select Specified Hiring Manager    ${HIRING_MANAGER}
    Select Specified Location    ${LOCATION}
    Select Specified Department    ${DEPARTMENT}
    Select Specified Skill    ${SKILL}
    Provide Num of Positions    ${NO_OF_POSITIONS}
    Verify Vendor Hiring Process is Disabled for Rapid Contract Type
    Select Earliest Start Date as Next Day
    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
    Select Specified Shift    ${SHIFT}
    Provide Minimum Week Duration    ${MINI_WK_DUR}
    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
    Switch to Specified tab in CreateJob    Pay Package
    Verify Current Tab Is Active    Pay Package
    Set Regular Rate If Empty      ${REGULAR_RATE}
    Switch to Specified tab in CreateJob    Credentials
    Verify Current Tab Is Active    Credentials
    Select First Credential Value as Optional
    Switch to Specified tab in CreateJob    Vendors
    Verify Current Tab Is Active    Vendors
    Select Expedited Option From Vendor tab
    Submit Job Details
    Close Submission window
    Check for Open Job Status
    ${job}=    Store Created Job Name For Rapid Contract    NORMAL_JOB_FLOW_JOB

Validate Job Creation With Job Type as Rapid Contract Using Copy Exists
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Apply Filter for Open Jobs and Job Type    Status    Open
    Open Job Details By Selecting Right Side Panel Header of Selected Random Job
    Select Copy Job Option From Details
    Verify Create a Job Order Page Title
    Select Rapid Contract Job Type
    Select Specified Hiring Manager    ${HIRING_MANAGER}
    Select Specified Location    ${LOCATION}
    Select Specified Department    ${DEPARTMENT}
    Select Specified Skill    ${SKILL}
    Provide Num of Positions    ${NO_OF_POSITIONS}
    Verify Vendor Hiring Process is Disabled for Rapid Contract Type
    Select Earliest Start Date as Next Day
    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
    Select Specified Shift    ${SHIFT}
    Provide Minimum Week Duration    ${MINI_WK_DUR}
    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
    Switch to Specified tab in CreateJob    Pay Package
    Verify Current Tab Is Active    Pay Package
    Set Regular Rate If Empty      ${REGULAR_RATE}
    Switch to Specified tab in CreateJob    Credentials
    Verify Current Tab Is Active    Credentials
    Select First Credential Value as Optional
    Switch to Specified tab in CreateJob    Vendors
    Verify Current Tab Is Active    Vendors
    Select Expedited Option From Vendor tab
    Submit Job Details
    Close Submission window
    Check for Open Job Status
    ${job}=    Store Created Job Name For Rapid Contract    COPY_EXIST_FLOW_JOB

Validate Job Creation With Job Type as Rapid Contract Using Add New Job From Template
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Select Add New Job From Template Option
    Verify Select a Template Window Title
    Select Random Template from LastUsed
    Verify Create a Job Order Page Title
    Select Rapid Contract Job Type
    Select Specified Hiring Manager    ${HIRING_MANAGER}
    Select Specified Location    ${LOCATION}
    Select Specified Department    ${DEPARTMENT}
    Select Specified Skill    ${SKILL}
    Provide Num of Positions    ${NO_OF_POSITIONS}
    Verify Vendor Hiring Process is Disabled for Rapid Contract Type
    Select Earliest Start Date as Next Day
    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
    Select Specified Shift in Create Job From Template    ${SHIFT}
    Provide Minimum Week Duration    ${MINI_WK_DUR}
    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
    Switch to Specified tab in CreateJob    Pay Package
    Verify Current Tab Is Active    Pay Package
    Set Regular Rate If Empty      ${REGULAR_RATE}
    Switch to Specified tab in CreateJob    Credentials
    Verify Current Tab Is Active    Credentials
    Select First Credential Value as Optional
    Switch to Specified tab in CreateJob    Vendors
    Verify Current Tab Is Active    Vendors
    Select Expedited Option From Vendor tab
    Submit Job Details
    Close Submission window
    Check for Open Job Status
    ${job}=    Store Created Job Name For Rapid Contract    FROM_TEMPLATE_FLOW_JOB