*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource
Resource    jobDetailsPage.resource
Library     DateTime
Library     Collections

*** Variables ***
${OPEN_POSITIONS_TAB}    //span[text()='Open Positions']
${JOBS_STATUSES}         //label[@class='k-checkbox-label']
${FIRST_JOB_LOCATOR}     (//span[@class='name-col cursor-pointer'])[1]
${JOBS_PAGE_SEARCH_INPUT}       xpath://input[contains(@class,'k-input k-input')]
${COLUMN_FILTER_TEXT_FIELD}     //input[contains(@class,'k-input-inner k-input')]
${CHECK_ALL_COLUMN_FILTER}      //label[text()='Check All']
${SELECT_FILTER_0N_COLUMN_FILTER}    //span[text()='Filter']
${START_DATE_DROPDOWN_LOCATOR}      //span[@aria-label='Start Date']//button
${START_DATE_OPTIONS}                //span[@class='k-list-item-text']
${JOBS_HEADERS}              //table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${TAG_DROPDOWN_LOCATOR}      //label[text()='Tags']/..//div[contains(@class,'k-multiselect k')]
${TAGS_OPTIONS}              //span[@class='k-list-item-text']
${FIRST_TAG}                 (//span[@class='k-list-item-text'])[1]
${LEFT_PANE_JOB_ELEMENT}     //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
${ACTUAL_TAGS_LIST}          //li[@class='react-tags__list-item']
${JOBREQ_1ST_JOB}            (//a[contains(@href,'/job-order/details')])[1]
${ACTUAL_COUNT_ELEMENTS}     //td[1]
${ITEMS_PER_PAGE_DROPDOWN_LOCATOR}    //span[@class='k-input-inner']//span[text()='50']
${ITEMS_PER_PAGE_OPTIONS}             //li[@class='k-list-item']
${JOB_POSITIONS}                   //span[@class='job-positions']
${SAVE_AS_DROPDOWN_LOCATOR}        //button[normalize-space()='Save As']/..//button[@aria-label='menu toggling button']
${SAVE_AS_DRAFT_LOCATOR}        //li[@class='k-item k-focus k-menu-item k-first']
${EXTEND_OFFER_BUTTON_LOCATOR}    //button[.//span[normalize-space()='Extend Offer']]
${ERROR_MSG_LOCATOR}           //span[normalize-space()='The positions for this job are filled. There are no more openings for this job.']
${FIRST_JOB_ALL_JOB_REQ_LOCATOR}    (//tbody//span//a)[1]
${FILTER_BTN_JOB_DETAILS_PAGE}       //button[@class='cursor-pointer filter-status-icon btn-common']

*** Keywords ***
Get Texts From Elements
    [Arguments]    ${locator}
    Wait For Page Ready
    Wait Till Element Visible          ${locator}
    @{elements}=    Get WebElements    ${locator}
    @{texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${text}=    Strip String    ${text}
        Append To List    ${texts}    ${text}
    END
    [Return]    ${texts}
    Wait For Page Ready

Validate Default Jobs Page Job Statuses
    @{texts}=    Get Texts From Elements    ${JOBS_STATUSES}
    Log    ${texts}
    List Should Contain Value    ${texts}    Open
    List Should Contain Value    ${texts}    Offer Pending
    List Should Contain Value    ${texts}    Offers Accepted
    
Validate Default Jobs Page All Jobs Requisition Statuses
    @{texts}=    Get Texts From Elements    ${JOBS_STATUSES}
    Log    ${texts}
    List Should Contain Value    ${texts}    Closed
    List Should Contain Value    ${texts}    Filled
    List Should Contain Value    ${texts}    Offer Pending
    List Should Contain Value    ${texts}    Offers Accepted
    List Should Contain Value    ${texts}    Open
    List Should Contain Value    ${texts}    Pending Approval

Validate Default Jobs Page pending approval & Draft Statuses
    @{texts}=    Get Texts From Elements    ${JOBS_STATUSES}
    Log    ${texts}
    List Should Contain Value    ${texts}    Draft
    List Should Contain Value    ${texts}    Pending Approval

Apply quick filter on Jobs page
    [Arguments]    ${Quick_filter_name}    
    Wait For Page Ready
    Wait Until Page Contains Element    //span[text()='${Quick_filter_name}']
    Wait Till Element Visible           //span[text()='${Quick_filter_name}']
    Click Element Safely                //span[text()='${Quick_filter_name}']
    Wait For Page Ready


Validate Quick Filters Count After Applying Quick Filter
    [Arguments]    ${Quick_filter_name}

    Wait For Page Ready
    Wait Until Page Contains Element    //span[text()='${Quick_filter_name}']/../..//h2
    Wait For Page Ready

    ${expected_count}=    Get Text    //span[text()='${Quick_filter_name}']/../..//h2
    ${actual_count}=      Get Text    //span[@class='k-pager-info']
    Log    ${expected_count}
    Log    ${actual_count}

    Should Contain    ${actual_count}    ${expected_count}

Switch to Specified subtab in Job Order Administration Page from tab
    [Arguments]    ${subtab}
    Wait For Page Ready
    Wait Until Page Contains Element       //li[text()='${subtab}']
    Click Element Safely                   //li[text()='${subtab}']
    Sleep    5s

Verify All New Labels
    [Arguments]    ${actual_tag}    ${expected_tag}
    ${elements}=    Get WebElements    //span[text()='${actual_tag}']
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Log    ${text}
        Log    ${expected_tag}
        Should Be Equal    ${text}    ${expected_tag}

    END

Select First Job Details from List and store Job Id
    Wait For Page Ready
    Wait Till Element Visible    ${FIRST_JOB_LOCATOR}    50s
    ${txt}=    Get Text    ${FIRST_JOB_LOCATOR}
    Log    Selected job text: ${txt}
    # Extract digits from text
    ${digits}=    Get Regexp Matches    ${txt}    \\d+
    ${count}=    Get Length    ${digits}
    Run Keyword If    ${count} == 0    Fail    No Job ID found in text: ${txt}
    ${JOB_ID}=    Set Variable    ${digits}[0]
    # Store as global variable
    Set Global Variable    ${JOB_ID}
    # Log Job ID
    Log    Job ID: ${JOB_ID}
    Wait For Page Ready


Enter Job Id in Search box and apply search
    Wait For Page Ready
    Wait Till Element Visible    ${JOBS_PAGE_SEARCH_INPUT}
    Click Element                ${JOBS_PAGE_SEARCH_INPUT}
    Clear Element Text           ${JOBS_PAGE_SEARCH_INPUT}
    Input Text                   ${JOBS_PAGE_SEARCH_INPUT}    ${JOB_ID}
    Wait For Page Ready
    Sleep                        2s
    
validate Job Id searched accurately
    Wait For Page Ready
    Wait Till Element Visible    ${FIRST_JOB_LOCATOR}    50s
    ${txt}=    Get Text    ${FIRST_JOB_LOCATOR}
    # Extract digits from text
    ${digits}=    Get Regexp Matches    ${txt}    \\d+
    ${count}=    Get Length    ${digits}
    Run Keyword If    ${count} == 0    Fail    No Job ID found in text: ${txt}
    ${ACTUAL_JOB_ID}=    Set Variable    ${digits}[0]
    # Store as global variable
    Set Global Variable    ${ACTUAL_JOB_ID}
    # Log Job ID
    Log    Actual Job ID: ${ACTUAL_JOB_ID}
    Log    Expected Job ID: ${JOB_ID}
    Wait For Page Ready  
    Should Be Equal    ${ACTUAL_JOB_ID}    ${JOB_ID}

validate data searched accurately by column filter for status
    [Arguments]        ${column_name}    ${expected_value}
    ${i}=    Get Column Index By Header Text      ${JOBS_HEADERS}    ${column_name}
    ${elements}=    Get WebElements    //td[${i}]
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Log    ${text}
        Log    ${expected_value}
        Should Be Equal    ${text}    ${expected_value}
    END

Enter Value in column filter search box
    [Arguments]    ${SEARCH_VALUE}
    Wait For Page Ready
    Wait Till Element Visible   ${COLUMN_FILTER_TEXT_FIELD}
    Input Text    ${COLUMN_FILTER_TEXT_FIELD}    ${SEARCH_VALUE}

select searched value
    Wait For Page Ready
    Wait Till Element Visible    ${CHECK_ALL_COLUMN_FILTER}
    Click Element Safely         ${CHECK_ALL_COLUMN_FILTER}
    Wait For Page Ready

click on filter button on column filter
    Wait For Page Ready
    Wait Till Element Visible    ${SELECT_FILTER_0N_COLUMN_FILTER}
    Click Element Safely         ${SELECT_FILTER_0N_COLUMN_FILTER}
    Wait For Page Ready
    
select start Date from dropdown on jobs page
    Wait For Page Ready
    Wait Till Element Visible   ${START_DATE_DROPDOWN_LOCATOR}    50s
    From Dropdown Verify or Select an Option    ${START_DATE_DROPDOWN_LOCATOR}    ${START_DATE_OPTIONS}    Next Two Weeks    select
    Wait For Page Ready
  
    
Verify Dates On Page Are Within Range
    [Arguments]    ${DAYS}=14    ${DATE_FORMAT}=%m/%d/%Y
    # Get today's date
    ${today}=    Get Current Date    result_format=%Y-%m-%d
    Log    Today's date: ${today}
    # Get all elements on page (limit this XPath if needed for performance)
    ${elements}=    Get WebElements    //*
    ${validated_dates}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        # Extract all MM/DD/YYYY dates from text
        ${dates}=    Get Regexp Matches    ${text}    \\d{2}/\\d{2}/\\d{4}
        FOR    ${date_str}    IN    @{dates}
            Log    Validating date: ${date_str}
            # Convert date string to ISO format
            ${parsed_date}=    Convert Date
            ...    ${date_str}
            ...    date_format=${DATE_FORMAT}
            ...    result_format=%Y-%m-%d
            # Calculate difference in seconds
            ${diff_seconds}=    Subtract Date From Date    ${parsed_date}    ${today}
            # Convert seconds to absolute days
            ${diff_days}=    Evaluate    abs(${diff_seconds}) / 86400
            Log    Date difference (days): ${diff_days}
            # Validate range
            Run Keyword If    ${diff_days} > ${DAYS}
            ...    Fail    Date ${date_str} is outside ${DAYS} days range
            Append To List    ${validated_dates}    ${date_str}
        END
    END
    ${count}=    Get Length    ${validated_dates}
    Run Keyword If    ${count} == 0
    ...    Fail    No valid MM/DD/YYYY dates found on page
    Log    Total validated dates: ${count}


select tag from dropdown on jobs page
    Wait For Page Ready
    Wait Till Element Visible   ${TAG_DROPDOWN_LOCATOR}    50s
    From Dropdown Verify or Select an Option    ${TAG_DROPDOWN_LOCATOR}    ${TAGS_OPTIONS}   HCMC    select
    Wait For Page Ready
    Wait Till Element Visible       //h1[text()='Job Order Administration']
    Click Element                   //h1[text()='Job Order Administration']
    Wait For Page Ready

from left pane open job details page
    Wait For Page Ready
    Wait Till Element Visible    ${LEFT_PANE_JOB_ELEMENT}
    Click Element Safely         ${LEFT_PANE_JOB_ELEMENT}
    Wait For Page Ready
    
validate tag should be present in job
    [Arguments]    ${EXPECTED_TAG}
    Wait For Page Ready
    Wait Till Element Visible    //div[text()='Add up to 5 tags (optional)']
    Scroll Element Into View     //div[text()='Add up to 5 tags (optional)']
    Wait Till Element Visible    ${ACTUAL_TAGS_LIST}
    ${elements}=    Get WebElements    ${ACTUAL_TAGS_LIST}   
    @{texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${text}=    Strip String    ${text}
        Append To List    ${texts}    ${text}
    END
    Log                          ${texts}
    Log                          ${EXPECTED_TAG}
    List Should Contain Value    ${texts}    ${EXPECTED_TAG}
    Wait For Page Ready
    
open job details page from all jobs requisition tab
    Wait For Page Ready
    Wait Till Element Visible    ${JOBREQ_1ST_JOB}
    Scroll Element Into View     ${JOBREQ_1ST_JOB}
    Click Element                ${JOBREQ_1ST_JOB}
    Wait For Page Ready
    
Validate count on jobs page
    [Arguments]    ${EXPECTED_COUNT}
    Wait For Page Ready
    Wait Till Element Visible    //h1[text()='Job Order Administration']

    ${elements}=    Get WebElements    ${ACTUAL_COUNT_ELEMENTS}
    ${ACTUAL_COUNT}=    Get Length    ${elements}

    ${EXPECTED_COUNT}=    Convert To Integer    ${EXPECTED_COUNT}

    Log    Actual Count: ${ACTUAL_COUNT}
    Log    Expected Count: ${EXPECTED_COUNT}

    Should Be True    ${ACTUAL_COUNT} <= ${EXPECTED_COUNT}
    ...    Actual count ${ACTUAL_COUNT} is greater than expected ${EXPECTED_COUNT}
    Wait For Page Ready
    
select items per page from dropdown on jobs listing page
    [Arguments]    ${ITEM_PER_PAGE_COUNT}
    Wait For Page Ready
    Wait Till Element Visible   ${ITEMS_PER_PAGE_DROPDOWN_LOCATOR}    50s
    From Dropdown Verify or Select an Option    ${ITEMS_PER_PAGE_DROPDOWN_LOCATOR}    ${ITEMS_PER_PAGE_OPTIONS}   ${ITEM_PER_PAGE_COUNT}   select
    Wait For Page Ready

#navigate to next page on jobs listing page
#    [Arguments]    ${NEXT_PAGE_NUMBER}
#    Wait For Page Ready
#    Wait Till Element Visible        //button[contains(@class,'k-button k-button')]//span[text()='${NEXT_PAGE_NUMBER}']
#    Wait For Page Ready
#    Click Element Safely             //button[contains(@class,'k-button k-button')]//span[text()='${NEXT_PAGE_NUMBER}']
#    Wait For Page Ready


    
Get Total Items From Pager And Store the count
    [Arguments]    ${LOCATOR}=//span[@class='k-pager-info']
    Wait Until Element Is Visible    ${LOCATOR}    10s
    ${text}=    Get Text    ${LOCATOR}
    ${text}=    Strip String    ${text}
    Log    Pager Text: ${text}
    # IMPORTANT: Escape backslash
    ${numbers}=    Get Regexp Matches    ${text}    \\d+
    Log    Numbers Extracted: ${numbers}
    ${length}=    Get Length    ${numbers}
    Run Keyword If    ${length} < 1
    ...    Fail    Could not extract total count from pager text: ${text}
    ${index}=    Evaluate    ${length} - 1
    ${TOTAL_ITEMS_ON_PAGE}=    Get From List    ${numbers}    ${index}
    ${TOTAL_ITEMS_ON_PAGE}=    Convert To Integer    ${TOTAL_ITEMS_ON_PAGE}
    Set Suite Variable    ${TOTAL_ITEMS_ON_PAGE}
    Log     Total Items On Page: ${TOTAL_ITEMS_ON_PAGE}

Navigate To Next Page On Jobs Listing Page
    [Arguments]    ${NEXT_PAGE_NUMBER}
    Wait For Page Ready
    Wait Until Element Is Visible
    ...    //button[contains(@class,'k-button')]//span[normalize-space()='${NEXT_PAGE_NUMBER}']
    ...    10s
    Click Element Safely
    ...    //button[contains(@class,'k-button')]//span[normalize-space()='${NEXT_PAGE_NUMBER}']
    Wait For Page Ready

Check And Navigate to next page If Item Count Exceeds
    [Arguments]    ${MAX_ITEMS_PER_PAGE}    ${PAGE_NUMBER}

    Get Total Items From Pager And Store the count

    ${TOTAL_ITEMS_ON_PAGE}=    Convert To Integer    ${TOTAL_ITEMS_ON_PAGE}
    ${MAX_ITEMS_PER_PAGE}=     Convert To Integer    ${MAX_ITEMS_PER_PAGE}

    IF    ${TOTAL_ITEMS_ON_PAGE} > ${MAX_ITEMS_PER_PAGE}
        Log    Items exceed ${MAX_ITEMS_PER_PAGE}. Navigating to page ${PAGE_NUMBER}.
        Navigate To Next Page On Jobs Listing Page    ${PAGE_NUMBER}
    ELSE
        Log    No items more than ${MAX_ITEMS_PER_PAGE} found hence cant navigate to page ${PAGE_NUMBER}
    END



Click Jobs Where Open Less Than Total
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    Wait For Page Ready

    FOR    ${index}    IN RANGE    1    ${count}+1

        ${text}=    Get Text    (//span[@class='job-positions'])[${index}]
        Log    --------------------------------------------------
        Log    Job Index: ${index}
        Log    ${text}
        Wait For Page Ready

        # Example: "6 Open / 6 Total Positions"
        ${parts}=        Split String    ${text}    /
        ${open_part}=    Strip String    ${parts}[0]
        ${total_part}=   Strip String    ${parts}[1]
        Wait For Page Ready

        ${open}=     Evaluate    int($open_part.split()[0])
        ${total}=    Evaluate    int($total_part.split()[0])
        Wait For Page Ready

        Log    Open Positions: ${open}
        Log    Total Positions: ${total}
        Wait For Page Ready

        IF    ${open} < ${total}

            Log    Condition satisfied → Processing job ${index}
            Wait For Page Ready

            ${job_xpath}=    Set Variable
            ...    (//span[contains(@class,'name-col')])[${index}]

            # Close overlay if present
            ${overlay_present}=    Run Keyword And Return Status
            ...    Element Should Be Visible
            ...    //div[contains(@class,'slide-pane__overlay')]

            IF    ${overlay_present}
                Log    Overlay detected - closing it
                Click Element    //div[contains(@class,'slide-pane__close')]
                Wait Until Element Is Not Visible
                ...    //div[contains(@class,'slide-pane__overlay')]
                ...    timeout=15s
            END

            Wait Until Element Is Visible    ${job_xpath}
            Scroll Element Into View         ${job_xpath}
            Click Element                    ${job_xpath}

            # Wait for slide pane content to load
            Wait Until Element Is Visible
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ...    timeout=15s

            Sleep    5s

            # Get Pending Start count
            ${pending_start_text}=    Get Text
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ${pending_start_count}=    Evaluate    int($pending_start_text)

            # Get Cleared To Start count
            ${cleared_to_start_text}=    Get Text
            ...    //span[text()='Cleared To Start']/..//span[@class='filter-counter']
            ${cleared_to_start_count}=    Evaluate    int($cleared_to_start_text)

            Log    Pending Start Count: ${pending_start_count}
            Log    Cleared To Start Count: ${cleared_to_start_count}

            # Count ALL "On Assignment"
            ${on_assignment_count}=    Get Element Count
            ...    //span[contains(text(),'On Assignment')]

            Log    On Assignment Count: ${on_assignment_count}

            # Total candidate count
            ${total_candidate_count}=    Evaluate
            ...    $pending_start_count + $cleared_to_start_count + $on_assignment_count

            Log    Total Candidate Count: ${total_candidate_count}

            # Final calculation
            ${calculated_total}=    Evaluate
            ...    $open + $total_candidate_count

            Log    Calculated Total (Open + Candidates): ${calculated_total}

            # Final validation
            Should Be Equal As Integers
            ...    ${calculated_total}
            ...    ${total}
            ...    msg=Mismatch! Open (${open}) + Candidates (${total_candidate_count}) != Total (${total})

        END

    END

click on save as dropdown to select save as draft job option
    Wait For Page Ready
    Wait Till Element Visible    ${SAVE_AS_DROPDOWN_LOCATOR}
    Wait For Page Ready
    Click Element                ${SAVE_AS_DROPDOWN_LOCATOR}
    Wait For Page Ready
    Sleep    1s
    Wait Till Element Visible    ${SAVE_AS_DRAFT_LOCATOR}
    Click Element                ${SAVE_AS_DRAFT_LOCATOR}
    Sleep    1s
    Wait For Page Ready


Click All Jobs And Validate Total Equals Job Is Offered

    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    Wait For Page Ready

    FOR    ${index}    IN RANGE    1    ${count}+1

        ${text}=    Get Text    (//span[@class='job-positions'])[${index}]
        Log    --------------------------------------------------
        Log    Job Index: ${index}
        Log    ${text}

        # Example: "6 Open / 6 Total Positions"
        ${parts}=        Split String    ${text}    /
        ${open_part}=    Strip String    ${parts}[0]
        ${total_part}=   Strip String    ${parts}[1]

        ${open}=     Evaluate    int($open_part.split()[0])
        ${total}=    Evaluate    int($total_part.split()[0])

        Log    Open Positions: ${open}
        Log    Total Positions: ${total}

        ${job_xpath}=    Set Variable
        ...    (//span[contains(@class,'name-col')])[${index}]

        #  Close overlay if present
        ${overlay_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane__overlay')]

        IF    ${overlay_present}
            Log    Overlay detected - closing it
            Wait For Page Ready
            Click Element    //div[contains(@class,'slide-pane__close')]
            Wait For Page Ready
            Wait Until Element Is Not Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            ...    timeout=15s
        END

        Wait Until Element Is Visible    ${job_xpath}
        Scroll Element Into View         ${job_xpath}
        Wait For Page Ready
        Click Element                    ${job_xpath}
        Wait For Page Ready
        #  Wait for slide pane
        Wait Until Element Is Visible
        ...    //div[contains(@class,'slide-pane')]
        ...    timeout=15s
        Wait For Page Ready
        Sleep    2s

        #  Count all "Job is Offered" inside slide pane
        Wait For Page Ready
        Wait Till Element Visible    //span[text()='Job Offered']/..//span[@class='filter-counter']
        Wait For Page Ready
        ${job_is_offered_text}=     Get Text    //span[text()='Job Offered']/..//span[@class='filter-counter']
        ${job_is_offered_count}=    Evaluate         int($job_is_offered_text.strip())
        Log    Job is Offered Count: ${job_is_offered_count}
        Wait For Page Ready
        #  Final Validation
        Wait For Page Ready
        Should Be Equal As Integers
        ...    ${total}
        ...    ${job_is_offered_count}
        ...    msg=Mismatch! Total (${total}) != Job is Offered Count (${job_is_offered_count})
        Wait For Page Ready
    END


validate that extend offer button is disabled
    Wait For Page Ready
    Wait Till Element Visible    ${EXTEND_OFFER_BUTTON_LOCATOR}
    Wait For Page Ready
    Click Element Safely         ${EXTEND_OFFER_BUTTON_LOCATOR}
    Wait Till Element Visible     ${ERROR_MSG_LOCATOR}
    Element Should Contain
    ...    ${ERROR_MSG_LOCATOR}
    ...    The positions for this job are filled.

Click And Open Talent With Applied Status In All Jobs
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    ${applied_found}=    Set Variable    ${False}

    FOR    ${index}    IN RANGE    1    ${count}+1
        Wait For Page Ready
        ${job_xpath}=    Set Variable
        ...    (//span[contains(@class,'name-col')])[${index}]
        Wait For Page Ready
        ${overlay_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane__overlay')]
        Wait For Page Ready
        IF    ${overlay_present}
            Wait For Page Ready
            Click Element    //div[contains(@class,'slide-pane__close')]
            Wait Until Element Is Not Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            ...    timeout=15s
        END
        Wait For Page Ready
        Wait Until Element Is Visible    ${job_xpath}
        Wait For Page Ready
        Click Element    ${job_xpath}
        Wait For Page Ready
        Wait Until Element Is Visible
        ...    //div[contains(@class,'slide-pane')]
        ...    timeout=15s
        Wait For Page Ready
        ${applied_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane')]//span[normalize-space()='Applied']
        Wait For Page Ready
        IF    ${applied_present}
            Wait For Page Ready
            Log    Applied talent found in Job Index ${index}
            ${applied_found}=    Set Variable    ${True}
            Wait For Page Ready
            Click Element
            ...    //div[contains(@class,'slide-pane')]//span[normalize-space()='Applied']/../../..//a
            Wait For Page Ready
            Exit For Loop
            Wait For Page Ready
        END

    END
            
    IF    not ${applied_found}
        Log    No talents with applied status found on offers pending job please create test data
    END

    [Return]    ${applied_found}

Click Jobs Where Open Less Than Total for offers accepted new jobs
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    Wait For Page Ready

    FOR    ${index}    IN RANGE    1    ${count}+1

        ${text}=    Get Text    (//span[@class='job-positions'])[${index}]
        Log    --------------------------------------------------
        Log    Job Index: ${index}
        Log    ${text}
        Wait For Page Ready

        # Example: "6 Open / 6 Total Positions"
        ${parts}=        Split String    ${text}    /
        ${open_part}=    Strip String    ${parts}[0]
        ${total_part}=   Strip String    ${parts}[1]
        Wait For Page Ready

        ${open}=     Evaluate    int($open_part.split()[0])
        ${total}=    Evaluate    int($total_part.split()[0])
        Wait For Page Ready

        Log    Open Positions: ${open}
        Log    Total Positions: ${total}
        Wait For Page Ready

        IF    ${open} < ${total}

            Log    Condition satisfied → Processing job ${index}
            Wait For Page Ready

            ${job_xpath}=    Set Variable
            ...    (//span[contains(@class,'name-col')])[${index}]

            # Close overlay if present
            ${overlay_present}=    Run Keyword And Return Status
            ...    Element Should Be Visible
            ...    //div[contains(@class,'slide-pane__overlay')]

            IF    ${overlay_present}
                Log    Overlay detected - closing it
                Click Element    //div[contains(@class,'slide-pane__close')]
                Wait Until Element Is Not Visible
                ...    //div[contains(@class,'slide-pane__overlay')]
                ...    timeout=15s
            END

            Wait Until Element Is Visible    ${job_xpath}
            Scroll Element Into View         ${job_xpath}
            Click Element                    ${job_xpath}

            # Wait for slide pane content to load
            Wait Until Element Is Visible
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ...    timeout=15s

            Sleep    5s

            # Get Pending Start count
            ${pending_start_text}=    Get Text
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ${pending_start_count}=    Evaluate    int($pending_start_text)

            # Get Cleared To Start count
            ${cleared_to_start_text}=    Get Text
            ...    //span[text()='Cleared To Start']/..//span[@class='filter-counter']
            ${cleared_to_start_count}=    Evaluate    int($cleared_to_start_text)

            # Count ALL "On Assignment"
            ${on_assignment_text}=    Get Text
            ...    //span[text()='On Assignment']/..//span[@class='filter-counter']
            ${on_assignment_count}=    Evaluate    int($on_assignment_text)

            Log    Pending Start Count: ${pending_start_count}
            Log    Cleared To Start Count: ${cleared_to_start_count}
            Log    On Assignment Count: ${on_assignment_count}

            # Total candidate count
            ${total_candidate_count}=    Evaluate
            ...    $pending_start_count + $cleared_to_start_count + $on_assignment_count
            Log    Total Candidate Count: ${total_candidate_count}
            # Final validation
            Should Be Equal As Integers
            ...    ${total_candidate_count}
            ...    ${total}
            ...    Candidates (${total_candidate_count}) != Total (${total})

        END

    END


Click Jobs Where Open Less Than Total for offers accepted extension jobs
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    Wait For Page Ready
    FOR    ${index}    IN RANGE    1    ${count}+1

        ${text}=    Get Text    (//span[@class='job-positions'])[${index}]
        Log    --------------------------------------------------
        Log    Job Index: ${index}
        Log    ${text}
        Wait For Page Ready

        # Example: "6 Open / 6 Total Positions"
        ${parts}=        Split String    ${text}    /
        ${open_part}=    Strip String    ${parts}[0]
        ${total_part}=   Strip String    ${parts}[1]
        Wait For Page Ready

        ${open}=     Evaluate    int($open_part.split()[0])
        ${total}=    Evaluate    int($total_part.split()[0])
        Wait For Page Ready

        Log    Open Positions: ${open}
        Log    Total Positions: ${total}
        Wait For Page Ready

        IF    ${open} < ${total}

            Log    Condition satisfied → Processing job ${index}
            Wait For Page Ready

            ${job_xpath}=    Set Variable
            ...    (//span[contains(@class,'name-col')])[${index}]

            # Close overlay if present
            ${overlay_present}=    Run Keyword And Return Status
            ...    Element Should Be Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            IF    ${overlay_present}
                Log    Overlay detected - closing it
                Click Element    //div[contains(@class,'slide-pane__close')]
                Wait Until Element Is Not Visible
                ...    //div[contains(@class,'slide-pane__overlay')]
                ...    timeout=15s
            END
            Wait Until Element Is Visible    ${job_xpath}
            Scroll Element Into View         ${job_xpath}
            Click Element                    ${job_xpath}
            # Wait for slide pane content to load
            Wait Until Element Is Visible
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ...    timeout=15s
            Sleep    5s
            # Get Pending Start count
            ${pending_start_text}=    Get Text
            ...    //span[text()='Pending Start']/..//span[@class='filter-counter']
            ${pending_start_count}=    Evaluate    int($pending_start_text)
            # Get Cleared To Start count
            ${cleared_to_start_text}=    Get Text
            ...    //span[text()='Cleared To Start']/..//span[@class='filter-counter']
            ${cleared_to_start_count}=    Evaluate    int($cleared_to_start_text)
            Log    Pending Start Count: ${pending_start_count}
            Log    Cleared To Start Count: ${cleared_to_start_count}
            # Total candidate count
            ${total_candidate_count}=    Evaluate
            ...    $pending_start_count + $cleared_to_start_count
            Log    Total Candidate Count: ${total_candidate_count}
            # Final validation
            Should Be Equal As Integers
            ...    ${total_candidate_count}
            ...    ${total}
            ...    Candidates (${total_candidate_count}) != Total (${total})

        END

    END

navigate to job Details page on all jobs requisition page
    Wait For Page Ready
    Wait Till Element Visible    ${FIRST_JOB_ALL_JOB_REQ_LOCATOR}
    Click Element Safely         ${FIRST_JOB_ALL_JOB_REQ_LOCATOR}
    Wait For Page Ready

apply filter on job details page
    [Arguments]    ${column_value}
    Wait For Page Ready
#    Sleep    5s
    Wait Till Element Enabled    ${FILTER_BTN_JOB_DETAILS_PAGE}
    Wait Till Element Visible    ${FILTER_BTN_JOB_DETAILS_PAGE}
    Wait For Page Ready
    Click Element Safely         ${FILTER_BTN_JOB_DETAILS_PAGE}
    Wait For Page Ready
    Wait Till Element Visible     //label[normalize-space()='${column_value}']
    Wait For Page Ready
    Click Element Safely          //label[normalize-space()='${column_value}']
    Wait For Page Ready
    Click Outside To Close Popup
    Wait For Page Ready


open filled job details and validate status of all jobs

    Wait Until Page Contains Element    (//span[normalize-space()='Filled']/..//a)
    ${job_count}=    Get Element Count    (//span[normalize-space()='Filled']/..//a)
    Log    Total Filled Jobs Found: ${job_count}

    FOR    ${index}    IN RANGE    1    ${job_count}+1

        Log    Checking Job Index: ${index}

        ${job_xpath}=    Set Variable
        ...    (//span[normalize-space()='Filled']/..//a)[${index}]

        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
        Wait For Page Ready
        Click Element    ${job_xpath}
        Wait For Page Ready

        # Get positions text (example: 0 open / 1 total positions)
        ${positions_text}=    Get Text
        ...    //td[contains(@class,'me-2')]//span[contains(@class,'viewpage-info-text')]

        Log    Positions Text: ${positions_text}

        # Extract total safely (NO REGEX)
        ${total}=    Evaluate
        ...    int("${positions_text}".split("/")[-1].strip().split(" ")[0])

        Log    Total Positions From UI: ${total}

        # Count talent cards
        ${actual_count}=    Get Element Count
        ...    //span[@class='d-flex flex-column']

        Log    Talent Cards Found: ${actual_count}

        Should Be Equal As Integers
        ...    ${actual_count}
        ...    ${total}
        ...    Talent count (${actual_count}) != Total positions (${total})

        Log    Counts Match

        # Click Next only if NOT last job
        IF    ${index} < ${job_count}
            Wait For Page Ready
            Click Element
            ...    //button[contains(@class,'k-button k-button-md k-button-solid k-button-solid-primary k-rounded-md pr-outline-btn ms-2 mb-3')]
            Wait For Page Ready
        END

    END

change status to failed to start for offers accepted talents
    Wait For Page Ready
    Wait Till Element Visible    //button[@id='talent-action']
    Click Element Safely         //button[@id='talent-action']
    Wait For Page Ready
    Wait Till Element Visible    //span[text()='Failed to Start']
    Click Element Safely         //span[text()='Failed to Start']
    Wait For Page Ready
    Wait Till Element Visible    //textarea[@name='comment']
    Input Text                   //textarea[@name='comment']            test
    Wait For Page Ready
    Wait Till Element Visible     //button[.//span[normalize-space()='Submit']]
    Click Element Safely          //button[.//span[normalize-space()='Submit']]
    Wait For Page Ready
    Sleep    5s


Click All Jobs And select Internal talent with status give in argument
    [Arguments]    ${job_status}
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    ${talent_found}=    Set Variable    ${False}

    FOR    ${index}    IN RANGE    1    ${count}+1
        Log    --------------------------------------------------
        Log    Checking Job Index: ${index}
        Wait For Page Ready
        ${job_xpath}=    Set Variable
        ...    (//span[contains(@class,'name-col')])[${index}]
        Wait For Page Ready
        # Close overlay if present
        ${overlay_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane__overlay')]
        Wait For Page Ready
        IF    ${overlay_present}
            Wait For Page Ready
            Click Element    //div[contains(@class,'slide-pane__close')]
            Wait For Page Ready
            Wait Until Element Is Not Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            ...    timeout=15s
        END

        # Click Job
        Wait For Page Ready
        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
        Wait For Page Ready
        Scroll Element Into View         ${job_xpath}
        Wait For Page Ready
        Click Element                    ${job_xpath}
        Wait For Page Ready

        # Wait for slide pane
        Wait For Page Ready
        Wait Until Element Is Visible
        ...    //div[contains(@class,'slide-pane')]
        ...    timeout=15s
        Wait For Page Ready

        # Get Vendor Type
        Wait For Page Ready
        Wait Until Page Contains Element    //span[@class='me-3']
        Wait For Page Ready
        ${internal_vendor_talent}=    Get Text    //span[@class='me-3']
        Wait For Page Ready
        ${internal_vendor_talent}=    Strip String    ${internal_vendor_talent}
        Wait For Page Ready
        Log    Vendor Type: ${internal_vendor_talent}

        # Check Offer Accepted status
        Wait For Page Ready
        ${offer_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    (//div[@class='position-relative']//span[text()='${job_status}'])[1]

        # Check Vendor is Internal
        Wait For Page Ready
        ${is_internal_vendor}=    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${internal_vendor_talent}
        ...    Vendor: Internal

        # Combined condition
        Wait For Page Ready
        IF    ${offer_present} and ${is_internal_vendor}
            Wait For Page Ready
            Log    Offer Accepted AND Vendor: Internal found in Job Index ${index}
            Wait For Page Ready
            ${job_id}=    Get Text
            ...    //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
            Set Suite Variable    ${job_id}    ${job_id}
            Log    Selected Job: ${job_id}
            Wait For Page Ready
            Click Element
            ...    (//div[@class='position-relative']//span[text()='${job_status}']/../../..//a)[1]

            Wait For Page Ready
            ${talent_found}=    Set Variable    ${True}
            Exit For Loop

        ELSE
            Log    Condition not met ${job_status} not found OR Internal talent not found
        END

    END

    IF    not ${talent_found}
        Log    No Internal talent found in any job
    END

Click All Jobs And select Vendor talent with status give in argument
    [Arguments]    ${job_status}
    Wait For Page Ready
    ${count}=    Get Element Count    ${JOB_POSITIONS}
    ${talent_found}=    Set Variable    ${False}

    FOR    ${index}    IN RANGE    1    ${count}+1
        Log    --------------------------------------------------
        Log    Checking Job Index: ${index}
        Wait For Page Ready
        ${job_xpath}=    Set Variable
        ...    (//span[contains(@class,'name-col')])[${index}]
        Wait For Page Ready
        # Close overlay if present
        ${overlay_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane__overlay')]
        Wait For Page Ready
        IF    ${overlay_present}
            Wait For Page Ready
            Click Element    //div[contains(@class,'slide-pane__close')]
            Wait For Page Ready
            Wait Until Element Is Not Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            ...    timeout=15s
        END

        # Click Job
        Wait For Page Ready
        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
        Wait For Page Ready
        Scroll Element Into View         ${job_xpath}
        Wait For Page Ready
        Click Element                    ${job_xpath}
        Wait For Page Ready

        # Wait for slide pane
        Wait For Page Ready
        Wait Until Element Is Visible
        ...    //div[contains(@class,'slide-pane')]
        ...    timeout=15s
        Wait For Page Ready

        # Get Vendor Type
        Wait For Page Ready
        Wait Until Page Contains Element    //span[@class='me-3']
        Wait For Page Ready
        ${internal_vendor_talent}=    Get Text    //span[@class='me-3']
        Wait For Page Ready
        ${internal_vendor_talent}=    Strip String    ${internal_vendor_talent}
        Wait For Page Ready
        Log    Vendor Type: ${internal_vendor_talent}

        # Check Offer Accepted status
        Wait For Page Ready
        ${offer_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    (//div[@class='position-relative']//span[text()='${job_status}'])[1]

        # Check Vendor is Internal
        Wait For Page Ready
        ${is_vendor}=    Run Keyword And Return Status
        ...    Should Not Be Equal As Strings
        ...    ${internal_vendor_talent}
        ...    Vendor: Internal

        # Combined condition
        Wait For Page Ready
        IF    ${offer_present} and ${is_vendor}
            Wait For Page Ready
            Log    Offer Accepted AND Vendor: Talent found in Job Index ${index}
            Wait For Page Ready
            ${job_id}=    Get Text
            ...    //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
            Set Suite Variable    ${job_id}    ${job_id}
            Log    Selected Job: ${job_id}
            Wait For Page Ready
            Click Element
            ...    (//div[@class='position-relative']//span[text()='${job_status}']/../../..//a)[1]

            Wait For Page Ready
            ${talent_found}=    Set Variable    ${True}
            Exit For Loop

        ELSE
            Log    Condition not met ${job_status} not found OR Vendor talent not found
        END

    END

    IF    not ${talent_found}
        Log    No Vendor talent found in any job
    END

hospital withdraw offer for job is offered talent
    Wait For Page Ready
    Wait Till Element Visible    //button[@id='talent-action']
    Click Element Safely         //button[@id='talent-action']
    Wait For Page Ready
    Wait Till Element Visible    //span[text()='Withdraw Offer']
    Click Element Safely         //span[text()='Withdraw Offer']
    Wait For Page Ready
    Sleep    5s

validate job should be changed to open
    Wait For Page Ready

    ${count}=    Get Element Count    ${JOB_POSITIONS}
    ${talent_found}=    Set Variable    ${False}
    Wait For Page Ready
    FOR    ${index}    IN RANGE    1    2
        Wait For Page Ready
        Log    --------------------------------------------------
        Log    Checking Job Index: ${index}
        Wait For Page Ready
        ${job_xpath}=    Set Variable
        ...    (//span[contains(@class,'name-col')])[${index}]

        # Close overlay if present
        ${overlay_present}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    //div[contains(@class,'slide-pane__overlay')]

        IF    ${overlay_present}
            Wait For Page Ready
            Click Element    //div[contains(@class,'slide-pane__close')]
            Wait For Page Ready
            Wait Until Element Is Not Visible
            ...    //div[contains(@class,'slide-pane__overlay')]
            ...    timeout=15s
        END

        # Click Job
        Wait For Page Ready
        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
        Scroll Element Into View         ${job_xpath}
        Wait For Page Ready
        Click Element                    ${job_xpath}

        # Wait for slide pane
        Wait For Page Ready
        Wait Until Element Is Visible
        ...    //div[contains(@class,'slide-pane')]
        ...    timeout=15s

#        validate job status
        Wait For Page Ready
        ${job_status}=    Get Text    //span[contains(@class,'status-chips-w')]
        Log        ${job_status}
        Wait For Page Ready
        Should Be Equal   ${job_status}    Open
    END

#Click All Jobs And select talent with offers accepted status in offers accepted jobs
#    Wait For Page Ready
#    ${count}=    Get Element Count    ${JOB_POSITIONS}
#    ${talent_found}=    Set Variable    ${False}
#    Wait For Page Ready
#    FOR    ${index}    IN RANGE    1    ${count}+1
#        Wait For Page Ready
#        Log    --------------------------------------------------
#        Log    Checking Job Index: ${index}
#        Wait For Page Ready
#        ${job_xpath}=    Set Variable
#        ...    (//span[contains(@class,'name-col')])[${index}]
#
#        # Close overlay if present
#        ${overlay_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    //div[contains(@class,'slide-pane__overlay')]
#
#        IF    ${overlay_present}
#            Wait For Page Ready
#            Click Element    //div[contains(@class,'slide-pane__close')]
#            Wait For Page Ready
#            Wait Until Element Is Not Visible
#            ...    //div[contains(@class,'slide-pane__overlay')]
#            ...    timeout=15s
#        END
#
#        # Click Job
#        Wait For Page Ready
#        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
#        Scroll Element Into View         ${job_xpath}
#        Wait For Page Ready
#        Click Element                    ${job_xpath}
#
#        # Wait for slide pane
#        Wait For Page Ready
#        Wait Until Element Is Visible
#        ...    //div[contains(@class,'slide-pane')]
#        ...    timeout=15s
#
#        # Check if Offer Accepted talent exists
#        Wait For Page Ready
#        Wait Until Page Contains Element    //span[@class='me-3']
#        ${internal_vendor_talent}=    Get Text    //span[@class='me-3']
#        Log              ${internal_vendor_talent}
#        ${offer_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted'])[1]
#
#        IF    ${offer_present}
#
#            Log    Offer Accepted talent found in Job Index ${index}
#            Wait For Page Ready
#            ${job_offered_job_id}=    Get Text    //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
#            Set Suite Variable        ${job_offered_job_id}    ${job_offered_job_id}
#            Log                       ${job_offered_job_id}
#            Click Element
#            ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted']/../../..//a)[1]
#            Wait For Page Ready
#            ${talent_found}=    Set Variable    ${True}
#            Exit For Loop
#
#        ELSE
#            Log    No Offer Accepted talent found in Job Index ${index}
#        END
#
#    END
#
#    IF    not ${talent_found}
#        Log    No Offer Accepted talent found in any job
#    END



#Click All Jobs And select Internal talent with offers accepted status in offers accepted jobs
#    Wait For Page Ready
#    ${count}=    Get Element Count    ${JOB_POSITIONS}
#    ${talent_found}=    Set Variable    ${False}
#
#    FOR    ${index}    IN RANGE    1    ${count}+1
#        Log    --------------------------------------------------
#        Log    Checking Job Index: ${index}
#        Wait For Page Ready
#        ${job_xpath}=    Set Variable
#        ...    (//span[contains(@class,'name-col')])[${index}]
#        Wait For Page Ready
#        # Close overlay if present
#        ${overlay_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    //div[contains(@class,'slide-pane__overlay')]
#        Wait For Page Ready
#        IF    ${overlay_present}
#            Wait For Page Ready
#            Click Element    //div[contains(@class,'slide-pane__close')]
#            Wait For Page Ready
#            Wait Until Element Is Not Visible
#            ...    //div[contains(@class,'slide-pane__overlay')]
#            ...    timeout=15s
#        END
#
#        # Click Job
#        Wait For Page Ready
#        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
#        Wait For Page Ready
#        Scroll Element Into View         ${job_xpath}
#        Wait For Page Ready
#        Click Element                    ${job_xpath}
#        Wait For Page Ready
#
#        # Wait for slide pane
#        Wait For Page Ready
#        Wait Until Element Is Visible
#        ...    //div[contains(@class,'slide-pane')]
#        ...    timeout=15s
#        Wait For Page Ready
#
#        # Get Vendor Type
#        Wait For Page Ready
#        Wait Until Page Contains Element    //span[@class='me-3']
#        Wait For Page Ready
#        ${internal_vendor_talent}=    Get Text    //span[@class='me-3']
#        Wait For Page Ready
#        ${internal_vendor_talent}=    Strip String    ${internal_vendor_talent}
#        Wait For Page Ready
#        Log    Vendor Type: ${internal_vendor_talent}
#
#        # Check Offer Accepted status
#        Wait For Page Ready
#        ${offer_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted'])[1]
#
#        # Check Vendor is Internal
#        Wait For Page Ready
#        ${is_internal_vendor}=    Run Keyword And Return Status
#        ...    Should Be Equal As Strings
#        ...    ${internal_vendor_talent}
#        ...    Vendor: Internal
#
#        # Combined condition
#        Wait For Page Ready
#        IF    ${offer_present} and ${is_internal_vendor}
#            Wait For Page Ready
#            Log    Offer Accepted AND Vendor: Internal found in Job Index ${index}
#            Wait For Page Ready
#            ${job_offered_job_id}=    Get Text
#            ...    //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
#            Set Suite Variable    ${job_offered_job_id}    ${job_offered_job_id}
#            Log    Selected Job: ${job_offered_job_id}
#            Wait For Page Ready
#            Scroll Element Into View    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted']/../../..//a)[1]
#            Click Element
#            ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted']/../../..//a)[1]
#
#            Wait For Page Ready
#            ${talent_found}=    Set Variable    ${True}
#            Exit For Loop
#
#        ELSE
#            Log    Condition not met (Offer Accepted not found OR Vendor not Internal)
#        END
#
#    END
#
#    IF    not ${talent_found}
#        Log    No Offer Accepted talent with Vendor: Internal found in any job
#    END

#Click All Jobs And select Vendor talent with offers accepted status in offers accepted jobs
#    Wait For Page Ready
#    ${count}=    Get Element Count    ${JOB_POSITIONS}
#    Wait For Page Ready
#    ${talent_found}=    Set Variable    ${False}
#
#    FOR    ${index}    IN RANGE    1    ${count}+1
#        Log    --------------------------------------------------
#        Log    Checking Job Index: ${index}
#
#        ${job_xpath}=    Set Variable
#        ...    (//span[contains(@class,'name-col')])[${index}]
#
#        # Close overlay if present
#        Wait For Page Ready
#        ${overlay_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    //div[contains(@class,'slide-pane__overlay')]
#
#        IF    ${overlay_present}
#            Wait For Page Ready
#            Click Element    //div[contains(@class,'slide-pane__close')]
#            Wait Until Element Is Not Visible
#            ...    //div[contains(@class,'slide-pane__overlay')]
#            ...    timeout=15s
#            Wait For Page Ready
#        END
#
#        # Click Job
#        Wait For Page Ready
#        Wait Until Element Is Visible    ${job_xpath}    timeout=15s
#        Wait For Page Ready
#        Scroll Element Into View         ${job_xpath}
#        Wait For Page Ready
#        Click Element                    ${job_xpath}
#        Wait For Page Ready
#
#        # Wait for slide pane
#        Wait For Page Ready
#        Wait Until Element Is Visible
#        ...    //div[contains(@class,'slide-pane')]
#        ...    timeout=15s
#
#        # Get Vendor Type
#        Wait For Page Ready
#        Wait Until Page Contains Element    //span[@class='me-3']
#        Wait For Page Ready
#        ${internal_vendor_talent}=    Get Text    //span[@class='me-3']
#        Wait For Page Ready
#        ${internal_vendor_talent}=    Strip String    ${internal_vendor_talent}
#        Wait For Page Ready
#        Log    Vendor Type: ${internal_vendor_talent}
#        Wait For Page Ready
#
#        # Check Offer Accepted status
#        Wait For Page Ready
#        ${offer_present}=    Run Keyword And Return Status
#        ...    Element Should Be Visible
#        ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted'])[1]
#
#        # Check Vendor is Internal
#        Wait For Page Ready
#        ${is_internal_vendor}=    Run Keyword And Return Status
#        ...     Should Not Be Equal As Strings
#        ...    ${internal_vendor_talent}
#        ...    Vendor: Internal
#
#        # Combined condition
#        Wait For Page Ready
#        IF    ${offer_present} and ${is_internal_vendor}
#            Wait For Page Ready
#            Log    Offer Accepted AND Vendor: Internal found in Job Index ${index}
#            Wait For Page Ready
#            ${job_offered_job_id}=    Get Text
#            ...    //h2[@class='slide-pane-job-name m-0 pb-2 cursor-pointer']
#            Wait For Page Ready
#            Set Suite Variable    ${job_offered_job_id}    ${job_offered_job_id}
#            Log    Selected Job: ${job_offered_job_id}
#            Wait For Page Ready
#            Click Element
#            ...    (//span[@class='status-chips-wrapper offer-accepted' and text()='Offer Accepted']/../../..//a)[1]
#
#            Wait For Page Ready
#            ${talent_found}=    Set Variable    ${True}
#            Exit For Loop
#
#        ELSE
#            Log    Condition not met (Offer Accepted not found OR Vendor not Internal)
#        END
#
#    END
#
#    IF    not ${talent_found}
#        Log    No Offer Accepted talent with Vendor: Internal found in any job
#    END



    
    
    
    
    
