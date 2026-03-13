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
Verify 'Dispute' and 'Confirm All' buttons are present on APPROVED timecard on VENDOR SIDE
    [Documentation]     [VMS] Open an APPROVED timecard. Verify 'Dispute' and 'Confirm All' buttons are present
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Verify Action Buttons Present    DISPUTE    CONFIRM ALL

Click 'Dispute' Verify each line item shows 'Dispute' or 'Confirm' action present on APPROVED timecard on VENDOR SIDE
    [Documentation]    Verify Dispute/Confirm buttons on each line item
                ...    present on APPROVED timecard on VENDOR SIDE after clicking on dispute
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Dispute or ConfirmAll timecard and from HCS    DISPUTE
    Validate Action Buttons On LineItems    DISPUTE    CONFIRM

Dispute one line item – verify it deactivates the original line and opens a new editable line for that date
    [Documentation]    Dispute one line item – verify it deactivates the original line
                ...    and opens a new editable line for that date
                ...    Verify disputed line deactivation + new editable line
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Dispute or ConfirmAll timecard and from HCS    DISPUTE
    Click on Dispute or Confirm Action Buttons On LineItems    DISPUTE    1
    Validate Disputed Row Fields Are Disabled
    Validate First Timecard Row Fields Are Enabled    1

Dispute one line item In the new dispute line, modify: rate type, cost center, time in/out (or hours), and meal and Validate on VENDOR DETAILS PAGE
    [Documentation]    In the new dispute line, modify: rate type, cost center, time in/out (or hours), and meal.
                ...    Verify modify rate type, cost center, time in/out, meal while disputing
                ...    Add another line item for the disputed date
                ...    Click 'Submit Dispute'. Verify the Dispute Reason modal launches.
                ...    Select ONE dispute reason, enter comment, and add supporting document. Submit dispute
                ...     Verify disputed line items status = 'Disputed' on VMS Timecard Details
                ...    Verify timecard displays banner with: Dispute Reason(s), Comment, User/Date/Time, Document file
                ...    Validate on VENDOR DETAILS PAGE
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Capture Talent Name while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Dispute or ConfirmAll timecard and from HCS    DISPUTE
    Click on Dispute or Confirm Action Buttons On LineItems    DISPUTE    1
    Select Random Rate Type Different From Current      1
    Select Random Cost Centre Different From Current    1
    Fill Timecard Based On Field Type for timein timeout or hours for disputed line items    1
    Add another line item for the disputed date by clicking on plus icon    1
    Select Random Cost Centre Different From Current    1
    Dispute or ConfirmAll timecard and from HCS    SUBMIT DISPUTE
    open add document window on dispute reason window
    upload document and save
    Select dispute reason from dropdown enter text and click on submit dispute timecard
    Sleep    10s
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Disputed
    Validate timecard displays banner And Log Banner Texts
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Disputed Line Items Statuses on VENDOR    Disputed    2

Dispute one line item In the new dispute line, modify: rate type, cost center, time in/out (or hours), and meal and Validate on HCS DETAILS PAGE
    [Documentation]    In the new dispute line, modify: rate type, cost center, time in/out (or hours), and meal.
                ...    Verify modify rate type, cost center, time in/out, meal while disputing
                ...    Add another line item for the disputed date
                ...    Click 'Submit Dispute'. Verify the Dispute Reason modal launches.
                ...    Select ONE dispute reason, enter comment, and add supporting document. Submit dispute
                ...     Verify disputed line items status = 'Disputed' on VMS Timecard Details
                ...    Verify timecard displays banner with: Dispute Reason(s), Comment, User/Date/Time, Document file
                ...    Validate on HCS DETAILS PAGE
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Capture Talent Name while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Dispute or ConfirmAll timecard and from HCS    DISPUTE
    Click on Dispute or Confirm Action Buttons On LineItems    DISPUTE    1
    Select Random Rate Type Different From Current      1
    Select Random Cost Centre Different From Current    1
    Fill Timecard Based On Field Type for timein timeout or hours for disputed line items    1
    Add another line item for the disputed date by clicking on plus icon    1
    Select Random Cost Centre Different From Current    1
    Dispute or ConfirmAll timecard and from HCS    SUBMIT DISPUTE
    open add document window on dispute reason window
    upload document and save
    Select dispute reason from dropdown enter text and click on submit dispute timecard
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Disputed
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after dispute line items for approved status timecards ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Disputed
    Capture Timecard Work Week Date Details and validate after submitting Timecard
    Validate Timecards Disputed Line Items Statuses on HCS    Disputed    2



#Click 'Withdraw Dispute' from Vendor Side for Disputed Timecards Verify status reverts to 'Approved',Validate on VMS Details Page
#    [Documentation]    Disputed Timecards status reverts to 'Approved'
#                ...    Validate on VMS Details Page
#    Login To Portal    VMS    ${VMS}
#    Click Feature Menu Option in Vms    TIMECARDS
#    Filter Timecard By Column by selecting dropdown    Status    Disputed
#    ${talent_clicked}=    Get First Talent Name And Click
#    IF    not ${talent_clicked}
#        Pass Execution    No Disputed timecards available. Generate Disputed timecards and execute again.
#    END
#    Capture Talent Name while submitting Timecard
#    Capture Rate card Details Details while submitted Timecard
#    Capture Timecard Work Week Date Details while submitting Timecard
##    withdrawing dispute in below keyword
#    Dispute or ConfirmAll timecard and from HCS    WITHDRAW DISPUTE
##    validating on VMS details page
#    Capture Talent Name and validate after submitting Timecard
#    validate timecard status    Approved
#    Capture Timecard Work Week Date Details and validate after submitting Timecard
    
Click 'Withdraw Dispute' from Vendor Side for Disputed Timecards Verify status reverts to 'Approved',Validate on HCS Details Page
    [Documentation]    Disputed Timecards status reverts to 'Approved'
                ...    Validate on HCS Details Page
    Login To Portal    VMS    ${VMS}
    Click Feature Menu Option in Vms    TIMECARDS
    Filter Timecard By Column by selecting dropdown    Status    Approved
    ${talent_clicked}=    Get First Talent Name And Click
    IF    not ${talent_clicked}
        Pass Execution    No APPROVED timecards available. Generate APPROVED timecards and execute again.
    END
    Capture Talent Name while submitting Timecard
    Capture Rate card Details Details while submitted Timecard
    Capture Timecard Work Week Date Details while submitting Timecard
    Dispute or ConfirmAll timecard and from HCS    DISPUTE
    Click on Dispute or Confirm Action Buttons On LineItems    DISPUTE    1
    Select Random Rate Type Different From Current      1
    Select Random Cost Centre Different From Current    1
    Fill Timecard Based On Field Type for timein timeout or hours for disputed line items    1
    Add another line item for the disputed date by clicking on plus icon    1
    Select Random Cost Centre Different From Current    1
    Dispute or ConfirmAll timecard and from HCS    SUBMIT DISPUTE
    open add document window on dispute reason window
    upload document and save
    Select dispute reason from dropdown enter text and click on submit dispute timecard
    Sleep    10s
#    withdrawing dispute from vendor in below keyword
    Dispute or ConfirmAll timecard and from HCS    WITHDRAW DISPUTE
#    validating on hcs details page
    Sleep    10s
    Close Browser Safely
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    TIMECARDS
    Verify Timecard Management Page Title
    navigate to default view
    Filter Timecard By Column by selecting dropdown on HCS    Status    Approved
    Filter Timecard By Column by entering text         Vendor       COSA vendor
    Filter Timecard By Column by entering text on HCS   Timecard Amount     ${RATECARD_TOTAL_AMOUNT_BEFORE_SUBMISSION}
    Filter Timecard By Column by entering text on HCS    Talent Name        ${TIMECARD_TALENT_NAME_BEFORE_SUBMISSION}
    #validation made after confirm all line items for approved status timecards ON HOSPITAL SIDE in DETAILS PAGE
    Click Talent Name on Listing Page and navigate to Timecards details page
    Capture Talent Name and validate after submitting Timecard
    validate timecard status    Approved
    Capture Timecard Work Week Date Details and validate after submitting Timecard


