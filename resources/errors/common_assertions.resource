*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource    ../variables/global_variables.resource


*** Keywords ***
Get Element Text After Wait
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}
    ${TEXT}=    Get Text    ${LOCATOR}
    RETURN    ${TEXT}

Build Default Message
    [Arguments]    ${MESSAGE}    ${DEFAULT}
    ${FINAL}=    Set Variable If    '${MESSAGE}'=='None'    ${DEFAULT}    ${MESSAGE}
    RETURN    ${FINAL}

Generic Assert Text Equals
   [Arguments]    ${ACTUAL}    ${EXPECTED}    ${MESSAGE}=None
    ${MESSAGE}=    Build Default Message
    ...    ${MESSAGE}
    ...    Expected text '${EXPECTED}' but found '${ACTUAL}'
    Run Keyword And Continue On Failure
    ...    Should Be Equal
    ...    ${ACTUAL}
    ...    ${EXPECTED}
    ...    ${MESSAGE}

Generic Assert Element Text Equals
    [Arguments]    ${LOCATOR}    ${EXPECTED}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    ${ACTUAL}=    Get Element Text After Wait    ${LOCATOR}    ${TIMEOUT}
    Generic Assert Text Equals    ${ACTUAL}    ${EXPECTED}    ${MESSAGE}

Generic Assert Element Contains Text
    [Arguments]    ${LOCATOR}    ${EXPECTED_SUBSTRING}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    ${ACTUAL}=    Get Element Text After Wait    ${LOCATOR}    ${TIMEOUT}
    ${MESSAGE}=    Build Default Message
    ...    ${MESSAGE}
    ...    Expected the text to contain '${EXPECTED_SUBSTRING}' but found '${ACTUAL}'
    Run Keyword And Continue On Failure
    ...    Should Contain
    ...    ${ACTUAL}
    ...    ${EXPECTED_SUBSTRING}
    ...    ${MESSAGE}

Generic Assert Element Exists
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    ${MESSAGE}=    Build Default Message
    ...    ${MESSAGE}
    ...    The element '${LOCATOR}' was expected to appear but did not.
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}    msg=${MESSAGE}

Generic Assert Element Contains Text Case Insensitive
    [Arguments]    ${LOCATOR}    ${EXPECTED_SUBSTRING}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    ${ACTUAL}=    Get Element Text After Wait    ${LOCATOR}    ${TIMEOUT}

    ${ACTUAL}=    Strip String    ${ACTUAL}
    ${EXPECTED_SUBSTRING}=    Strip String    ${EXPECTED_SUBSTRING}
    ${ACTUAL}=    Convert To Lower Case    ${ACTUAL}
    ${EXPECTED_SUBSTRING}=    Convert To Lower Case    ${EXPECTED_SUBSTRING}

    ${MESSAGE}=    Build Default Message
    ...    ${MESSAGE}
    ...    Expected text to contain '${EXPECTED_SUBSTRING}' but found '${ACTUAL}'

    Run Keyword And Continue On Failure
    ...    Should Contain
    ...    ${ACTUAL}
    ...    ${EXPECTED_SUBSTRING}
    ...    ${MESSAGE}
