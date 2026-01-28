*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py

Resource    ../../keywords/common_keywords.resource
Resource    ../../keywords/common_utils.resource
Resource    administrativeSettingsPage.resource

*** Variables ***
${BUSINESS_RULES_TAB}                 xpath://ul[@role='tablist']//span[normalize-space()='Business rules']
${APPROVAL_SELECTED_LABEL}            xpath://input[@name='approvalWorkflow' and @checked]/ancestor::span/following-sibling::label
${EDIT_BUTTON}                        xpath://button[.//span[normalize-space()='Edit']]
${SEQUENTIAL_RADIO_EDIT}              xpath://input[@name='approvalWorkflow' and @value='2']
${SAVE_BUTTON}                        xpath://button[normalize-space()='Save']

*** Keywords ***
Verify Organization Details Page Title
    Verify Page Title    Organization Details

Switch to Business rules tab in Organization Details Page
    Wait For Page Ready
    Click Element Safely        ${BUSINESS_RULES_TAB}
    Wait For Page Ready

Verify Or Set Approval Workflow As Sequential
    Wait For Page Ready

    ${current}=    Get Current Approval Workflow
    Log    Current approval workflow: ${current}

    IF    '${current}' == 'Sequential'
        Log    Approval workflow already Sequential. No action required.
        RETURN
    END

    Log    Approval workflow is not Sequential. Updating...

    Click Element Safely    ${EDIT_BUTTON}
    Wait For Page Ready
    Switch to Business rules tab in Organization Details Page

    Scroll Element Into View    ${SEQUENTIAL_RADIO_EDIT}
    Wait Till Element Enabled   ${SEQUENTIAL_RADIO_EDIT}    30s
    Click Element    ${SEQUENTIAL_RADIO_EDIT}

    Click Element Safely    ${SAVE_BUTTON}
    Wait For Page Ready
    Verify Administrative Settings Page Title

Get Current Approval Workflow
    Wait Till Element Visible    ${APPROVAL_SELECTED_LABEL}    30s
    ${txt}=    Get Text    ${APPROVAL_SELECTED_LABEL}
    ${txt}=    Strip String    ${txt}
    [Return]    ${txt}
