*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Example
    Open Browser    ${HCS_URL}    chrome
    Maximize Browser Window
    Sleep    3s
    Close Browser
