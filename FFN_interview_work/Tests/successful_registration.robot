*** Settings ***
Resource    ../Keywords/UserKeywords/user_keywords.robot
Test Setup   Data Init   Successful registration

*** Test Cases ***
Successful registration 
    [Documentation]   User is able to start registration from the ‘Sign in’ link in the header of the home page
    ...               User is logged in after successful registration
    ...               User is located on the ‘My Account’ page after successful registration
    
    Open Browser And Go To       http://automationpractice.com/index.php
    Click To                     Landing Page::Sign In
    Write Text                   Authentication Page::Create An Account::Email Address           ${INPUT_DATA['EMAIL']}
    Click To                     Authentication Page::Create An Account::Create An Account
    Log                          User is able to start registration from the ‘Sign in’ link in the header of the home page
    Click To                     Create An Account Page::Title
    Write Text                   Create An Account Page::First name                              ${INPUT_DATA['First name']}
    Write Text                   Create An Account Page::Last name                               ${INPUT_DATA['Last name']}
    Value Should Be Equal        Create An Account Page::Email                                   ${INPUT_DATA['EMAIL']}
    Write Text                   Create An Account Page::Password                                ${INPUT_DATA['Password']}
    Select Option	             Create An Account Page::Date of Birth Day                       ${INPUT_DATA['Date of Birth Day']}
    Select Option	             Create An Account Page::Date of Birth Month                     ${INPUT_DATA['Date of Birth Month']}
    Select Option	             Create An Account Page::Date of Birth Year                      ${INPUT_DATA['Date of Birth Year']}
    Click To                     Create An Account Page::Sign up for newsletter
    Click To                     Create An Account Page::Special offers
    Write Text                   Create An Account Page::YOUR ADDRESS::First name                ${INPUT_DATA['First name']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Last name                 ${INPUT_DATA['Last name']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Company                   ${INPUT_DATA['Company']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Address                   ${INPUT_DATA['Address']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Address2                  ${INPUT_DATA['Address2']}
    Write Text                   Create An Account Page::YOUR ADDRESS::City                      ${INPUT_DATA['City']}
    Select Option	             Create An Account Page::YOUR ADDRESS::State                     ${INPUT_DATA['State']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Zip                       ${INPUT_DATA['Zip']}
    Select Option	             Create An Account Page::YOUR ADDRESS::Country                   ${INPUT_DATA['Country']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Additional information    ${INPUT_DATA['Additional information']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Home phone                ${INPUT_DATA['Home phone']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Mobile phone              ${INPUT_DATA['Mobile phone']}
    Write Text                   Create An Account Page::YOUR ADDRESS::Address alias             ${INPUT_DATA['Address alias']}
    Click To                     Create An Account Page::Register
    Text Should Be Equal         Dashboard::User Name                                            ${INPUT_DATA['First name']} ${INPUT_DATA['Last name']}
    Log                          User is logged in after successful registration
    Text Should Be Equal         Dashboard::Page Name                                            MY ACCOUNT
    Log                          User is located on the ‘My Account’ page after successful registration
    Click To                     Dashboard::Logout
    Close Current Browser