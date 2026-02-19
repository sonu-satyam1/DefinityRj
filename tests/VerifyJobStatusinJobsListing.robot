*** Settings ***
Library    String
Library     ../libs/RuntimeData.py
Resource    ../resources/pages/Login/loginPage.resource
Resource    ../resources/pages/Welcome/welcomePage.resource
Resource    ../resources/pages/Job/jobOrderAdministrationListPage.resource
Resource    ../resources/pages/Job/jobListing.resource
Resource    ../resources/pages/Job/createJobPage.resource
Resource    ../resources/pages/Job/jobDetailsPage.resource
Resource    ../resources/variables/jobEntities.resource
Resource    ../resources/pages/LefNavMenu/leftNavigation.resource
Resource    ../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../resources/pages/Settings/rateAdministration.resource

Variables   ../resources/variables/environment/qa2.py

Test Teardown    Close Browser Safely

*** Test Cases ***
#Verify that the default page on job administration page is OPEN POSITIONS which lists all the currently open jobs, that are not closed
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Click Column Filter Menu    Status
#    Wait For Page Ready
#    Validate Default Jobs Page Job Statuses
#
#Verify that "all job requisitions" page lists all the jobs (Status could be - Draft, pending approval,Open, Offer Pending, offers accepted ,filled,Rejected, closed)
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Click Column Filter Menu    Status
#    Wait For Page Ready
#    Validate Default Jobs Page All Jobs Requisition Statuses
#
#Verify that "pending approval & Draft " page lists the jobs created in pending approval & Draft status
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Click Column Filter Menu    Status
#    Wait For Page Ready
#    Validate Default Jobs Page pending approval & Draft Statuses
#
##quick filters on open position tab
#Verify the No Candidates quick filters in "open positions"tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Apply quick filter on Jobs page    No Candidates
#    Validate Quick Filters Count After Applying Quick Filter    No Candidates
#
#Verify the Applicants quick filters in "open positions"tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Applicants
#    Validate Quick Filters Count After Applying Quick Filter    Applicants
#
#Verify the Interviewing quick filters in "open positions"tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Interviewing
#    Validate Quick Filters Count After Applying Quick Filter    Interviewing
#
#
#Verify the Offer Accepted quick filters in "open positions"tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Offer Accepted
#    Validate Quick Filters Count After Applying Quick Filter    Offer Accepted
#
#Verify the Cleared to Start quick filters in "open positions"tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Cleared to Start
#    Validate Quick Filters Count After Applying Quick Filter    Cleared to Start
#
##quick filters on all job requisition tab
#Verify the Active Hot Jobs quick filter in "all job requisition" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Active Hot Jobs
#    Validate Quick Filters Count After Applying Quick Filter    Active Hot Jobs
#
#Verify the No Candidates quick filter in "all job requisition" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Apply quick filter on Jobs page    No Candidates
#    Validate Quick Filters Count After Applying Quick Filter    No Candidates
#
#Verify the Recent Activity quick filter in "all job requisition" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Recent Activity
#    Validate Quick Filters Count After Applying Quick Filter    Recent Activity
#
#Verify the Pending Start quick filter in "all job requisition" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Pending Start
#    Validate Quick Filters Count After Applying Quick Filter    Pending Start
#
#Verify the Time Sensitive Jobs quick filter in "all job requisition" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Time Sensitive Jobs
#    Validate Quick Filters Count After Applying Quick Filter    Time Sensitive Jobs
#
##quick filters on pending approval & Draft tab
#Verify the Drafts quick filter in "Pending approval & draft" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Drafts
#    Validate Quick Filters Count After Applying Quick Filter    Drafts
#
#Verify the Pending Approval quick filter in "Pending approval & draft" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Pending Approval
#    Validate Quick Filters Count After Applying Quick Filter    Pending Approval
#
#Verify the My Actions quick filter in "Pending approval & draft" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Apply quick filter on Jobs page    My Actions
#    Validate Quick Filters Count After Applying Quick Filter    My Actions
#
#Verify the Hot Jobs quick filter in "Pending approval & draft" tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Apply quick filter on Jobs page    Hot Jobs
#    Validate Quick Filters Count After Applying Quick Filter    Hot Jobs
#
#Verify that "new" subtab should only show newly updated/created records in open positions tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Switch to Specified subtab in Job Order Administration Page from tab    New
#    Verify All New Labels    New     NEW
#
#Verify that "new" subtab should only show newly updated/created records in pending approval and drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Switch to Specified subtab in Job Order Administration Page from tab    New
#    Verify All New Labels    New     NEW
#
#Verify that "extension" subtab should only show newly updated/created records in open positions tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Switch to Specified subtab in Job Order Administration Page from tab    Extension
#    Verify All New Labels    Extension     EXTENSION
#
#Verify that "extension" subtab should only show newly updated/created records in pending approval and drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Switch to Specified subtab in Job Order Administration Page from tab    Extension
#    Verify All New Labels    Extension     EXTENSION
#
#
#
#Verify that user should be able to filter by any value on all columns in job listing
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Select First Job Details from List and store Job Id
#    Enter Job Id in Search box and apply search
#    validate Job Id searched accurately
#
##column filters on jobs listing page
#Verify that user should be able to filter by any value on job details columns in job listing
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Select First Job Details from List and store Job Id
#    Click Column Filter Menu    Job Details
#    Enter Value in column filter search box    ${JOB_ID}
#    select searched value
#    click on filter button on column filter
#    validate Job Id searched accurately
#
#Verify that user should be able to apply column filter on Status column in job listing page
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Select First Job Details from List and store Job Id
#    Apply Filter for Open Jobs and Job Type        Status       Open
#    validate data searched accurately by column filter for status    Status       OPEN
#
#Verify that user should be able to apply column filter on Status column in job listing page
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Select First Job Details from List and store Job Id
#    Apply Filter for Open Jobs and Job Type        Skill       Cardiology
#    validate data searched accurately by column filter for status    Skill       Cardiology
#
#Verify that user should be able to apply column filter on Status column in job listing page
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Select First Job Details from List and store Job Id
#    Apply Filter for Open Jobs and Job Type        Shift       03:00-15:00 (05:49 - 15:49)
#    validate data searched accurately by column filter for status    Shift       03:00-15:00 (05:49 - 15:49)
#
#
#Verify start date filter in open positions tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Show All Columns From Menu Filter
#    Sleep    2s
#    Verify Table Has Column     Earliest Start Date
#    Sleep    2s
#    select start Date from dropdown on jobs page
#    Sleep    2s
#    Verify Dates On Page Are Within Range
#
#Verify start date filter in pending approval & draft tab
#   Login To Portal    HCS    ${HCS}
#   Click Feature Menu Option    Jobs
#   Verify Job Order Administration Page Title
#   Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#   Wait For Page Ready
#   Show All Columns From Menu Filter
#   select start Date from dropdown on jobs page
#   Verify Table Has Column     Earliest Start Date
#   Sleep    5s
#   Verify Dates On Page Are Within Range
#
#Verify tag filter in open positions tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    select tag from dropdown on jobs page
#    Select a Random Job Details from List
#    from left pane open job details page
#    validate tag should be present in job    HCMC
#
#Verify tag filter in all job requisitions
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    select tag from dropdown on jobs page
#    open job details page from all jobs requisition tab
#    validate tag should be present in job    HCMC
#
#
##pagination on all the tabs in job listing page
##open positions tab
#Verify by default 50 items to be displayed on open position tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    validate count on jobs page    50
#
#Verify by changing items per page to 20 items, only 20 items to be displayed on open position tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    20
#    validate count on jobs page    20
#
#Verify by changing items per page to 100 items, only 100 items to be displayed on open position tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    100
#    validate count on jobs page    100
#
#Verify by changing items per page to 500 items, only 500 items to be displayed on open position tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    500
#    validate count on jobs page    500
#
#Verify by changing page number to next page and validate items count on open position tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
#    Wait For Page Ready
#    Get Total Items From Pager And Store the count
#    select items per page from dropdown on jobs listing page    20
#    Check And Navigate to next page If Item Count Exceeds    20     2
#    validate count on jobs page    20
#
##all jobs requisitions tab
#Verify by default 50 items to be displayed on all jobs requisition tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    validate count on jobs page    50
#
#Verify by changing items per page to 20 items, only 20 items to be displayed all jobs requisition tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    20
#    validate count on jobs page    20
#
#Verify by changing items per page to 100 items, only 100 items to be displayed all jobs requisition tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    100
#    validate count on jobs page    100
#
#Verify by changing items per page to 500 items, only 500 items to be displayed all jobs requisition tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    500
#    validate count on jobs page    500
#
#Verify by changing page number to next page and validate items count on all jobs requisition tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
#    Wait For Page Ready
#    Get Total Items From Pager And Store the count
#    select items per page from dropdown on jobs listing page    20
#    Check And Navigate to next page If Item Count Exceeds    20     2
#    validate count on jobs page    20
#
##pending approval and drafts tab
#Verify by default 50 items to be displayed on all Pending Approval and Drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    validate count on jobs page    50
#
#Verify by changing items per page to 20 items, only 20 items to be displayed Pending Approval and Drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    20
#    validate count on jobs page    20
#
#Verify by changing items per page to 100 items, only 100 items to be displayed Pending Approval and Drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    100
#    validate count on jobs page    100
#
#Verify by changing items per page to 500 items, only 100 items to be displayed Pending Approval and Drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    select items per page from dropdown on jobs listing page    500
#    validate count on jobs page    500
#
#Verify by changing page number to next page and validate items count on Pending Approval and Drafts tab
#    Login To Portal    HCS    ${HCS}
#    Click Feature Menu Option    Jobs
#    Verify Job Order Administration Page Title
#    Switch to Specified tab in Job Order Administration Page    Pending Approval and Drafts
#    Wait For Page Ready
#    Get Total Items From Pager And Store the count
#    select items per page from dropdown on jobs listing page    20
#    Check And Navigate to next page If Item Count Exceeds    20     2
#    validate count on jobs page    20


Verify that job order status should be OPEN where the number of outstanding offers is fewer than the number of open positions
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Apply quick filter on Jobs page    Applicants
    Validate Quick Filters Count After Applying Quick Filter    Applicants
    Apply Filter for Open Jobs and Job Type        Status       Open
#    validate data searched accurately by column filter for status    Status       OPEN
    Click Jobs Where Open Less Than Total

Verify that when a job is created & saved as DRAFT - staus is DRAFT
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs    Add New Job
    Verify Create a Job Order Page Title
    Select Standard Contract Job Type
    Select Specified Hiring Manager    ${HIRING_MANAGER}
    Select Specified Location    ${LOCATION}
    Select Specified Department    ${DEPARTMENT}
    Select Specified Skill    ${SKILL}
    click on save as dropdown to select save as draft job option
    Check for Draft Job Status

Verify that job order status should be OFFERS PENDING when the number of outstanding offers is equal to the number of open positions for extension jobs
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    Extension
    Apply Filter for Open Jobs and Job Type        Status       Offer Pending
    Sleep    5s
    Click All Jobs And Validate Total Equals Job Is Offered

Verify that job order status should be OFFERS PENDING when the number of outstanding offers is equal to the number of open positions for new jobs
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offer Pending
    Sleep    5s
    Click All Jobs And Validate Total Equals Job Is Offered

Verify that Job Orders in Offers Pending Status should restrict the hospital from extending additional offers
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type    Status    Offer Pending
    Sleep    2s
    ${applied_found}=    Click And Open Talent With Applied Status In All Jobs
    Sleep    2s
    Run Keyword If
    ...    ${applied_found}
    ...    validate that extend offer button is disabled
    Run Keyword If
    ...    not ${applied_found}
    ...    Log    No talents with applied status found on offers pending job , please create test data
    Sleep    5s

Verify that job order status should be OFFERS ACCEPTED (new) when the number of talent in “offer accepted” status plus the number of talent in “Cleared to Start” status is equal to the number of total positions
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offers Accepted
    Sleep    2s
    Click Jobs Where Open Less Than Total for offers accepted new jobs

Verify that job order status should be OFFERS ACCEPTED(Extension) , when the number of talent in “offer accepted” status plus the number of talent in “Cleared to Start” status is equal to the number of total positions
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    Extension
    Apply Filter for Open Jobs and Job Type        Status       Offers Accepted
    Sleep    2s
    Click Jobs Where Open Less Than Total for offers accepted extension jobs

Verify that job order status should be FILLED , where the number of talents in “On Assignment” Status is equal to the number of openings for the job order
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Switch to Specified tab in Job Order Administration Page    All Job Requisitions
    Wait For Page Ready
    navigate to job Details page on all jobs requisition page
    Wait For Page Ready
    apply filter on job details page    Filled
    open filled job details and validate status of all jobs


Verify that Job Order reverts back to OPEN status for offers accepted job if a Internal talent later fails to start so the number of accepted offers is fewer than the number of open positions
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offers Accepted
    Sleep    2s
#    Click All Jobs And select Internal talent with offers accepted status in offers accepted jobs
    Click All Jobs And select Internal talent with status give in argument    Offer Accepted
    change status to failed to start for offers accepted talents
    Sleep    2s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
#    Apply Filter for Open Jobs and Job Type        Job Details       ${job_offered_job_id}
    Apply Filter for Open Jobs and Job Type        Job Details       ${job_id}
    Sleep   2s
    validate job should be changed to open
    Sleep    2s

Verify that Job Order reverts back to OPEN status for offers accepted job if a Vendor talent later fails to start so the number of accepted offers is fewer than the number of open positions
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offers Accepted
    Sleep    2s
#    Click All Jobs And select Vendor talent with offers accepted status in offers accepted jobs
    Click All Jobs And select Vendor talent with status give in argument    Offer Accepted
    change status to failed to start for offers accepted talents
    Sleep    2s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
#    Apply Filter for Open Jobs and Job Type        Job Details       ${job_offered_job_id}
    Apply Filter for Open Jobs and Job Type        Job Details       ${job_id}
    Sleep   2s
    validate job should be changed to open
    Sleep    2s
    
Verify that when Hospital withdraw an Internal talent offer such that the number of outstanding offers is fewer than the number of open positions the Job Status should revert back to Open
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offer Pending
    Sleep    2s
    Click All Jobs And select Internal talent with status give in argument    Job is Offered
    hospital withdraw offer for job is offered talent
    Sleep    2s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Apply Filter for Open Jobs and Job Type        Job Details       ${job_id}
    Sleep   2s
    validate job should be changed to open
    Sleep    2s

Verify that when Hospital withdraw an Vendor talent offer such that the number of outstanding offers is fewer than the number of open positions the Job Status should revert back to Open
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Switch to Specified subtab in Job Order Administration Page from tab    New
    Apply Filter for Open Jobs and Job Type        Status       Offer Pending
    Sleep    2s
    Click All Jobs And select Vendor talent with status give in argument    Job Offered
    hospital withdraw offer for job is offered talent
    Sleep    2s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Jobs
    Verify Job Order Administration Page Title
    Generic Assert Element Text Equals    ${OPEN_POSITIONS_TAB}    OPEN POSITIONS
    Wait For Page Ready
    Apply Filter for Open Jobs and Job Type        Job Details       ${job_id}
    Wait For Page Ready
    validate job should be changed to open
    Sleep    5s

