*** Settings ***
Library     SeleniumLibrary
Library     String
Library    ../../../libs/RuntimeData.py

Resource    ../../keywords/common_keywords.resource



*** Variables ***
${RATE_TEMPLATE_NAME_DROPDOWN}              xpath://label[normalize-space(text())='Template Name']/preceding::span[contains(@class,'k-svg-i-caret-alt-down')][1]
${RATE_TEMPLATE_NAME_OPTIONS}               xpath://div[@class='k-list-content']/ul[@role='listbox']//li//span[@class='k-list-item-text']
${VENDOR_TAB}                               xpath://ul[contains(@class,'table-filters')]//li[contains(@class,'active') and normalize-space()='Vendor']
${OT_TEMPLATE_NAME_DROPDOWN}                xpath://span[contains(@class,'k-floating-label-container') and .//span[text()='Template Name']]//span[contains(@class,'k-dropdownlist')]//button
${OT_TEMPLATE_NAME_OPTIONS}                 xpath://ul[@role='listbox' and contains(@class, 'k-list-ul')]/li
${OT_RULE_VENDOR_TAB}                       xpath://ul[contains(@class,'table-filters')]//li[normalize-space()='Vendor']
${LOCATIONS_LOCATOR}                        xpath://div[contains(@class,'subsection-form')]//span[contains(@class,'caption')]

*** Keywords ***
Verify Rate Administration Page Title
    Verify Page Title    Rate Type Administration

Switch to Specified tab in Rate Administration Page
    [Arguments]    ${tab}
    Wait For Page Ready
    Sleep    5s
    Click Element Safely        xpath://ul[@role='tablist']//span[normalize-space()='${tab}']
    Wait For Page Ready

Choose Specified Rate Template from Dropdown list
    [Arguments]    ${tempName}
    Wait For Page Ready    
    Wait Till Element Visible    ${RATE_TEMPLATE_NAME_DROPDOWN}
    From Dropdown Verify Or Select An Option    ${RATE_TEMPLATE_NAME_DROPDOWN}    ${RATE_TEMPLATE_NAME_OPTIONS}    ${tempName}    select
    Wait For Page Ready

Choose Specified OT Rule Template from Dropdown list
    [Arguments]    ${otRuleName}
    Wait For Page Ready
    Wait Till Element Visible    ${OT_TEMPLATE_NAME_DROPDOWN}
    From Dropdown Verify Or Select An Option    ${OT_TEMPLATE_NAME_DROPDOWN}    ${OT_TEMPLATE_NAME_OPTIONS}    ${otRuleName}    select
    Wait For Page Ready

Check Current Vendor is tab is Selected
    ${is_active}=    Run Keyword And Return Status
...    Element Should Be Visible    ${VENDOR_TAB}
    Run Keyword If    ${is_active}
    ...    Log    Vendor tab is ACTIVE
    ...    ELSE
    ...    Log    Vendor tab is NOT active

Switch to Vendor OT Rules
    Wait For Page Ready    
    Wait Till Element Visible    ${OT_RULE_VENDOR_TAB}
    Click Element Safely    ${OT_RULE_VENDOR_TAB}
    Sleep    5s

Verify Specified Location is Present in Specified OT Rule Template
    [Arguments]    ${location}
    Wait For Page Ready
    Wait Until Element Is Visible    ${LOCATIONS_LOCATOR}
    ${location_text}=    Get Text    ${LOCATIONS_LOCATOR}
    Log    Full location text: ${location_text}

    ${locations_list}=    Split String    ${location_text}    ,
    @{locations_list}=    Evaluate    [x.strip() for x in ${locations_list}]
    Should Contain    ${locations_list}    ${location}
    Wait For Page Ready
    Sleep    3s
    

Get All Rates For Specified Skill
    [Arguments]    ${SKILL_NAME}

    # header <th> elements (not inner div)
    @{headers}=    Get WebElements
    ...    xpath=(//thead//tr)[2]/th[position()>1]

    # value <td> cells for skill row
    @{cells}=    Get WebElements
    ...    xpath=//tbody/tr[th//div[normalize-space()='${SKILL_NAME}']]/td

    ${h_count}=    Get Length    ${headers}
    ${c_count}=    Get Length    ${cells}

    Run Keyword If    ${h_count} != ${c_count}
    ...    Fail    Header and cell count mismatch: ${h_count} vs ${c_count}

    ${result}=    Create List

    FOR    ${i}    IN RANGE    ${h_count}
        ${h_el}=    Get From List    ${headers}    ${i}
        ${c_el}=    Get From List    ${cells}      ${i}

        ${h_txt}=    Get Text    ${h_el}
        ${h_txt}=    Replace String    ${h_txt}    info icon    ${EMPTY}
        ${h_txt}=    Replace String    ${h_txt}    \n    ${SPACE}
        ${h_txt}=    Strip String    ${h_txt}

        ${c_txt}=    Get Text    ${c_el}
        ${c_txt}=    Replace String    ${c_txt}    \n    ${EMPTY}
        ${c_txt}=    Strip String    ${c_txt}

        ${line}=    Set Variable    ${h_txt}: ${c_txt}
        Append To List    ${result}    ${line}
    END

    RETURN    ${result}


Fetch and Format Rates For Specified Skill Name
    [Arguments]    ${skillName}    ${rate}
    @{rates}=    Get All Rates For Specified Skill    ${skillName}

    FOR    ${r}    IN    @{rates}
        Log    ${r}
    END

    &{json}=    Create Dictionary
    
    FOR    ${r}    IN    @{rates}
    
        # Split key and value
        ${parts}=    Split String    ${r}    :
        ${raw_key}=  Strip String    ${parts}[0]
        ${value}=    Strip String    ${parts}[1]
    
        # ----- Clean & Normalize Key (JSON style) -----
        ${key}=    Convert To Title Case    ${raw_key}
#        ${key}=    Replace String    ${key}    _    ${SPACE}
    
        # ---------- MULTIPLIER ----------
        IF    'x' in '${value}'
            @{mul_parts}=    Split String    ${value}    x
            ${num}=          Strip String    ${mul_parts}[0]
            ${base}=         Convert To Number    ${num}
            ${final}=        Evaluate    round(${base} * ${rate}, 2)
    
        # ---------- PREMIUM ----------
        ELSE IF    '${value}'.startswith('+')
            ${num}=    Replace String    ${value}    +    ${EMPTY}
            ${num}=    Replace String    ${num}      $    ${EMPTY}
            ${num}=    Strip String     ${num}
            ${base}=   Convert To Number    ${num}
            ${final}=  Evaluate    round(${base} + ${rate}, 2)

    
        # ---------- NORMAL ----------
        ELSE
            ${num}=    Replace String    ${value}    $    ${EMPTY}
            ${num}=    Strip String     ${num}
            ${final}=  Convert To Number    ${num}
        END
    
        Set To Dictionary    ${json}    ${key}=${final}
    
    END
    
    Log    ${json}
    ${stored}=    RuntimeData.Get Value    ADDITIONAL_RATES

    RETURN    ${json}


Compare Fetched Rates With Stored Provided Job Rates
    [Arguments]    ${ui_json}

    # Get stored data from runtime_data.json
    ${stored}=    RuntimeData.Get Value    ADDITIONAL_RATES

    FOR    ${s_key}    ${s_val}    IN    &{stored}

        # Initialize
        ${matched}=    Set Variable    ${False}
        ${ui_val}=     Set Variable    ${None}

        # Loop UI JSON to find key ignoring case
        FOR    ${u_key}    ${u_val}    IN    &{ui_json}
            ${same}=    Evaluate    '${s_key}'.lower() == '${u_key}'.lower()
            IF    ${same}
                ${matched}=    Set Variable    ${True}
                ${ui_val}=     Set Variable    ${u_val}
                Exit For Loop
            END
        END

        # Fail if key from runtime_data not found in UI JSON
        IF    not ${matched}
            Fail    Key from runtime_data not found in UI JSON: ${s_key}
        END
        # Compare values (allowing small floating point tolerance)
        ${diff}=    Evaluate    abs(float(${ui_val}) - float(${s_val}))
        Run Keyword If    ${diff} > 0.01
        ...    Fail    Value mismatch for '${s_key}': UI=${ui_val}  STORED=${s_val}

        Log    Matched: ${s_key} = ${s_val}

    END


Get Overtime Rules From UI As JSON
    [Documentation]    Read Daily / Weekly / Consecutive OT rules and store as JSON

    @{daily}=    Create List
    @{weekly}=   Create List
    @{cons}=     Create List

    &{ot_json}=    Create Dictionary
    ...    Daily=${daily}
    ...    Weekly=${weekly}
    ...    Consecutive Days=${cons}

    # All 3 sections: Daily / Weekly / Consecutive
    @{sections}=    Get WebElements
    ...    xpath=//h2/span[contains(text(),'Overtime Rules')]/ancestor::div[contains(@class,'overtime-subsection1')]

    ${sec_count}=    Get Length    ${sections}

    FOR    ${i}    IN RANGE    1    ${sec_count + 1}

        ${title}=    Get Text
        ...    xpath=(//h2/span[contains(text(),'Overtime Rules')])[${i}]

        ${title}=    Replace String    ${title}    Overtime Rules    ${EMPTY}
        ${title}=    Strip String    ${title}

        # Map section name to dict key
        IF    '${title}' == 'Daily'
            ${list}=    Set Variable    ${daily}
        ELSE IF    '${title}' == 'Weekly'
            ${list}=    Set Variable    ${weekly}
        ELSE
            ${list}=    Set Variable    ${cons}
        END

        # Each rule row is a d-flex pair
        @{rows}=    Get WebElements
        ...    xpath=(//h2/span[contains(text(),'Overtime Rules')]/ancestor::div[contains(@class,'overtime-subsection1')])[${i}]//div[@class='d-flex ']

        ${r_count}=    Get Length    ${rows}

        FOR    ${j}    IN RANGE    1    ${r_count + 1}

            ${rule_txt}=    Get Text
            ...    xpath=(//h2/span[contains(text(),'Overtime Rules')]/ancestor::div[contains(@class,'overtime-subsection1')])[${i}]//div[@class='d-flex '][${j}]//div[1]//p

            ${bill_txt}=    Get Text
            ...    xpath=(//h2/span[contains(text(),'Overtime Rules')]/ancestor::div[contains(@class,'overtime-subsection1')])[${i}]//div[@class='d-flex '][${j}]//div[2]//p

            # --- Normalize rule ---
            ${rule}=    Replace String    ${rule_txt}    Hours    hours
            ${rule}=    Replace String    ${rule}    >    >
            ${rule}=    Replace String    ${rule}    <    <
            ${rule}=    Strip String    ${rule}

            # --- Billing: "Premium: $7.00" OR "Multiplier: 8.00"
            ${parts}=    Split String    ${bill_txt}    :
            ${type}=     Strip String    ${parts}[0]

            ${rate_txt}=    Strip String    ${parts}[1]
            ${rate_txt}=    Replace String    ${rate_txt}    $    ${EMPTY}
            ${rate}=        Convert To Number    ${rate_txt}

            &{r}=    Create Dictionary
            ...    rule=${rule}
            ...    type=${type}
            ...    rate=${rate}

            Append To List    ${list}    ${r}

        END
    END

    Log    ${ot_json}
    RETURN    ${ot_json}

Compare Overtime Rules With Runtime Data
    [Arguments]    ${ui_ot}    ${stored_ot}

    FOR    ${section}    IN    Daily    Weekly    Consecutive Days

        ${stored_list}=    Get From Dictionary    ${stored_ot}    ${section}
        ${ui_list}=        Get From Dictionary    ${ui_ot}        ${section}

        FOR    ${s_rule}    IN    @{stored_list}

            ${matched}=    Set Variable    False

            FOR    ${u_rule}    IN    @{ui_list}

                IF    $s_rule["rule"] == $u_rule["rule"] and $s_rule["type"] == $u_rule["type"]

                    Should Be Equal As Numbers
                    ...    ${u_rule["rate"]}
                    ...    ${s_rule["rate"]}

                    ${matched}=    Set Variable    True
                    EXIT FOR LOOP
                END
            END

            IF    not ${matched}
                Fail    Missing OT rule in UI: ${s_rule}
            END

        END

    END
