*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***
${JOB_TYPE_DROPDOWN_LOCATOR}  xpath://label[normalize-space(text())='Job Type']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${JOB_TYPE_OPTIONS_TEXT_LOCATOR}       xpath://ul[@id='contractTypelist']//li//span[@class='k-list-item-text']

*** Keywords ***
Verify Create a Job Order Page Title
    Verify Page Title    Create a Job Order

Verify Rapid Contract Job Type is Present
    From Dropdown Verify or Select an Option    ${JOB_TYPE_DROPDOWN_LOCATOR}    ${JOB_TYPE_OPTIONS_TEXT_LOCATOR}    Rapid Contract    verify

