*** Settings ***
Library    String
Library    ../../libs/RuntimeData.py
Resource    ../../resources/pages/Login/loginPage.resource
Resource    ../../resources/pages/Welcome/welcomePage.resource
Resource    ../../resources/pages/Job/createJobPage.resource
Resource    ../../resources/pages/Job/jobDetailsPage.resource
Resource    ../../resources/variables/jobEntities.resource
Resource    ../../resources/pages/Job/jobOrderAdministrationListPage.resource
Resource    ../../resources/pages/LefNavMenu/leftNavigation.resource
Resource    ../../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../../resources/pages/Settings/rateAdministration.resource

Variables   ../../resources/variables/environment/qa2.py

Test Teardown    Close Browser Safely

*** Test Cases ***
Validate Job Creation With Job Type as Rapid Contract
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
    Select Specified Shift    ${SHIFT}
    Provide Minimum Week Duration    ${MINI_WK_DUR}
    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
    Switch to Specified tab    Pay Package
    Verify Current Tab Is Active    Pay Package
    Set Regular Rate If Empty      ${REGULAR_RATE}
    Switch to Specified tab    Credentials
    Verify Current Tab Is Active    Credentials
    Select First Credential Value as Optional
    Switch to Specified tab    Vendors
    Verify Current Tab Is Active    Vendors
    Select Expedited Option From Vendor tab
    Submit Job Details
    Close Submission window
    Check for Open Job Status
    Store Created Job Name


Store All Rates for Created Job
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    ${jobName}=    RuntimeData.Get Value    JOB_NAME
    Select Specified Job From List in Right Side Panel    ${jobName}
    Switch to Specified tab in Details Page    Pay Package
    View Pay Package Rate Details
    Fetch And Store Vendor Expected Weekly Pay And Hours
    ${pay}=    RuntimeData.Get Value    EXPECTED_WEEKLY_PAY
    ${hrs}=    RuntimeData.Get Value    EXPECTED_WEEKLY_HOURS
    Log    Pay=${pay}, Hours=${hrs}
    Validate Expected Weekly Pay And Hours From Shifts
    Store Additional Rates From UI
    Get Overtime Rules

Compare All Job Rates with Rate Template and Ensure Skill Matches Job's Skill
    Login To Portal    HCS    ${HCS}
    Select Navigation Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Rate Administration
    Verify Rate Administration Page Title
    Switch to Specified tab in Rate Administration Page    Rate Cards
    Verify Current Tab Is Active    Rate Cards
    Choose Specified Rate Template from Dropdown list    ${RATE_TEMPLATE_NAME}
    Check Current Vendor is tab is Selected
    ${json}=    Fetch and Format Rates For Specified Skill Name    ${SKILL}    ${REGULAR_RATE}
    Compare Fetched Rates With Stored Provided Job Rates    ${json}

Compare All Job OT Rules with OT Template and Ensure Location Matches Job's Location
    Login To Portal    HCS    ${HCS}
    Select Navigation Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Rate Administration
    Verify Rate Administration Page Title
    Switch to Specified tab in Rate Administration Page    OVERTIME RULES
    Verify Current Tab Is Active    OVERTIME RULES
    Choose Specified OT Rule Template from Dropdown list    ${OT_RULE_TEMPLATE_NAME}
    Switch to Vendor OT Rules
    Verify Specified Location is Present in Specified OT Rule Template    ${LOCATION}
    ${ui_ot}=        Get Overtime Rules From UI As JSON
    ${stored_ot}=    RuntimeData.Get Value    OVERTIME_RULES
    Compare Overtime Rules With Runtime Data    ${ui_ot}    ${stored_ot}

