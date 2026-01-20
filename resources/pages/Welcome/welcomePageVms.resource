*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource
Resource    ../../errors/common_assertions.resource


*** Variables ***
${HEADER_WELCOME}           xpath://h1[contains(@class,'welcome-heading')]
${NOTIFICATION_BADGE}       xpath://span[contains(@class,'notification-badge')]
${NOTIFICATION_BELL_BTN}    xpath://button[contains(@class,'notification-icon-wrap')]
${NOTIFICATION_PANEL}       xpath://div[contains(@class,'pr-notification-wrapper')]
${NOTIFICATION_ITEMS}       xpath://ul[contains(@class,'notification-menu-wrapper')]/li
${NOTIFICATION_CLEAR_BTN}   xpath://button[contains(@class,'notification-clear')]
${USER_ICON_BTN}            xpath://button[contains(@class,'user-icon') and contains(@class,'k-menu-button')]
${OPTION_MY_PROFILE}        xpath://span[contains(@class,'k-menu-link-text') and normalize-space()='My profile']
${BTN_SIGN_OUT}              xpath://span[contains(@class,'k-menu-link-text') and normalize-space()='Sign out']


*** Keywords ***
Verify Page Header And Title For Vms
    ${title}=    Get Text Safely    ${HEADER_WELCOME}
    Generic Assert Element Contains Text
    ...    ${HEADER_WELCOME}
    ...    Welcome
    ...    30s

Click Feature Menu Option in Vms
    [Arguments]    ${MENU}    ${SUB}=None

    ${menu_locator}=    Set Variable    xpath=//a[contains(@class,'wc-card-wrapper') and .//span[contains(@class,'wc-card-text') and contains(normalize-space(.),'${MENU}')]]
    Wait Till Element Enabled    ${menu_locator}    30s
    Scroll To View Element    ${menu_locator}
    IF    '${SUB}' == 'None'
        Click Element Safely    ${menu_locator}
    ELSE
        ${sub_locator}=    Set Variable    xpath=//a[contains(@class,'wc-card-wrapper') and .//span[contains(@class,'wc-card-text') and contains(normalize-space(.),'${MENU}')]]//a[contains(@class,'wc-card-sublink') and normalize-space(.)='${SUB}']
       Wait Till Element Enabled    ${sub_locator}    30s
        Click Element Safely    ${sub_locator}
    END

Validate Welcome Page Notification Count in Vms
    Wait Till Element Visible    ${NOTIFICATION_BELL_BTN}  
    Click Element Safely    ${NOTIFICATION_BELL_BTN}
    Wait Till Element Visible    ${NOTIFICATION_PANEL}

    ${badge_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${NOTIFICATION_BADGE}    5s

    ${list_count}=    Get Element Count    ${NOTIFICATION_ITEMS}

    IF    not ${badge_visible}
        # -------- Case 1: No badge → No notifications --------
        Should Be Equal As Integers    ${list_count}    0
    ELSE
        ${badge_text}=    Get Text Safely    ${NOTIFICATION_BADGE}

        IF    '${badge_text}' == '99+'
            # -------- Case 3: More than 99 --------
            Should Be True    ${list_count} > 99
        ELSE
            # -------- Case 2: Exact count --------
            ${badge_num}=    Convert To Integer    ${badge_text}
            Should Be Equal As Integers    ${badge_num}    ${list_count}
        END
    END

Navigate to My Profile Page in Vms
    Wait Till Element Visible    ${USER_ICON_BTN}
    Click Element Safely    ${USER_ICON_BTN}
    Wait Until Element Is Visible    ${OPTION_MY_PROFILE}
    Click Element Safely    ${OPTION_MY_PROFILE}

SignOut From the Portal in Vms
    Wait Till Element Visible    ${USER_ICON_BTN}
    Click Element Safely    ${USER_ICON_BTN}
    Wait Until Element Is Visible    ${BTN_SIGN_OUT}
    Click Element Safely    ${BTN_SIGN_OUT}