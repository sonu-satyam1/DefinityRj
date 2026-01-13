*** Settings ***
Library    SeleniumLibrary
Library    variables/

*** Test Cases ***
open the browser with specified url
    [Arguments]    ${url}
    Open Browser    ${HCS_URL}    chrome
    Maximize Browser Window
    Sleep    3s

