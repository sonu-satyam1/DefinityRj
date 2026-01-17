*** Settings ***
Resource    ../../resources/pages/Login/loginPage.resource
Resource    ../../resources/pages/Welcome/welcomePage.resource
Resource    ../../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../../resources/pages/Settings/skillAdministrationPage.resource

Variables   ../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Test Cases ***
Validate Rapid Contract Option listed in JobType DropDown While Creating New Job
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    Verify Hiring Process Values have Button
    Select Random Skill Hiring Process Rules
    Verify Hiring Process Window Title

