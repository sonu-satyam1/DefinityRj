*** Settings ***
Library     SeleniumLibrary
Library    ../../../libs/RuntimeData.py
Resource    ../../keywords/common_keywords.resource
Resource    jobDetailsPage.resource


*** Variables ***
${HEADERS_SEARCH_BOX}                  xpath://div[contains(@class,'k-filter-menu-container')]//input[@placeholder='Search']
${FILTER_BUTTON_HEADERS}               xpath://div[contains(@class,'k-filter-menu-container')]//button[.//span[text()='Filter']]
${NO_RECORDS_TEXT}                     No records available
${HEADER_TITLES}                       xpath://table[contains(@class,'k-grid-header-table')]//span[@class='k-column-title']
${ROWS_XPATH}                          //table[contains(@class,'k-grid-table')]//tbody//tr

*** Keywords ***
Verify Job Orders Page Title in Vms
    Verify Page Title    Job Orders

Scroll Grid To Column
    [Arguments]    ${Header}
    ${xpath}=    Set Variable
    ...    //th[.//span[@class='k-column-title' and normalize-space()='${Header}']]

    Execute Javascript
    ...    var el = document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    el.scrollIntoView({behavior: "instant", block: "nearest", inline: "center"});

Scroll Grid To Bulk Column
    ${xpath}=    Set Variable    //th//input[@id='bulkCheck']

    Execute Javascript
    ...    var el = document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    el.scrollIntoView({behavior: "instant", block: "nearest", inline: "start"});


Apply Filter to Search for Specific Job Details in Vms
    [Arguments]    ${Header}    ${Search_txt}
    Wait For Page Ready
    ${column}=   Set Variable    xpath://th[.//span[@class='k-column-title' and normalize-space()='${Header}']]
    Wait Till Element Visible    ${column}
    ${3dots}=    Set Variable    xpath://th[.//span[@class='k-column-title' and normalize-space()='${Header}']]//span[contains(@class,'k-svg-i-more-vertical')]
    Wait Till Element Visible    ${3dots}
    Click Element Safely    ${3dots}
    Sleep    0.5s
    Wait Till Element Visible    ${HEADERS_SEARCH_BOX}
    Input Text Safely    ${HEADERS_SEARCH_BOX}    ${Search_txt}
    ${option}=    Set Variable
    ...    //ul[contains(@class,'k-multicheck-wrap')]//label[contains(normalize-space(.),'${Search_txt}')]
    Wait Till Element Visible    ${option}
    Click Element Safely    ${option}
    Wait Till Element Enabled    ${FILTER_BUTTON_HEADERS}
    Click Element Safely    ${FILTER_BUTTON_HEADERS}
    Wait For Page Ready

Select Search Result in vms
    [Arguments]    ${colName}
    Select First Result By Column    ${HEADER_TITLES}    ${colName}    ${ROWS_XPATH}    ${NO_RECORDS_TEXT}
    Wait For Page Ready

