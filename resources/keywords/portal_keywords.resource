*** Settings ***
Library     SeleniumLibrary
Resource    common_keywords.resource


*** Variables ***
${HEADER_SIGNIN}                 xpath://*[@id="root"]/div/div/div/div[2]/div[2]/h1
${INPUT_EMAIL_ADDRESS}           xpath://input[@name='emailAddress']
${INPUT_PASSWORD}                xpath://input[@name='password']
${BUTTON_LOGIN}                  xpath://button[@type='submit']
${HEADER_LETS_GET_STARTED}       xpath://h1[normalize-space()="Let's Get Started!"]
${INPUT_EMAIL_BY_LABEL}          xpath://label[normalize-space()='Email Address']/following::input[1]
${BUTTON_FIND_ACCOUNT}           xpath://button[normalize-space()='Find Account']
${HEADER_SIGNIN_MYDEF}                xpath://h1[normalize-space()='Sign In']
${INPUT_PASSWORD_MYDEF}          xpath://input[@type='password']

*** Keywords ***
Open Portal And Login To HCS
    [Arguments]    ${PORTAL}    
    
    ${user}=    Set Variable    ${PORTAL['user']}
     IF    '${APPROVER_USER}' != '' and '${APPROVER_USER}' != 'None'
        ${user}=    Set Variable    ${APPROVER_USER}
    END
#    Input Text Safely     ${INPUT_EMAIL_ADDRESS}    ${PORTAL['user']}
    Open Browser    ${PORTAL['url']}    chrome
    Maximize Browser Window
    Wait Till Element Visible    ${HEADER_SIGNIN}    50s
    Input Text Safely     ${INPUT_EMAIL_ADDRESS}    ${user}
    Input Text Safely     ${INPUT_PASSWORD}     ${PORTAL['pass']}
    Wait Till Element Enabled  ${BUTTON_LOGIN}    50s
    Click Element Safely   ${BUTTON_LOGIN}
    Sleep    5 sec
Open Portal And Login To Vms
    [Arguments]    ${PORTAL}
    Open Browser    ${PORTAL['url']}    chrome
    Maximize Browser Window
    Wait Till Element Visible    ${HEADER_SIGNIN}    50s
    Input Text Safely     ${INPUT_EMAIL_ADDRESS}    ${PORTAL['user']}
    Input Text Safely     ${INPUT_PASSWORD}     ${PORTAL['pass']}
    Wait Till Element Enabled  ${BUTTON_LOGIN}    50s
    Click Element Safely   ${BUTTON_LOGIN}
    Sleep    5 sec
Open Portal And Login To myDef
    [Arguments]    ${PORTAL}
    Open Browser    ${PORTAL['url']}    chrome
    Maximize Browser Window
    Wait Till Element Visible    ${HEADER_LETS_GET_STARTED}    50s
    Input Text Safely     ${INPUT_EMAIL_BY_LABEL}    ${PORTAL['user']}
    Wait Till Element Enabled  ${BUTTON_FIND_ACCOUNT}    50s
    Click Element Safely   ${BUTTON_FIND_ACCOUNT}
    Wait Till Element Visible    ${HEADER_SIGNIN_MYDEF}    50s
    Input Text Safely     ${INPUT_PASSWORD_MYDEF}     ${PORTAL['pass']}
    Wait Till Element Enabled  ${BUTTON_LOGIN}    50s
    Click Element Safely   ${BUTTON_LOGIN}
    Sleep    5 sec