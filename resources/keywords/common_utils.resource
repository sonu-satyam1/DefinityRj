*** Settings ***
Library    DateTime

*** Keywords ***
Generate And Store Global Unique Name
    [Arguments]    ${prefix}    ${var_name}
    ${dt}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${name}=    Set Variable    ${prefix}_${dt}
    Set Global Variable    ${${var_name}}    ${name}
    RETURN    ${name}
