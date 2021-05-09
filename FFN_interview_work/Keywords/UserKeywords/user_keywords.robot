*** Settings ***
Library   SeleniumLibrary
Library   String
Library   Collections
Resource   ../RepoLogic/repo_logic.robot
Variables   ../../Data/input_data.yaml
Variables   ../../Data/config.yaml

*** Variables ***
${BROWSER}=   chrome
${CHROME_EXEC}
${FIREFOX_EXEC}
${FIREFOX_BINARY}
${TIMEOUT}=   20
&{INPUT_DATA}=   &{Empty}
*** Keywords ***
Data Init  [Arguments]   ${test}
    [Documentation]    Keyword for init input data of test case.
    ...    @param1:   Test Case name
    &{temp}=   Set Variable   ${${test}}
    FOR   ${key}   IN   @{temp.keys()}
       ${random_email}=     Run Keyword If   "${temp["${key}"]}"=="RANDOM_EMAIL"   Get Random Email
       Run Keyword If   "${temp["${key}"]}"=="RANDOM_EMAIL"   Set To Dictionary   ${temp}   ${key}=${random_email}
    END
    ${INPUT_DATA}=   Copy Dictionary   ${temp}
    Set Global Variable   ${INPUT_DATA}
Open Browser And Go To  [Arguments]   ${url}
    [Documentation]    Keyword for open a browser, and navigate to an URL.
    ...    @param1:   URL to navigate
    ...    VARIABLES:
    ...    @BROWSER: Browser to run test cases. Default is chrome, but it can be override in CMD.
    ...    @TIMEOUT: Browser implicit wait settings
    ...    @CHROME_EXEC: chromedriver location in file system. It can be set in config.yaml, or in CMD.
    ...    @FIREFOX_EXEC: geckodriver location in file system. It can be set in config.yaml, or in CMD.
    ...    @FIREFOX_BINARY: Firefox location in file system. It can be set in config.yaml, or in CMD.
    ${CHROME_EXEC}=   Run Keyword If   '${CHROME_EXEC}'=='${Empty}'   Set Variable   ${Browser Settings['CHROME_EXEC']}
    ...   ELSE   Set Variable   ${CHROME_EXEC}
    ${FIREFOX_EXEC}=   Run Keyword If   '${FIREFOX_EXEC}'=='${Empty}'   Set Variable   ${Browser Settings['FIREFOX_EXEC']}
    ...   ELSE   Set Variable   ${FIREFOX_EXEC}
    ${FIREFOX_BINARY}=   Run Keyword If   '${FIREFOX_BINARY}'=='${Empty}'   Set Variable   ${Browser Settings['FIREFOX_BINARY']}
    ...   ELSE   Set Variable   ${FIREFOX_BINARY}
    Run Keyword if   '${browser}'=='chrome'   Create Webdriver    Chrome    executable_path=${CHROME_EXEC}
    ...   ELSE IF   '${browser}'=='firefox'   Create Webdriver    Firefox    executable_path=${FIREFOX_EXEC}   firefox_binary=${FIREFOX_BINARY}
    Go To    ${url}
    Maximize Browser Window
	Set Browser Implicit Wait    ${TIMEOUT}
Click To  [Arguments]   ${name}
    [Documentation]    Keyword for click an element.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ${selector}=    Get Selector From Objects    ${name}
    Click Element   ${selector}
Write Text  [Arguments]   ${name}   ${text}
    [Documentation]    Keyword for type text into object.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    @param2:   Text to type.
    ${selector}=    Get Selector From Objects    ${name}
    Input Text   ${selector}   ${text}
Select Option  [Arguments]   ${name}   ${text}
    [Documentation]    Keyword for select an option in dropdown. It also can select options with one or two non-breaking spaces.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    @param2:   Text of option to select.
    Set Browser Implicit Wait    1
    ${selector}=    Get Selector From Objects    ${name}
    ${success}=    Run Keyword And Return Status   Select From List By Label   ${selector}   ${text}
    ${success}=    Run Keyword If   '${success}'!='True'   Run Keyword And Return Status   Select From List By Label   ${selector}   ${text}\xA0
    ...   ELSE                                                Set Variable   ${success}
    ${success}=    Run Keyword If   '${success}'!='True'   Run Keyword And Return Status   Select From List By Label   ${selector}   ${text}\xA0\xA0
    ...   ELSE                                                Set Variable   ${success}
    Set Browser Implicit Wait    ${TIMEOUT}
Value Should Be Equal  [Arguments]   ${name}   ${text}
    [Documentation]    Keyword for validate value attribute of element.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    @param2:   Value to validate.
    ${selector}=    Get Selector From Objects    ${name}
    ${actual_text}=    Get Element Attribute   ${selector}   value
    Should Be Equal As Strings   ${actual_text}   ${text}
Text Should Be Equal  [Arguments]   ${name}   ${text}
    [Documentation]    Keyword for validate text content of element.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    @param2:   Text to validate.
    ${actual_text}=    Wait And Get Element Text   ${name}
    Should Be Equal As Strings   ${actual_text}   ${text}
Wait And Get Element Text  [Arguments]   ${name}
    [Documentation]    Keyword for wait until element is visible, and get its text.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    Return:  Text of element as a string.
    ${selector}=    Get Selector From Objects    ${name}
    Wait Until Element Is Visible   ${selector}   ${TIMEOUT}
    ${text}=   Get Element Text  ${name}
    [Return]   ${text}
Get Element Text  [Arguments]   ${name}
    [Documentation]    Keyword for get text of an element.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    Return:  Text of element as a string.
    ${selector}=    Get Selector From Objects    ${name}
    ${text}=   Get Text   ${selector}
    [Return]   ${text}
Close Current Browser
    [Documentation]    Keyword for close the browser.
    Close Browser
Get Random Email
    [Documentation]    Keyword for generate random email address.
    ...    It stands 10 random string characters and @ character,then 5 random string characters,then . character, and 2 random string characters.
    ...    Return:   generated email address as a string.
    ${pre}=   Generate Random String	10	[LOWER]
    ${domain}=   Generate Random String	5	[LOWER]
    ${post}=   Generate Random String	2	[LOWER]
    ${email}=   Set Variable   ${pre}@${domain}.${post}
    [Return]   ${email}
Every Element Text Contains   [Arguments]   ${name}   ${text}
    [Documentation]    Keyword for validate text content of element list. It also waits until page contains the list.
    ...    @param1:   Name of the element list to locate in the Object Repository. For example: Landing Page::Sign In
    ...    @param2:   Text to validate.
    ${selector}=    Get Selector From Objects    ${name}
    Wait Until Page Contains Element   ${selector}
    @{elements}=   Get WebElements   ${selector}
    FOR   ${element}   IN   @{elements}
       ${actual_text}=   Get Text   ${element}
       Should Contain   ${actual_text}   ${text}
    END
Click Nth Element In Product List   [Arguments]   ${name}   ${count}
    [Documentation]    Keyword for clicking a product name is product list by index.
    ...    @param1:   Name of the product list to locate in the Object Repository
    ...    @param2:   Index of element to click. Index starts with 1.
    ${selector}=    Get Selector From Objects    ${name}
    Click Element   ${selector}:nth-child(${count}) a.product-name
Add Element To Cart
    [Documentation]    Keyword for adding an element to cart. It sets random quantity between 1-9 for the product. It also collect informations and stores in a dictionary, and returns it.
    ...    Informations to store: name,quantity,price
    ...    Return:   A dictionary containing informations about the added element.
    ${selector}=    Get Selector From Objects    Product Page::Name
    ${name}=    Get Text   ${selector}
    &{product}=   Create Dictionary   name   ${name}
    ${selector}=    Get Selector From Objects    Product Page::Price
    ${price}=    Get Text   ${selector}
    ${quantity}=    Generate random string    1    123456789
    ${selector}=    Get Selector From Objects    Product Page::Plus Button
    FOR   ${number}  IN RANGE   ${quantity}
       Click Element   ${selector}
    END
    ${quantity}=    Evaluate   ${quantity}+1
    Set To Dictionary   ${product}   price=${price}   quantity=${quantity}
    ${selector}=    Get Selector From Objects    Product Page::Add To Cart
    Click Element   ${selector}
    [Return]   ${product}
Get Cart Rows To Dict
    [Documentation]    Keyword for getting all rows in cart, and returns these as a dictionary.
    ...    Informations to store: name,quantity,price           Name is the key to an inner dictionary, that contains quantity and price for the corresponding product.
    ...    Return:   A dictionary containing informations about the products in cart.
    &{rows}=   Create Dictionary
    ${row_selector}=    Get Selector From Objects    Cart::Rows
    ${count}=   Get Element Count   ${row_selector}
    Set To Dictionary   ${rows}   length=${count}
    ${count}=   Evaluate   ${count}+1
    FOR   ${number}   IN RANGE  1   ${count}   1
       ${selector}=    Get Selector From Objects    Cart::Name
       ${name}=   Get Text   ${row_selector}:nth-child(${number}) ${selector}
       ${selector}=    Get Selector From Objects    Cart::Price
       ${price}=    Get Text   ${row_selector}:nth-child(${number}) ${selector}
       ${selector}=    Get Selector From Objects    Cart::Quantity
       ${quantity}=    Get Element Attribute   ${row_selector}:nth-child(${number}) ${selector}   value
       &{actual_row}=   Create Dictionary   price=${price}   quantity=${quantity}
       Set To Dictionary   ${rows}   ${name}=${actual_row}
    END
    [Return]   ${rows}
Get Cart Total Price   [Arguments]   ${name}
    [Documentation]    Keyword for getting the total price of cart.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    Return:   Total price of cart as a string.
    ${text}=    Wait And Get Element Text   ${name}
    ${text} =    Replace String   ${text}   $  ${EMPTY}
    [Return]   ${text}
Get Cart Row Total Price By Index   [Arguments]   ${index}
    [Documentation]    Keyword for getting the total price of a product in cart.
    ...    @param1:   Index of element in cart. Index starts with 1.
    ...    Return:   Total price of the product in cart as a string.
    ${row_selector}=    Get Selector From Objects    Cart::Rows
    ${selector}=    Get Selector From Objects    Cart::Row Total Price
    ${text}=    Get Text   ${row_selector}:nth-child(${index}) ${selector}
    ${text} =    Replace String   ${text}   $  ${EMPTY}
    [Return]   ${text}
Delete A Row By Index   [Arguments]   ${index}
    [Documentation]    Keyword for deleting a product in cart by index. It also waits until page deleted the row.
    ...    @param1:   Index of element to delete in cart. Index starts with 1.
    ${row_selector}=    Get Selector From Objects    Cart::Rows
    ${count}=   Get Element Count   ${row_selector}
    ${selector}=    Get Selector From Objects    Cart::Delete
    Click Element   ${row_selector}:nth-child(${index}) ${selector}
    Wait Until Page Does Not Contain Element    ${row_selector}:nth-child(${count}) ${selector}
Get Order Reference
    [Documentation]    Keyword for getting order reference after successful ordering. It gets order reference by regexp, and returns it.
    ...    Return:   Order reference as a string.
    ${selector}=    Get Selector From Objects    Order Process Layer::Order Reference Section
    ${text}=    Get Text   ${selector}
    ${result_list}=   Get Regexp Matches   ${text}   order reference [a-zA-Z]* in
    ${text} =    Replace String   ${result_list[0]}   order reference${SPACE}  ${EMPTY}
    ${text} =    Replace String   ${text}   ${SPACE}in  ${EMPTY}
    [Return]   ${text}
Order List Should Contain   [Arguments]   ${order_reference}
    [Documentation]    Keyword to validate that order list contains a specific order reference.
    ...    It reads the references and returns True at correct match, otherwise it returns False.
    ...    Return:   True or False as a boolean, depending on success.
    ${row_selector}=    Get Selector From Objects    Order History Page::Order List
    ${count}=   Get Element Count   ${row_selector}
    ${count}=   Evaluate   ${count}+1
    ${success}=   Set Variable   ${False}  
    FOR   ${number}   IN RANGE  1   ${count}   1
       ${selector}=    Get Selector From Objects    Order History Page::Order Reference
       ${text}=    Get Text   ${row_selector}:nth-child(${number}) ${selector}
       ${success}=   Run Keyword If   '${text}'=='${order_reference}'   Set Variable   ${True}
       ...   ELSE   Set Variable   ${False}
       Run Keyword If   '${text}'=='${order_reference}'   EXIT FOR LOOP
    END
    [Return]   ${success}