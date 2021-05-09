*** Settings ***
Resource    ../Keywords/UserKeywords/user_keywords.robot
Test Setup   Data Init   Searching for products

*** Test Cases ***
Searching for products 
    [Documentation]   User is able to search for products from the search bar on the home page
    ...               User only sees items that match the entered search term
    ...               (use the word `Printed` as a search term for simplicity)
    
    Open Browser And Go To       http://automationpractice.com/index.php
    Write Text                   Landing Page::Search Bar           	        ${INPUT_DATA['Search word']}
    Click To                     Landing Page::Search Button
    Log                          User is able to search for products from the search bar on the home page
    Every Element Text Contains  Product List::Name Links                       ${INPUT_DATA['Search word']}
    Log                          User only sees items that match the entered search term
    Close Current Browser