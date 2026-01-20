*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource


*** Variables ***


*** Keywords ***
Verify Dashboard Page Title in Vms
    Verify Page Title    My Dashboard
