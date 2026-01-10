*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Example
    Open Browser    https://google.com    chrome
    Title Should Be    Google
    Sleep    3s
    Close Browser
