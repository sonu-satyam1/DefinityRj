*** Variables ***
${DEFAULT_TIMEOUT}             15s
${LONG_TIMEOUT}                30s
${SHORT_TIMEOUT}               5s
${POLLING_INTERVAL}            500ms
${RETRY_COUNT}                 3
${BROWSER}                     chrome
${PAGE_LOADER}                 xpath://div[contains(@class,"page-loader")]
${TEST_ENV}                    qa2
${TABLE_HEADER_TITLES}         xpath://table[contains(@class,'k-grid-header-table')]//th//span[@class='k-column-title']
${TABLE_ROWS}                  xpath://div[contains(@class,'k-grid-content')]//tr
${FILTER_MENU_BTN}             xpath://button[.//span[contains(@class,'icon-play')]]
${FILTER_MENU_PANEL}           xpath://div[contains(@class,'filter-manageCols')]
${FILTER_SEARCH_INPUT}         xpath://div[contains(@class,'filter-manageCols')]//input[contains(@class,'search-filter')]
${SHOW_ALL_BTN}                xpath://div[contains(@class,'filter-manageCols')]//button[.//span[normalize-space()='Show All']]
