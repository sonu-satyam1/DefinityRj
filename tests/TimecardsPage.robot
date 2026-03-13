*** Settings ***
Library    String
Library     ../libs/RuntimeData.py
Resource    ../resources/pages/Login/loginPage.resource
Resource    ../resources/pages/Welcome/welcomePage.resource
Resource    ../resources/pages/Welcome/welcomePageVms.resource
Resource    ../resources/pages/Timecards/timecardManagementPage.resource
Resource    ../resources/pages/Timecards/HcsTimecardDetailsPage.resource
Resource    ../resources/pages/Talent/talentManagementPage.resource
Resource    ../resources/pages/Timecards/timecardManagementVmsPage.resource
Resource    ../resources/pages/Settings/organizationDetailsPage.resource
Resource    ../resources/pages/Settings/administrativeSettingsPage.resource
Variables   ../resources/variables/environment/qa2.py


Test Teardown    Close Browser Safely


*** Test Cases ***
Verify that timecards are generated on hospital side for talents in on assignment
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    apply quick filter on timecards listing page    Disputed
    open first timecard details from listing and store talent name
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Talent
    Verify Talent Management Page Title
    Switch to Specified tab in Talent Management Page    Placements
    enable toggle show completed
    Select Specified Talent From List    ${first_timecard_talent_name}
    validate talent status    On Assignment    Completed

Verify that ia user is able to set timecard entry is set to MANUAL in HCS
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page
    edit hospital info on Organization Details page
    update timecard entry type    Manual
    save hospital info on Organization Details page
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page

#"Timecard punch type " set as Time IN/Time out
Verify that user should be able to set Timecard punch type as Time IN/Time out in Hospital settings
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page
    edit hospital info on Organization Details page
    update punch timecard punch type    Time In / Time Out
    save hospital info on Organization Details page
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page


Verify that for "Timecard punch type" set as Time IN/Time out, Vendor timecard manager should be able to submit a timecard
    [Documentation]    timecard status should update to PENDING APPROVAL in VMS Timecard details page
                ...    Timecard line items should be Pending Approval
                ...    "Timecard punch type " set as Time IN/Time out
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard


Verify that for "Timecard punch type " set as Time IN/Time out Vendor timecard manager should be able to submit a timecard with min 1 punch in out time, add document & submit 
    [Documentation]     timecard status should updateD to PENDING APPROVAL in VMS  Timecard listing page
                ...     "Timecard punch type " set as Time IN/Time out
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval


Verify that after submitting a timecard the timecard status should update to PENDING APPROVAL in HCS side Timecard details page "Timecard punch type " set as Time IN/Time out
    [Documentation]     timecard status should updateD to PENDING APPROVAL in HCS Timecard DETAILS page
                ...     "Timecard punch type " set as Time IN/Time out
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Pending Approval

Verify that after submitting a timecard the timecard status should update to PENDING APPROVAL in HCS side Timecard listing page "Timecard punch type " set as Time IN/Time out
    [Documentation]     timecard status should updateD to PENDING APPROVAL in HCS Timecard LISTING page
                ...     "Timecard punch type " set as Time IN/Time out
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval

Verify that HCS timecard manager should be able to submit a timecard from HCS side with punch type as time in and time out
    [Documentation]     timecard status should updateD to APPROVED in HCS Timecard DETAILS page
                ...     timecard status should updateD to APPROVED in HCS Timecard  LISTING page
                ...     "Timecard punch type " set as Time IN/Time out
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    open add document section
    upload document and save on HCS
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    submit timecard from HCS
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Approved
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Approved
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Approved
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Approved
    Capture Rate card Details Details and validate after submitting Timecard in HCS
    




#error messages while submitting timecard
Verify that if a timecard is submitted without any punches, it should throw error
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    open add document section
    upload document and save
    submit timecard
    Validate Error Message for Timecards on VMS Page

Verify that if a timecard is submitted with punches but no document added it should throw error
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    fill the timecard time in
    fill the timeout
    submit timecard
    Validate Error Message for Timecards on VMS Page


#"Timecard punch type" set as Hours
Verify that user should be able to set Timecard punch type as Hours in Hospital settings
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page
    edit hospital info on Organization Details page
    update punch timecard punch type    Hours
    save hospital info on Organization Details page
    Select Option from Building Blocks    Hospital Info
    Verify Organization Details Page Title
    Switch to Business rules tab in Organization Details Page

Verify that for "Timecard punch type" set as Hours Vendor timecard manager should be able to submit a timecard with Hrs added, add document & submit
    [Documentation]     timecard status should update to PENDING APPROVAL in VMS Timecard details page
                  ...   Timecard status should be Pending Approval
                  ...   Timecard line items should be Pending Approval
                  ...   "Timecard punch type" set as Hours
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    Fill Timecard Hours    1
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Pending Approval
    
Verify that for "Timecard punch type"set as "Hours" Vendor timecard manager should be able to submit a timecard with hrs added, add document & submit 
    [Documentation]     timecard status should updateD to PENDING APPROVAL in VMS  Timecard listing page
                ...     "Timecard punch type" set as Hours
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Fill Timecard Hours    1
    Sleep    5s
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval

Verify that after submitting a timecard the timecard status should update to PENDING APPROVAL in HCS side Timecard details page "Timecard punch type" set as Hours
    [Documentation]     timecard status should updateD to PENDING APPROVAL in HCS Timecard DETAILS page
                ...     "Timecard punch type" set as Hours
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Fill Timecard Hours    1
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Pending Approval

Verify that after submitting a timecard the timecard status should update to PENDING APPROVAL in HCS side Timecard listing page "Timecard punch type" set as Hours
    [Documentation]     timecard status should updateD to PENDING APPROVAL in HCS Timecard LISTING page
                ...     "Timecard punch type" set as Hours
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Fill Timecard Hours    1
    open add document section
    upload document and save
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval


Verify that HCS timecard manager should be able to submit a timecard from HCS side with punch type as hours
    [Documentation]     timecard status should updateD to APPROVED in HCS Timecard DETAILS page
                ...     timecard status should updateD to APPROVED in HCS Timecard  LISTING page
                ...     "Timecard punch type " set as hours
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Fill Timecard Hours    1
    open add document section
    upload document and save on HCS
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    submit timecard from HCS
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Approved
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Approved
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Approved
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Approved
    Capture Rate card Details Details and validate after submitting Timecard in HCS



#did not work toggle
Verify that Vendor talent manager should be able to submit the timecard with toggle did not work ON
    [Documentation]     Click on the toggle >a model should pop up >ADD DOCUMENT button should be disabled
                 ...    status of timecard & timecard line items should update to "PENDING APPROVAL"
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Pending Submission
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    enable toggle Did Not Work and click on continue
    Validate Button State By Text    ADD DOCUMENT    disabled
    submit timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses     Pending Approval


Verify that HCS user should be able to APPROVE a timecard in Pending approval and validate on HCS side
    [Documentation]    "Timecard status should be READY TO INVOICE 
                ...    Timecard line items should be READY TO INVOICE "
                ...    Verify the timecard & timecard line item status in HCS side timecard LISTING
                ...    Verify the timecard & timecard line item status in HCS side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Approve or Reject timecard from HCS    Approve Timecard
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status        Ready To Invoice
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Ready To Invoice
    #validationmade after approving timecards on pending approval status ON HOSPITAL SIDE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Ready To Invoice
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Ready To Invoice
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that HCS user should be able to APPROVE a timecard in Pending approval and validate on VMS side
    [Documentation]    "Timecard status should be READY TO INVOICE in VENDOR side timecard LISTING
                ...    Timecard line items should be READY TO INVOICE" VENDOR side timecard details page
                ...    Verify the timecard & timecard line item status in VENDOR side timecard LISTING
                ...    Verify the timecard & timecard line item status in VENDOR side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Pending Submission timecards available. Generate Pending submission timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Approve or Reject timecard from HCS    Approve Timecard
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Ready To Invoice
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    #validationmade after approving timecards on pending approval status ON VENDOR SIDE
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Ready To Invoice
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Ready To Invoice
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Ready To Invoice
    Capture Rate card Details Details and validate after submitting Timecard

Verify that HCS user should be able to REJECT a timecard in Pending approval and validate on HCS side
    [Documentation]    "Timecard status should be REJECTED
                ...    Timecard line items should be REJECTED"
                ...    Verify the timecard & timecard line item status in HCS side timecard LISTING
                ...    Verify the timecard & timecard line item status in HCS side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Pending Approval timecards available. Generate Pending Approval timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Approve or Reject timecard from HCS    Reject Timecard
    Select reject request reason from dropdown enter text and click on reject timecard
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Rejected
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Rejected
    #validationmade after approving timecards on pending approval status ON HOSPITAL SIDE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Rejected
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Rejected
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that HCS user should be able to REJECT a timecard in Pending approval and validate on Vendor side
    [Documentation]    "Timecard status should be REJECTED in VENDOR side timecard LISTING
                ...    Timecard line items should be REJECTED VENDOR side timecard details page
                ...    Verify the timecard & timecard line item status in VENDOR side timecard LISTING
                ...    Verify the timecard & timecard line item status in VENDOR side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Pending Approval timecards available. Generate Pending Approval timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Approve or Reject timecard from HCS    Reject Timecard
    Select reject request reason from dropdown enter text and click on reject timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Rejected
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    Capture All Cells From First Row
    #validationmade after approving timecards on pending approval status ON VENDOR SIDE
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Rejected
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Rejected
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Capture Rate card Details Details and validate after submitting Timecard

Verify that HCS user should be able to EDIT & APPROVE a timecard in Pending approval and validate on HCS side
    [Documentation]    Timecard status should be APPROVED
                ...    Timecard line items should be APPROVED
                ...    Verify the timecard & timecard line item status in HCS side timecard LISTING
                ...    Verify the timecard & timecard line item status in HCS side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Pending Approval timecards available. Generate Pending Approval timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Approve or Reject timecard from HCS    EDIT
    fill the timecard time in
    fill the timeout
    Capture Rate card Details Details while submitted Timecard from HCS
    submit timecard from HCS
    #validationmade after approving timecards with edits on pending approval status ON HOSPITAL SIDE
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Approved
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after edit and approve timecards on pending approval status ON HOSPITAL SIDE in LISTING PAGE
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Approved
    #validationmade after edit and approve timecards on pending approval status ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Approved
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Approved
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that HCS user should be able to EDIT & APPROVE a timecard in Pending approval and validate on Vendor side
    [Documentation]    Timecard status should be APPROVED
                ...    Timecard line items should be APPROVED
                ...    Verify the timecard & timecard line item status in Vendor side timecard LISTING
                ...    Verify the timecard & timecard line item status in Vendor side timecard details page
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Pending Approval timecards available. Generate Pending Approval timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Approve or Reject timecard from HCS    EDIT
    fill the timecard time in
    fill the timeout
    Capture Rate card Details Details while submitted Timecard from HCS
    submit timecard from HCS
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Approved
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after edit and approve timecards on pending approval status ON VENDOR SIDE listing page
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Approved
    #validation made after edit and approve timecards on pending approval status ON VENDOR SIDE details page
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Approved
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Capture Rate card Details Details and validate after submitting Timecard


Verify that HCS timecard manager should be able to rescind the timecards in APPROVED Status and validate on HCS side
    [Documentation]    Click on 3 dots>choose rescind approval>rescind approval modal opens>confirm that 
                ...    timecard status should update to PENDING APPROVAL IN HCS TIMECARD details page 
                ...    timecard status should update to PENDING APPROVAL IN HCS TIMECARD LISTING 
                ...    Timecard status should be Pending Approval
                ...    Timecard line items should be Pending Approval
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Approved
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Approved timecards available. Generate Approved timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Click Rescind Approval From Menu
    Click Continue When Clickable
    #validation made after rescind approved status timecards ON HOSPITAL SIDE
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after rescind approved status timecards ON HOSPITAL SIDE in LISTING PAGE
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval
    #validation made after rescind approved status timecards ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that HCS timecard manager should be able to rescind the timecards in READY TO INVOICE Status and validate on HCS side
    [Documentation]    Click on 3 dots>choose rescind approval>rescind approval modal opens>confirm that
                ...    timecard status should update to PENDING APPROVAL IN HCS TIMECARD details page
                ...    timecard status should update to PENDING APPROVAL IN HCS TIMECARD LISTING
                ...    Timecard status should be Pending Approval
                ...    Timecard line items should be Pending Approval
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Ready To Invoice
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Ready To Invoice timecards available. Generate Ready To Invoice timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Click Rescind Approval From Menu
    Click Continue When Clickable
    #validation made after rescind Ready To Invoice status timecards ON HOSPITAL SIDE
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Pending Approval
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after rescind Ready To Invoice status timecards ON HOSPITAL SIDE in LISTING PAGE
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval
    #validation made after rescind Ready To Invoice status timecards ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that HCS timecard manager should be able to rescind the timecards in APPROVED Status and validate on VENDOR side
    [Documentation]    Click on 3 dots>choose rescind approval>rescind approval modal opens>confirm that
                ...    timecard status should update to PENDING APPROVAL IN VENDOR TIMECARD details page
                ...    timecard status should update to PENDING APPROVAL IN VENDOR TIMECARD LISTING
                ...    Timecard status should be Pending Approval
                ...    Timecard line items should be Pending Approval
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Approved
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Approved timecards available. Generate Approved timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Click Rescind Approval From Menu
    Click Continue When Clickable
    #validation made after rescind approved status timecards ON VENDOR SIDE
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after rescind approved status timecards ON VENDOR SIDE listing page
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval
    #validation made after rescind approved status timecards ON VENDOR SIDE details page
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard

Verify that HCS timecard manager should be able to rescind the timecards in READY TO INVOICE Status and validate on VENDOR side
    [Documentation]    Click on 3 dots>choose rescind approval>rescind approval modal opens>confirm that
                ...    timecard status should update to PENDING APPROVAL IN VENDOR TIMECARD details page
                ...    timecard status should update to PENDING APPROVAL IN VENDOR TIMECARD LISTING
                ...    Timecard status should be Pending Approval
                ...    Timecard line items should be Pending Approval
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Ready To Invoice
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  READY TO INVOICE timecards available. Generate READY TO INVOICE timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard from HCS
    Click Rescind Approval From Menu
    Click Continue When Clickable
    #validation made after rescind READY TO INVOICE status timecards ON VENDOR SIDE
    Wait For Page Ready
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after rescind READY TO INVOICE status timecards ON VENDOR SIDE listing page
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Pending Approval
    #validation made after rescind READY TO INVOICE status timecards ON VENDOR SIDE details page
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Pending Approval
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Pending Approval
    Capture Rate card Details Details and validate after submitting Timecard

Verify that timecards NOT in Approved or Ready to Invoice status do NOT show Rescind option
    [Documentation]    timecards NOT in Approved or Ready to Invoice status do NOT show Rescind option
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown    Status       Pending Approval
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No  Approved timecards available. Generate Approved timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Validate Rescind Approval Not Available



Verify that vendor can CONFIRM all line items on an APPROVED TIMECARD at once and validate on HCS side
    [Documentation]    Click on an approved timecard >click on CONFIRM ALL button 
                ...    Timecard status should update to READY TO INVOICE 
                ...    line items should update to READY To invoice
                ...    timecard status should update to Ready to Invoice In HCS side Timecard details
                ...    timecard status should update to Ready to Invoice In HCS side Timecard LISTING
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Approved timecards available. Generate Approved timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Dispute or ConfirmAll timecard and from HCS    CONFIRM ALL
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Ready To Invoice
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after confirm all line items for approved ON HOSPITAL SIDE in LISTING PAGE
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Ready To Invoice
    #validation made after confirm all line items for approved status timecards ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Ready To Invoice
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses on HCS    Ready To Invoice
    Capture Rate card Details Details and validate after submitting Timecard in HCS

Verify that vendor can CONFIRM all line items on an APPROVED TIMECARD at once and validate on VENDOR side
    [Documentation]    Click on an approved timecard >click on CONFIRM ALL button
                ...    Timecard status should update to READY TO INVOICE
                ...    line items should update to READY To invoice
                ...    timecard status should update to Ready to Invoice In VENDOR side Timecard details
                ...    timecard status should update to Ready to Invoice In VENDOR side Timecard LISTING
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No Approved timecards available. Generate Approved timecards and execute again.
    END
    # Continue remaining steps only if talent exists
    Capture Talent Name while submitting Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Dispute or ConfirmAll timecard and from HCS    CONFIRM ALL
    Sleep    10s
    Close Browser Safely
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by entering text    Timecard Amount    ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by selecting dropdown    Status       Ready To Invoice
    Filter Timecard By Column by entering text    Talent Name       ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after confirm all line items for approved ON VENDOR SIDE in LISTING PAGE
    Capture All Cells From First Row
    Validate Timecard Row Data    ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}    ${TIMECARD_DATE_RANGE_BEFORE_SUBMISSION}    Ready To Invoice
    #validation made after confirm all line items for approved status timecards ON VENDOR SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Ready To Invoice
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Ready To Invoice
    Capture Rate card Details Details and validate after submitting Timecard


