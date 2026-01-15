*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource


*** Variables ***


*** Keywords ***
Verify Dashboard Page Title
    Verify Page Title    My Dashboard
