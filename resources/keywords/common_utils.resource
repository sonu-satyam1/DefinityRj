*** Settings ***
Library    DateTime
Library     FakerLibrary
Library    Collections
Library    ../../libs/RuntimeData.py
Resource    common_keywords.resource
Resource    ../../resources/pages/Talent/addTalentVmsPage.resource

*** Variables ***
${UPLOAD_DIR}    ${EXECDIR}/testdata/uploads

*** Keywords ***
Generate And Store Global Unique Name
    [Arguments]    ${prefix}    ${key}
    ${dt}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${name}=    Set Variable    ${prefix}_${dt}

    Set Suite Variable    ${${key}}    ${name}
    Save Value    ${key}    ${name}

    RETURN    ${name}

Generate And Store Global Unique Email
    [Arguments]    ${prefix}    ${key}
    ${dt}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${email}=    Set Variable    ${prefix}_${dt}@mailinator.com

    # create dynamic variable like ${USER_EMAIL}
    Set Suite Variable    ${${key}}    ${email}
    # save into runtime_data.json or similar
    Save Value    ${key}    ${email}

    RETURN    ${email}

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



Fill Basic Details using Faker
    [Arguments]
    ...    ${FIRSTNAME_INPUT}
    ...    ${LASTNAME_INPUT}
    ...    ${PHONE_INPUT}
    ...    ${ADDRESS_INPUT}
    ...    ${CITY_INPUT}
    ...    ${ZIP_INPUT}
    ...    ${SUMMARY_INPUT}

    ${first}=         First Name
    ${last}=          Last Name
    ${phone}=         Random Number    digits=10
    ${address}=       Street Address
    ${city}=          City
    ${zip}=           Postcode
    ${summary}=       Paragraph        nb_sentences=2
    ${dob_raw}=    Date Of Birth    minimum_age=21    maximum_age=45
    ${dob}=        Convert Date    ${dob_raw}    result_format=%m/%d/%Y
    Wait For Page Ready
    Scroll To View Element    ${FIRSTNAME_INPUT}
    Input Text Safely        ${FIRSTNAME_INPUT}    ${first}

    Wait For Page Ready
    Scroll To View Element    ${LASTNAME_INPUT}
    Input Text Safely    ${LASTNAME_INPUT}     ${last}

    Wait For Page Ready
    Scroll To View Element    ${PHONE_INPUT}
    Input Text Safely    ${PHONE_INPUT}        ${phone}

    Wait For Page Ready
    Scroll To View Element    ${ADDRESS_INPUT}
    Input Text Safely    ${ADDRESS_INPUT}      ${address}

    Wait For Page Ready
    Scroll To View Element    ${CITY_INPUT}
    Input Text Safely    ${CITY_INPUT}         ${city}

    Wait For Page Ready
    Scroll To View Element    ${ZIP_INPUT}
    Input Text Safely    ${ZIP_INPUT}          ${zip}
    
    Wait For Page Ready
    Scroll To View Element    ${SUMMARY_INPUT}
    Input Text Safely    ${SUMMARY_INPUT}      ${summary}
    Wait For Page Ready
    # Create TALENT dictionary
    ${talent}=    Create Dictionary
    ...    FIRST_NAME=${first}
    ...    LAST_NAME=${last}
    ...    PHONE=${phone}
    ...    ADDRESS=${address}
    ...    CITY=${city}
    ...    ZIP=${zip}
    ...    SUMMARY=${summary}
    ...    DOB=${dob}

    #Store as single object in runtime_data.json
    Save Value    TALENT    ${talent}

Upload File Dynamically
    [Arguments]    ${element}    ${filename}
    ${file_path}=    Set Variable    ${UPLOAD_DIR}/${filename}
    Choose File    ${element}    ${file_path}