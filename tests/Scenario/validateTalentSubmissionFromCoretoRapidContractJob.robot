*** Settings ***
Library    String
Library    ../../libs/RuntimeData.py
Resource    ../../resources/variables/jobEntities.resource
Variables   ../../resources/variables/environment/qa2.py

Resource    ../../resources/pages/Login/loginPage.resource
Resource    ../../resources/pages/Welcome/welcomePage.resource
Resource    ../../resources/pages/Welcome/welcomePageVms.resource
Resource    ../../resources/pages/Job/createJobPage.resource
Resource    ../../resources/pages/Job/jobDetailsPage.resource
Resource   ../../resources/pages/Job/jobOrderAdministrationListPage.resource
Resource    ../../resources/pages/Job/jobOrderVmsPage.resource
Resource    ../../resources/pages/Job/jobDetailsVmsPage.resource
Resource    ../../resources/pages/Talent/addTalentVmsPage.resource
Resource    ../../resources/pages/JobTalent/jobTalentVmsPage.resource
Resource    ../../resources/pages/JobTalent/jobTalentPage.resource


Test Teardown    Close Browser Safely

*** Test Cases ***
#Create Job of Rapid Contract Type For Talent Submission
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs    Add New Job
#    Verify Create a Job Order Page Title
#    Select Rapid Contract Job Type
#    Select Specified Hiring Manager    ${HIRING_MANAGER}
#    Select Specified Location    ${LOCATION}
#    Select Specified Department    ${DEPARTMENT}
#    Select Specified Skill    ${SKILL}
#    Provide Num of Positions    ${NO_OF_POSITIONS}
#    Verify Vendor Hiring Process is Disabled for Rapid Contract Type
#    Select Earliest Start Date as Next Day
#    Select Specified Shift    ${SHIFT}
#    Provide Minimum Week Duration    ${MINI_WK_DUR}
#    Provide Expected Weekly Shift    ${EXPECTED_WKLY_SHIFT}
#    Provide Hours Per Shift    ${HOURS_PER_SHIFT}
#    Provide Years of Relevant Experience    ${YEARS_OF_EXPERIENCE}
#    Switch to Specified tab    Pay Package
#    Verify Current Tab Is Active    Pay Package
#    Set Regular Rate If Empty      ${REGULAR_RATE}
#    Switch to Specified tab    Credentials
#    Verify Current Tab Is Active    Credentials
#    Select First Credential Value as Optional
#    Switch to Specified tab    Vendors
#    Verify Current Tab Is Active    Vendors
#    Select Expedited Option From Vendor tab
#    Submit Job Details
#    Close Submission window
#    Check for Open Job Status
#    ${job}=    Store Created Job Name For Rapid Contract    JOB_FOR_TALENT_SUBMISSION

#Create Talent From Vms Portal
#    Login To Portal    VMS    ${VMS}
#    Click Feature Menu Option in Vms    Jobs
#    Verify Job Orders Page Title in Vms
#    ${jobName}=    RuntimeData.Get Value    JOB_FOR_TALENT_SUBMISSION
#    Apply Filter to Search for Specific Job Details in Vms    Job Details    ${jobName}
#    Select Search Result in vms    Job Details
#    Verify Job Details Page Title in Vms    ${jobName}
#    Check for Open Job Status in Vms
#    Switch to Specified tab in Details Page in Vms    Talent
#    Verify Current Tab Is Active    Talent
#    Select Submit Talent in Vms
#    Verify Submit Talent Window Title in Vms
#    Select Submit Talent New Talent in Vms
#    Verify Submit Talent Form Title in Vms
#    Input Uniq Email Address For Talent in Vms
#    Enter Unique SSN For Talent in Vms    TALENT_SSN
#    Providing Random Talent Details in Vms
#    ${dob}=    Get Runtime Field inside Object    TALENT    DOB
#    Choose DOB From Calendar in Vms    ${dob}
#    Input State For Talent in Vms    Wyoming
#    Input yearsOfExperience For Talent in Vms    ${YEARS_OF_EXPERIENCE}
#    ${ssn}=    RuntimeData.Get Value    TALENT_SSN
#    RuntimeData.Update Object Field    TALENT    SSN    ${ssn}
#    Upload License Test Document For Talent in Vms
#    Upload Resume Test Document For Talent in Vms
#    Navigate to Step2 For Talent in Vms
#    Navigate to Step3 and Save & Submit Talent Details in Vms
#    Switch to Specified tab in Details Page in Vms    Talent
#    Verify Current Tab Is Active    Talent
#    ${firstName}=    Get Runtime Field inside Object    TALENT    FIRST_NAME
#    Search For Created Talent in Vms   ${firstName}

#Accept offer for Submitted Talent
#    Login To Portal    VMS    ${VMS}
#    Click Feature Menu Option in Vms    Jobs
#    Verify Job Orders Page Title in Vms
#    ${jobName}=    RuntimeData.Get Value    JOB_FOR_TALENT_SUBMISSION
#    Apply Filter to Search for Specific Job Details in Vms    Job Details    ${jobName}
#    Select Search Result in vms    Job Details
#    Verify Job Details Page Title in Vms    ${jobName}
#    Check for Open Job Status in Vms
#    Switch to Specified tab in Details Page in Vms    Talent
#    Verify Current Tab Is Active    Talent
#    ${firstName}=    Get Runtime Field inside Object    TALENT    FIRST_NAME
#    Search For Created Talent in Vms    ${firstName}
#    Verify Talent Name Matches Stored Name in Vms
#    Check for Job is Offered Status in Vms
#    Accept the Offer in Vms
#    Request Extension If Eligible

Offer Extent For Submitted Talent
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    ${jobName}=    RuntimeData.Get Value    JOB_NAME
    Select Specified Job From List in Right Side Panel    ${jobName}
    Switch to Specified tab in Details Page    Talent
    Verify Current Tab Is Active    Talent
    ${firstName}=    Get Runtime Field inside Object    TALENT    FIRST_NAME
    Search For Created Talent    ${firstName}
    Verify Talent Name Matches Stored Name

