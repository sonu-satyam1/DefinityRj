*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource


*** Variables ***
${3DOTS_DROPDOWN}                  xpath://div[@class='d-flex align-items-center justify-content-end flex-wrap']//button[.//span[contains(@class,'icon-more')]]
${JOB_OPTIONS}                     xpath://div[@role='button' and contains(@class,'watchers-list-item')]

*** Keywords ***
Verify Job Details Page Title
    [Arguments]    ${JOB_TITLE}
    Verify Page Title    ${JOB_TITLE}

Select Copy Job Option From Details
    Sleep    5s
    Wait Till Element Visible   ${3DOTS_DROPDOWN}    50s
    From Dropdown Verify or Select an Option    ${3DOTS_DROPDOWN}    ${JOB_OPTIONS}    Copy Job    select
    Wait For Page Ready
