*** Settings ***
Resource    ../../../resources/pages/Login/loginPage.resource
Resource    ../../../resources/pages/Welcome/welcomePageVms.resource
Resource    ../../../resources/pages/Dashboard/myDashboardVmsPage.resource
Resource    ../../../resources/pages/Job/jobOrderVmsPage.resource
Resource    ../../../resources/pages/Talent/talentManagementVmsPage.resource
Resource    ../../../resources/pages/Timecards/timecardManagementVmsPage.resource
Resource    ../../../resources/pages/Compliance/complianceManagementVmsPage.resource
Resource    ../../../resources/pages/Invoice/invoiceAdministrationVmsPage.resource
Resource    ../../../resources/pages/Schedules/SchedulesVmsPage.resource
Resource    ../../../resources/pages/Settings/settingsAPIKeyVms.resource



Variables   ../../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Verify Welcome Title
    Login To Portal    VMS    ${VMS}
    Verify Page Header And Title For Vms

Verify Navigation of Dashboard Page from Welcome Page
     Login To Portal    VMS    ${VMS}
     Click Feature Menu Option in Vms    Dashboard
     Verify Dashboard Page Title in Vms

Verify Navigation of Jobs Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Jobs
    Verify Job Orders Page Title in Vms

Verify Navigation of Talent Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Talent
    Verify Talent Management Page Title in Vms

Verify Navigation of Timecards Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Verify Timecard Management Page Title in Vms

Verify Navigation of Compliance Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    COMPLIANCE
    Verify Compliance Management Page Title in Vms

Verify Navigation of Invoices Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    INVOICES
    Verify Invoice Administration Page Title in Vms

Verify Navigation of Schedules Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Schedules
    Verify Schedules Page Title in Vms

Verify Navigation of Settings Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    SETTINGS
    Verify Settings For API Key Page Title in Vms

Verify Navigation of Open Positions tab in Job Order Administration Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Jobs    Open Positions
    Verify Current Tab Is Active    Open Positions

Verify Navigation of All Job Requisitions tab in Job Order Administration Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Jobs    All Job Requisitions
    Verify Current Tab Is Active    All Job Requisitions

Verify Navigation of Submittals & Placements tab in Talent Management Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Talent    Submittals & Placements
    Verify Current Tab Is Active    SUBMITTALS & PLACEMENTS

Verify Navigation of Talent Pool tab in Talent Management Page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    Talent    Talent Pool
    Verify Current Tab Is Active    Talent Pool

Validate Notification Count Logic On Welcome Page
    Login To Portal    VMS    ${VMS}
    Validate Welcome Page Notification Count in Vms

Verify Navigation of My Profile page from Welcome Page
    Login To Portal    VMS    ${VMS}
    Navigate to My Profile Page in Vms
    Verify Current Tab Is Active    My Profile

Verify SignOut
    Login To Portal    VMS    ${VMS}
    SignOut From the Portal in Vms
    Verify Sign in Page Title