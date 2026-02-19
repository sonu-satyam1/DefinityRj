*** Settings ***
Resource    ../../resources/pages/Login/loginPage.resource
Resource    ../../resources/pages/Welcome/welcomePage.resource
Resource    ../../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../../resources/pages/Settings/approvalWorkFlowAdministrationPage.resource
Resource    ../../resources/variables/approvalFlowEntities.resource

Resource    ../../resources/pages/Job/createJobPage.resource
Resource    ../../resources/pages/Job/jobDetailsPage.resource
Resource    ../../resources/pages/Job/jobOrderAdministrationListPage.resource

Resource    ../../resources/pages/Settings/organizationDetailsPage.resource
Resource    ../../resources/pages/Settings/locationAdministrationPage.resource
Resource    ../../resources/pages/Settings/departmentAdministrationPage.resource
Resource    ../../resources/pages/Settings/locationGroupAdministrationPage.resource



Library    ../../libs/RuntimeData.py

Variables   ../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Create a New Location Group for Approval Flow
    Set Test Variable    ${APPROVER_USER}    ${EMPTY}
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Building Blocks    Location Groups
    Verify Location Group Administration Page Title
    Select Add Group Button
    Input Uniq Group Name
    Input Group Code for Group Creation    12345
    Select Market as Level and Placeholder Group as Parent Group for Group Creation
    Save new Group

Create a New Location for Approval Flow
    Set Test Variable    ${APPROVER_USER}    ${EMPTY}
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Building Blocks    Locations
    Verify Location Administration Page Title
    Select Add Location Button
    Input Uniq Location Name
    Providing Random Address Details
    ${group}=    RuntimeData.Get Value    APPROVAL_GROUP_NAME
    Select Approval Location Group    ${group}
    Input State for Location Creation    Florida
    Select Specified OverTime Template    ${AF_OT_RULE_TEMPLATE_NAME}
    Select Specified Rate Card Template    ${AF_RATE_TEMPLATE_NAME}
    Save new Location

Create and map Department with New Location for Approval Flow
    Set Test Variable    ${APPROVER_USER}    ${EMPTY}
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Building Blocks    Departments
    Verify Department Administration Page Title
    Select Add Department Button
    Input Uniq Department Name
    ${location}=    RuntimeData.Get Value    APPROVAL_LOCATION_NAME
    Select Specified Location for Department Creation    ${location}
    Input Uniq CostCenter for Department Creation
    Select Specific Value From SKills Field for Department Creation    ${AF_SKILL}
    Select Specific Value From Shifts Field for Department Creation    ${AF_SHIFT}
    Save new Department

#Verify Creation of New Approval Flow
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Settings
#    Verify Administrative Settings Page Title
#    Select Option from Organization Rules & Relationships    Approval Flows
#    Verify Approval Workflow Administration Page Title
#    Create Approval Workflow
#    Input Uniq Rule Name in WorkFlow Creation
#    Select provided Approver from Approvers List    rajitha p
#    Clear and Select Specific Value From Market Field    ${MARKET}
#    Select Specific Value From Location Field    ${LOCATION}
#    Select Result Cost Center Value For Applied Location
#    Clear and Select Specific Value From Skill Type Field   ${SKILL_TYPE}
#    Select Specific Value From Skills Field    ${SKILL_TYPE}/${SKILL}
#    Select Specific Value From Fill Type    New Orders
#    Click Add For Workflow Creation
#    ${workflow}=    RuntimeData.Get Value    WORKFLOW_RULE_NAME
#    Search and Select for Specified WorkFlow    ${workflow}


#LogIn as NormalUser and Create Job Creation With Approval Flow Entities
#    Set Test Variable    ${APPROVER_USER}    jenkinsamplesmtp@gmail.com
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs    Add New Job
#    Verify Create a Job Order Page Title
#    Select Standard Contract Job Type
#    Select Specified Hiring Manager    ${HIRING_MANAGER}
#    Select Specified Location    ${LOCATION}
#    Select Specified Department    ${DEPARTMENT}
#    Select Specified Skill    ${SKILL}
#    Provide Num of Positions    ${NO_OF_POSITIONS}
#    Select Earliest Start Date as Next Day
#    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
#    Select Specified Shift    ${SHIFT}
#    Provide Minimum Week Duration    ${MINI_WK_DUR}
#    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
#    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
#    Switch to Specified tab in CreateJob    Pay Package
#    Verify Current Tab Is Active    Pay Package
#    Set Regular Rate If Empty      ${REGULAR_RATE}
#    Switch to Specified tab in CreateJob    Credentials
#    Select First Credential Value as Optional
#    Switch to Specified tab in CreateJob    Vendors
#    Verify Current Tab Is Active    Vendors
##    Select Expedited Option From Vendor tab
#    Submit Job Details
#    Close Submission window
#    Check for Pending Approval Job Status
#    ${job}=    Store Created Job Name With Specified Key    APPROVAL_FLOW_JOB_NAME

#Login As Approver and Approve Created Job
#     Set Test Variable    ${APPROVER_USER}    ${EMPTY}
#     Login To Portal    HCS    ${HCS}
#     Click Feature Menu Option    Settings
#     Verify Administrative Settings Page Title
#     Select Option from Building Blocks    Hospital Info
#     Verify Organization Details Page Title
#     Switch to Business rules tab in Organization Details Page
#     Verify Current Tab Is Active    Business rules
#     Verify Or Set Approval Workflow As Sequential
#
#Login As Approver and Approve Created Job
#    Set Test Variable    ${APPROVER_USER}    ${EMPTY}
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    ${jobName}=    RuntimeData.Get Value    APPROVAL_FLOW_JOB_NAME
#    Select Specified Job From List for Pending Approval    ${jobName}
#    Select Approve Request for Approval Flow
#

#LogIn as NormalUser and Create Job Creation With Approval Flow Entities
#    Set Test Variable    ${APPROVER_USER}    jenkinsamplesmtp@gmail.com
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs    Add New Job
#    Verify Create a Job Order Page Title
#    Select Standard Contract Job Type
#    Select Specified Hiring Manager    ${HIRING_MANAGER}
#    Select Specified Location    ${LOCATION}
#    Select Specified Department    ${DEPARTMENT}
#    Select Specified Skill    ${SKILL}
#    Provide Num of Positions    ${NO_OF_POSITIONS}
#    Select Earliest Start Date as Next Day
#    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
#    Select Specified Shift    ${SHIFT}
#    Provide Minimum Week Duration    ${MINI_WK_DUR}
#    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
#    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
#    Switch to Specified tab in CreateJob    Pay Package
#    Verify Current Tab Is Active    Pay Package
#    Set Regular Rate If Empty      ${REGULAR_RATE}
#    Switch to Specified tab in CreateJob    Credentials
#    Select First Credential Value as Optional
#    Switch to Specified tab in CreateJob    Vendors
#    Verify Current Tab Is Active    Vendors
##    Select Expedited Option From Vendor tab
#    Submit Job Details
#    Close Submission window
#    Check for Pending Approval Job Status
#    ${job}=    Store Created Job Name With Specified Key    APPROVAL_FLOW_JOB_NAME

#Login As Approver and Approve Created Job
#     Set Test Variable    ${APPROVER_USER}    ${EMPTY}
#     Login To Portal    HCS    ${HCS}
#     Click Feature Menu Option    Settings
#     Verify Administrative Settings Page Title
#     Select Option from Building Blocks    Hospital Info
#     Verify Organization Details Page Title
#     Switch to Business rules tab in Organization Details Page
#     Verify Current Tab Is Active    Business rules
#     Verify Or Set Approval Workflow As Sequential
#
#Login As Approver and Approve Created Job
#    Set Test Variable    ${APPROVER_USER}    ${EMPTY}
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    ${jobName}=    RuntimeData.Get Value    APPROVAL_FLOW_JOB_NAME
#    Select Specified Job From List for Pending Approval    ${jobName}
#    Select Approve Request for Approval Flow
