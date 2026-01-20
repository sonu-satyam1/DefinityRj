*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***


*** Keywords ***
Verify Schedules Page Title in Vms
    Verify Page Title    Schedules
