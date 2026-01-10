*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource    ../variables/global_variables.resource



*** Keywords ***
Generic Assert Text Equals
    [Arguments]    ${ACTUAL}    ${EXPECTED}    ${MESSAGE}=None
    # If no custom message, create a default friendly message
    Run Keyword If    '${MESSAGE}'=='None'    ${MESSAGE}=    Set Variable    Expected text '${EXPECTED}' but found '${ACTUAL}'
    Run Keyword And Continue On Failure    Should Be Equal    ${ACTUAL}    ${EXPECTED}    ${MESSAGE}

Generic Assert Element Text Equals
    [Arguments]    ${LOCATOR}    ${EXPECTED}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}
    ${ACTUAL}=    Get Text    ${LOCATOR}
    Generic Assert Text Equals    ${ACTUAL}    ${EXPECTED}    ${MESSAGE}

Generic Assert Element Contains Text
    [Arguments]    ${LOCATOR}    ${EXPECTED_SUBSTRING}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}
    ${ACTUAL}=    Get Text    ${LOCATOR}
    Run Keyword If    '${MESSAGE}'=='None'    ${MESSAGE}=    Set Variable    Expected the element to contain '${EXPECTED_SUBSTRING}' but found '${ACTUAL}'
    Run Keyword And Continue On Failure    Should Contain    ${ACTUAL}    ${EXPECTED_SUBSTRING}    ${MESSAGE}

Generic Assert Element Exists
    [Arguments]    ${LOCATOR}    ${TIMEOUT}=${DEFAULT_TIMEOUT}    ${MESSAGE}=None
    Run Keyword If    '${MESSAGE}'=='None'    ${MESSAGE}=    Set Variable    The element '${LOCATOR}' was expected to appear but did not.
    Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}    msg=${MESSAGE}
