*** Settings ***
Resource    ../../resources/pages/LoginPage/login.resource
Variables   ../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Login To HCS Portal
    Login To Portal    ${HCS}
