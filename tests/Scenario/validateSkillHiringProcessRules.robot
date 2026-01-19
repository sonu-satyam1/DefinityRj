*** Settings ***
Library    ../../libs/RuntimeData.py
Resource    ../../resources/pages/Login/loginPage.resource
Resource    ../../resources/pages/Welcome/welcomePage.resource
Resource    ../../resources/pages/Settings/administrativeSettingsPage.resource
Resource    ../../resources/pages/Settings/skillAdministrationPage.resource

Variables   ../../resources/variables/environment/qa2.py
Test Teardown    Close Browser Safely

*** Variables ***
${ADD_RULE_BUTTON}    //button[text()='+ Add Rule']

*** Test Cases ***
Validate Skill Hiring Process Rules
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    Select Add Skill Button
    Input Uniq Skill Name
    select Clinical Option For Skill Category
    select Clinical Option For Skill Type
    Select Provided Job Type    Standard Contract
    Select Provided Talent Type    Vendor
    Select Provided Hiring Process    Resume
    Save Skill Details

Verify Two rules partition combos
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    PRN
    Select Multi Options In Rule    2    Talent Type    Vendor
    Select Single Option In Rule    2    Hiring Process    Resume
    Save Skill Details

Verify Three rules cover all combos
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract
    Select Multi Options In Rule    2    Talent Type    Vendor
    Select Single Option In Rule    2    Hiring Process    Interview
    Add Rule
    Select Multi Options In Rule    3    Job Type    PRN
    Select Multi Options In Rule    3    Talent Type    Internal    Vendor
    Select Single Option In Rule    3    Hiring Process    Auto Offer
    Input Hours to Offer Value    2    2
    Save Skill Details

Verify Multi-select grouping that still yields unique mapping
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract    PRN
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract
    Select Multi Options In Rule    2    Talent Type    Vendor
    Select Single Option In Rule    2    Hiring Process    Interview
    Add Rule
    Select Multi Options In Rule    3    Job Type    PRN
    Select Multi Options In Rule    3    Talent Type    Vendor
    Select Single Option In Rule    3    Hiring Process    Auto Offer
    Input Hours to Offer Value    2    2
    Save Skill Details

Verify Exact duplicate mapping in two rules
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract
    Select Multi Options In Rule    2    Talent Type    Internal
    Select Single Option In Rule    2    Hiring Process    Interview
    Save Skill Details
    Validate Error Message

Verify Overlapping multi-selects cause duplicate atomic combo
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract    PRN
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    PRN
    Select Multi Options In Rule    2    Talent Type    Internal    Vendor
    Select Single Option In Rule    2    Hiring Process    Interview
    Save Skill Details
    Validate Error Message

Verify Partial overlap where one atomic combo duplicates
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Vendor
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract    PRN
    Select Multi Options In Rule    2    Talent Type    Vendor
    Select Single Option In Rule    2    Hiring Process    Interview
    Save Skill Details
    Validate Error Message

Verify Missing explicit uniqueness in overlapping rules
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Vendor    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract
    Select Multi Options In Rule    2    Talent Type    Vendor
    Select Single Option In Rule    2    Hiring Process    Resume
    Save Skill Details
    Validate Error Message

Verify Exceeding allowed number of rules
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract
    Select Multi Options In Rule    1    Talent Type    Vendor
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    Standard Contract
    Select Multi Options In Rule    2    Talent Type    Internal
    Select Single Option In Rule    2    Hiring Process    Interview
    Add Rule
    Select Multi Options In Rule    3    Job Type    PRN
    Select Multi Options In Rule    3    Talent Type    Vendor
    Select Single Option In Rule    3    Hiring Process    Resume
    Add Rule
    Scroll To View Element    ${ADD_RULE_BUTTON}
    Select Multi Options In Rule    4    Job Type    PRN
    Select Multi Options In Rule    4    Talent Type    Internal
    Select Single Option In Rule    4    Hiring Process    Interview
    Scroll To View Element    ${ADD_RULE_BUTTON}
    Element Should Be Disabled   ${ADD_RULE_BUTTON}

Verify Overlapping multi-selects causing multiple duplicates
    Login To Portal    HCS    ${HCS}
    Click Feature Menu Option    Settings
    Verify Administrative Settings Page Title
    Select Option from Skills Credentials and Pay Rates    Skills Administration
    Verify Skill Administration Page Title
    ${skill}=    RuntimeData.Get Value    SKILL_NAME
    Select Specified Skill    ${skill}
    Edit Skill Details
    Clear Inputs Rules
    Select Multi Options In Rule    1    Job Type    Standard Contract    PRN
    Select Multi Options In Rule    1    Talent Type    Internal
    Select Single Option In Rule    1    Hiring Process    Resume
    Add Rule
    Select Multi Options In Rule    2    Job Type    PRN
    Select Multi Options In Rule    2    Talent Type    Internal    Vendor
    Select Single Option In Rule    2    Hiring Process    Interview
    Save Skill Details
    Validate Error Message