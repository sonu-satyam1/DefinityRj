*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource

*** Variables ***
# Breadcrumb / Back Navigation
${XPATH_BREADCRUMB_BACK_ARROW}              xpath=//p[contains(@class,'breadcrumb')]//span[contains(@class,'arrow') and contains(@class,'left')]
${XPATH_BREADCRUMB_TIMECARD_MGMT}           xpath=//p[contains(@class,'breadcrumb')]//span[contains(text(),'Timecard Management')]

# Profile Header Section
${XPATH_TALENT_NAME}                        xpath=//div[contains(@class,'vm-right-pane-container')]//h2[1] | //div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'adam garu')]/ancestor-or-self::*[self::h1 or self::h2][1]
${XPATH_STATUS_BADGE}                       xpath=//span[contains(@class,'badge') or contains(@class,'status')][contains(text(),'Dispute') or contains(text(),'Approved') or contains(text(),'Rejected') or contains(text(),'Pending')]
${XPATH_PLACEMENT_INFO}                     xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'914')]
${XPATH_CONTACT_PHONE}                      xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'-') and string-length(text()) < 20][preceding-sibling::*[contains(@class,'icon') or contains(text(),'Mobile')]]
${XPATH_CONTACT_EMAIL}                      xpath=//a[contains(@class,'custom-text-link') and contains(@href,'mailto:')]
${XPATH_CONTACT_ADDRESS}                    xpath=//div[contains(@class,'vm-right-pane-container')]//*[preceding-sibling::*[contains(@class,'location') or contains(text(),'location')]]

# Week Navigation Arrows (Previous / Next Week)
${XPATH_BTN_PREV_WEEK}                      xpath=//button[contains(@class,'st-arrow-button')][.//span[contains(text(),'Left')]]
${XPATH_BTN_NEXT_WEEK}                      xpath=//button[contains(@class,'st-arrow-button')][.//span[contains(text(),'Right')]]
${XPATH_BTN_PREV_WEEK_ALT}                  xpath=//button[contains(@class,'pr-outline-btn') and contains(@class,'st-arrow-button')][not(contains(@class,'ms-2'))]
${XPATH_BTN_NEXT_WEEK_ALT}                  xpath=//button[contains(@class,'pr-outline-btn') and contains(@class,'ms-2') and contains(@class,'st-arrow-button')]

# Schedule & Rate Details
${XPATH_SCHEDULE_START_DATE}                xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'12/25/2025')]
${XPATH_SCHEDULE_END_DATE}                  xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'12/27/2026')]
${XPATH_SCHEDULE_TYPE}                      xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'PRN')]
${XPATH_SCHEDULE_RATE}                      xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'$3.00')][1]

# Location & Qualifications
${XPATH_LOCATION_INFO}                      xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'Placeholder Market')]
${XPATH_QUALIFICATIONS_INFO}                xpath=//div[contains(@class,'vm-right-pane-container')]//*[contains(text(),'experience')]

# Bar Chart / Overview Link
${XPATH_BAR_CHART_LINK}                     xpath=//span[contains(@class,'bar-chart-link-content')][@role='button']

# Main Detail Tabs
${XPATH_TAB_TIMECARD}                       xpath=//li[@role='tab'][.//span[text()='TIMECARD']]
${XPATH_TAB_RATE_CARD}                      xpath=//li[@role='tab'][.//span[text()='RATE CARD']]
${XPATH_TAB_INVOICE_DETAILS}                xpath=//li[@role='tab'][.//span[text()='INVOICE DETAILS']]
${XPATH_TAB_HISTORY}                        xpath=//li[@role='tab'][.//span[text()='HISTORY']]

# Timecard Week Navigation & Controls
${XPATH_WEEK_PREV_ARROW}                    xpath=//button[contains(@class,'pr-outline-btn')][.//span[contains(text(),'chevron left')]]
${XPATH_WEEK_NEXT_ARROW}                    xpath=//button[contains(@class,'pr-outline-btn') and contains(@class,'btn-small')][.//span[contains(text(),'chevron right')]]
${XPATH_WEEK_DATE_RANGE}                    xpath=//*[contains(text(),'12/29/2025')]/parent::*[contains(text(),'01/04/2026')] | //*[contains(text(),'12/29/2025')]

# Toggle: Did Not Work
${XPATH_TOGGLE_DID_NOT_WORK}                xpath=//label[contains(@class,'switch-label')][contains(text(),'Did Not Work')]

# Add Document Button
# -----------------------------------------------------------
${XPATH_BTN_ADD_DOCUMENT}                   xpath=//button[contains(@class,'pr-btn-primary')][.//span[contains(text(),'ADD DOCUMENT')]]

# Timecard Table Headers
${XPATH_TBL_HEADER_DAY}                     xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Day')]
${XPATH_TBL_HEADER_RATE_TYPE}               xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Rate Type')]
${XPATH_TBL_HEADER_RATE}                    xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Rate')]
${XPATH_TBL_HEADER_COST_CENTER}             xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Cost Center')]
${XPATH_TBL_HEADER_TIME_IN}                 xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Time In')]
${XPATH_TBL_HEADER_TIME_OUT}                xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Time Out')]
${XPATH_TBL_HEADER_HOURS}                   xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Hours')]
${XPATH_TBL_HEADER_MEAL}                    xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Meal')]
${XPATH_TBL_HEADER_STATUS}                  xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Status')]
${XPATH_TBL_HEADER_ACTIONS}                 xpath=//div[contains(@class,'vm-timecard-container')]//th[contains(text(),'Actions')]

# Timecard Table - Row Action Buttons
${XPATH_BTN_REJECT}                         xpath=//button[contains(@class,'pr-flat-btn')][.//span[text()='Reject']]
${XPATH_BTN_APPROVE}                        xpath=//button[contains(@class,'pr-flat-btn')][.//span[text()='Approve']]

# Timecard Table - Time Picker Inputs (MUI)
${XPATH_INPUT_TIME_IN}                      xpath=//label[contains(@class,'MuiInputLabel-root')][contains(text(),'Time In')]/parent::div//input | //div[contains(@class,'vm-timecard-container')]//label[text()='Time In']/following::input[1]
${XPATH_INPUT_TIME_OUT}                     xpath=//label[contains(@class,'MuiInputLabel-root')][contains(text(),'Time Out')]/parent::div//input | //div[contains(@class,'vm-timecard-container')]//label[text()='Time Out']/following::input[1]

# Timecard Table - Status Labels (within rows)
${XPATH_STATUS_INVOICED}                    xpath=//div[contains(@class,'vm-timecard-container')]//*[contains(text(),'Invoiced')]
${XPATH_STATUS_DISPUTED}                    xpath=//div[contains(@class,'vm-timecard-container')]//*[contains(text(),'Disputed')]

# Summary Section - Headers
${XPATH_SUMMARY_HEADER_HOURS}               xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Hours'][not(ancestor::div[contains(@class,'vm-timecard-container')])]
${XPATH_SUMMARY_HEADER_SUBTOTAL}            xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Subtotal']
${XPATH_SUMMARY_HEADER_SALES_TAX}           xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Sales Tax']
${XPATH_SUMMARY_HEADER_AMOUNT}              xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Amount']

# Summary Section - Approved Row
${XPATH_SUMMARY_APPROVED_LABEL}             xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Approved']
${XPATH_SUMMARY_UNAPPROVED_LABEL}           xpath=//div[contains(@class,'vm-right-pane-container')]//*[text()='Unapproved']

# Documents Section - Headers
${XPATH_DOC_HEADER_FILE_NAME}               xpath=//span[text()='File Name']
${XPATH_DOC_HEADER_UPLOADED_BY}             xpath=//span[text()='Uploaded By']
${XPATH_DOC_HEADER_DATE}                    xpath=//span[text()='Date']

# Documents Section - Row Elements
${XPATH_DOC_FILE_NAME_LINK}                 xpath=//span[contains(@class,'name-col') and contains(@class,'cursor-pointer')][@role='button']
${XPATH_DOC_DOWNLOAD_BTN}                   xpath=//button[contains(@class,'icon-download')][@aria-label='My button']

# Documents Section - Pagination
${XPATH_DOC_PAGER_PAGE_BTN}                 xpath=//button[contains(@class,'k-button') and contains(@class,'k-button-flat-primary')][@role='button']
${XPATH_DOC_PAGER_PAGE_SIZE}                xpath=//span[@role='combobox'][@aria-label='Page size']

# Floating Side Panel Buttons (Comment / File)
${XPATH_BTN_COMMENT_PANEL}                  xpath=//button[contains(@class,'comment-slideOut-icon') and contains(@class,'icon-notification')]
${XPATH_BTN_FILE_PANEL}                     xpath=//button[contains(@class,'comment-slideOut-icon') and contains(@class,'icon-description-fill')]

