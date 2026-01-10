*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Example
    Open Browser    https://costrategi-security-qa2.internal-definitywfs.com/signin    chrome
    Maximize Browser Window
    Sleep    3s
    Close Browser
