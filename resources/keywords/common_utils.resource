*** Settings ***
Library    DateTime
Library    ../../libs/RuntimeData.py
Resource    common_keywords.resource
*** Keywords ***
Generate And Store Global Unique Name
    [Arguments]    ${prefix}    ${key}
    ${dt}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${name}=    Set Variable    ${prefix}_${dt}

    Set Suite Variable    ${${key}}    ${name}
    Save Value    ${key}    ${name}

    RETURN    ${name}

Get Text And Save Runtime Value
    [Arguments]    ${LOCATOR}    ${KEY}
    ${value}=    Get Text Safely    ${LOCATOR}
    RuntimeData.Save Value    ${KEY}    ${value}
    Log    Saved runtime value: ${KEY} = ${value}
    RETURN    ${value}

Get Runtime Value Or Fail
    [Arguments]    ${KEY}
    ${exists}=    RuntimeData.Has Value    ${KEY}
    IF    not ${exists}
        Fail    Runtime value '${KEY}' not found. Create step was not executed.
    END
    ${val}=    RuntimeData.Get Value    ${KEY}
    RETURN    ${val}
