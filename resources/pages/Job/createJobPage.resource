*** Settings ***
Library     SeleniumLibrary
Resource    ../../keywords/common_keywords.resource



*** Variables ***


*** Keywords ***
Verify Create a Job Order Page Title
    Verify Page Title    Create a Job Order
