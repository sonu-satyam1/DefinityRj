*** Settings ***
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/Welcome/welcomePage.resource
Resource    ../../../resources/pages/Dashboard/myDashboardPage.resource
Resource    ../../../resources/pages/Job/jobOrderAdministrationListPage.resource
Resource    ../../../resources/pages/Talent/talentManagementPage.resource
Resource    ../../../resources/pages/Timecards/timecardManagementPage.resource
Resource    ../../../resources/pages/Compliance/complianceManagementPage.resource
Resource    ../../../resources/pages/Invoice/invoiceAdministrationPage.resource
Resource    ../../../resources/pages/Analytics/analyticsPage.resource
Resource    ../../../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../../../resources/pages/Job/createJobPage.resource


Variables   ../../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Verify Welcome Title
    Login To Portal    HCS    ${HCS}
    Verify Page Header And Title

Verify Navigation of Dashboard Page from Welcome Page
     Login To Portal    HCS    ${HCS}
     Click Feature Menu Option    Dashboard
     Verify Dashboard Page Title

Verify Navigation of Jobs Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title

Verify Navigation of Talent Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Talent
    Verify Talent Management Page Title

Verify Navigation of Timecards Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title

Verify Navigation of Compliance Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    COMPLIANCE
    Verify Compliance Management Page Title

Verify Navigation of Invoices Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    INVOICES
    Verify Invoice Administration Page Title

Verify Navigation of Analytics Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    ANALYTICS
    Verify Analytics Page Title

Verify Navigation of Settings Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title

Verify Navigation of Create New Job page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Add New Job
    Verify Create a Job Order Page Title

Verify Navigation of Open Positions tab in Job Order Administration Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Open Positions
    Verify Current Tab Is Active    Open Positions

Verify Navigation of All Job Requisitions tab in Job Order Administration Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    All Job Requisitions
    Verify Current Tab Is Active    All Job Requisitions

Verify Navigation of Pending Approval and Drafts tab in Job Order Administration Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Pending Approval and Drafts
    Verify Current Tab Is Active    Pending Approval and Drafts

Verify Navigation of Placements & Submittals tab in Talent Management Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Talent    Placements & Submittals
    Verify Current Tab Is Active    Placements & Submittals

Verify Navigation of Talent Pool tab in Talent Management Page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Talent    Talent Pool
    Verify Current Tab Is Active    Talent Pool

Verify Navigation of Invoices tab in Invoice Administration page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    INVOICES    Invoices
    Verify Current Tab Is Active    Invoices

Verify Navigation of Ready To Invoice tab in Invoice Administration page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    INVOICES    Ready To Invoice
    Verify Current Tab Is Active    READY TO INVOICE

Verify Navigation of Spend Section in Analytics page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    ANALYTICS    Spend
    Verify Current Section Is Active    Spend

Verify Navigation of Operations Section in Analytics page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    ANALYTICS    Operations
    Verify Current Section Is Active    Operations

Verify Navigation of Market Section in Analytics page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    ANALYTICS    Market
    Verify Current Section Is Active    Market

Validate Notification Count Logic On Welcome Page
    Login To Portal    HCS    ${HCS}
    Validate Welcome Page Notification Count

Verify Navigation of My Profile page from Welcome Page
    Login To Portal    HCS    ${HCS}
    Navigate to My Profile Page
    Verify Current Tab Is Active    My Profile

Verify SignOut
    Login To Portal    HCS    ${HCS}
    SignOut From the Portal
    Verify Sign in Page Title