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
    Select Specified Talent From List    ${first_timecard_talent_name}
    validate talent status    On Assignment

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
    Capture Rate card Details Details and validate after submitting Timecard
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Line Items Statuses    Pending Approval


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
    Fill Timecard Hours    1    2
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
    Fill Timecard Hours    1    2
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
    Fill Timecard Hours    1    2
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
    Fill Timecard Hours    1    2
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

    



