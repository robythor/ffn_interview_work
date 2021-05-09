*** Settings ***
Resource    ../Keywords/UserKeywords/user_keywords.robot

*** Test Cases ***
Add products to cart from Popular tab on Home Page 
    [Documentation]   User is able to add multiple items to the cart from the Popular tab on the Home Page
    ...               User sees message that the item has been successfully added to the cart
    ...               User sees product count updating in the cart on the Home Page
    ...               Upon navigating to the cart user sees the same items in the cart that were previously added
    ...               User sees the same quantity of items that were previously added
    ...               User sees the same price of items that were previously added
    
                                    Open Browser And Go To                    http://automationpractice.com/index.php
    ${expected_cart_quantity}=      Get Element Text                          Landing Page::Cart Quantity Counter
                                    Click Nth Element In Product List         Product List::List                                        2
    ${first_product}=               Add Element To Cart
    ${expected_cart_quantity}=      Evaluate                                  ${expected_cart_quantity}+${first_product["quantity"]}
                                    Text Should Be Equal                      Product Page::Layer::Success Message                      Product successfully added to your shopping cart
                                    Log                                       User sees message that the item has been successfully added to the cart
                                    Click To                                  Product Page::Layer::Continue Shopping
                                    Click To                                  Product Page::Home
                                    Text Should Be Equal                      Landing Page::Cart Quantity Counter                       ${expected_cart_quantity}
                                    Log                                       User sees product count updating in the cart on the Home Page
    
                                    Click Nth Element In Product List         Product List::List                                        4
    ${second_product}=              Add Element To Cart
    ${expected_cart_quantity}=      Evaluate                                  ${expected_cart_quantity}+${second_product["quantity"]}
                                    Text Should Be Equal                      Product Page::Layer::Success Message                      Product successfully added to your shopping cart
                                    Click To                                  Product Page::Layer::Continue Shopping
                                    Click To                                  Product Page::Home
                                    Text Should Be Equal                      Landing Page::Cart Quantity Counter                       ${expected_cart_quantity}
                                    Log                                       User is able to add multiple items to the cart from the Popular tab on the Home Page
                                    
                                    Click Nth Element In Product List         Product List::List                                        5
    ${third_product}=               Add Element To Cart
    ${expected_cart_quantity}=      Evaluate                                  ${expected_cart_quantity}+${third_product["quantity"]}
                                    Text Should Be Equal                      Product Page::Layer::Success Message                      Product successfully added to your shopping cart
                                    Click To                                  Product Page::Layer::Continue Shopping
                                    Click To                                  Product Page::Home
                                    Text Should Be Equal                      Landing Page::Cart Quantity Counter                       ${expected_cart_quantity}
    
                                    Click To                                  Landing Page::Cart
    ${cart_rows}=                   Get Cart Rows To Dict
                                    Should Not Be Equal                       ${cart_rows['${first_product['name']}']}                  ${None}
                                    Should Be Equal As Strings                ${cart_rows['${first_product['name']}']['price']}         ${first_product['price']}
                                    Should Be Equal As Strings                ${cart_rows['${first_product['name']}']['quantity']}      ${first_product['quantity']}
    
                                    Should Not Be Equal                       ${cart_rows['${second_product['name']}']}                 ${None}
                                    Should Be Equal As Strings                ${cart_rows['${second_product['name']}']['price']}        ${second_product['price']}
                                    Should Be Equal As Strings                ${cart_rows['${second_product['name']}']['quantity']}     ${second_product['quantity']}
    
                                    Should Not Be Equal                       ${cart_rows['${third_product['name']}']}                  ${None}
                                    Should Be Equal As Strings                ${cart_rows['${third_product['name']}']['price']}         ${third_product['price']}
                                    Should Be Equal As Strings                ${cart_rows['${third_product['name']}']['quantity']}      ${third_product['quantity']}
                                    Log                                       Upon navigating to the cart user sees the same items in the cart that were previously added
                                    Log                                       User sees the same quantity of items that were previously added
                                    Log                                       User sees the same price of items that were previously added
                                    Should Be Equal As Integers               ${cart_rows.length}                                       3
                                    Close Current Browser