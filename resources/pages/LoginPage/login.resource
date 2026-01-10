*** Settings ***
Resource    ../../keywords/common_keywords.resource

*** Variables ***
${SIGN_IN_HEADER}       xpath://*[@id="root"]/div/div/div/div[2]/div[2]/h1
${EMAIL_TEXTBOX}        xpath://input[@name='emailAddress']
${PASSWORD_TEXTBOX}     xpath://input[@name='password']
${SIGN_IN_BTN}          xpath://button[@type='submit']



*** Keywords ***
Login To Portal
    [Arguments]    ${PORTAL}
    Open Browser And Maximize    ${PORTAL['url']}
    Wait Till Element Visible    ${SIGN_IN_HEADER}
    Input Text Safely    ${EMAIL_TEXTBOX}     ${PORTAL['user']}
    Input Text Safely    ${PASSWORD_TEXTBOX}  ${PORTAL['pass']}
    Wait And Click With Retry    ${SIGN_IN_BTN}
