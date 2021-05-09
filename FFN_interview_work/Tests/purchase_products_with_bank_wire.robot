*** Settings ***
Resource    ../Keywords/UserKeywords/user_keywords.robot
Test Setup   Data Init   Purchase products with bank wire

*** Test Cases ***
Purchase products with bank wire
    [Documentation]   User is able to successfully purchase products that have been added to the cart with bank wire
    ...               Upon order confirmation the order appears on the ‘My Orders’ page
    ...               User sees the same ‘order reference’ that was given on order completion
    
                            Open Browser And Go To               http://automationpractice.com/index.php
                            Click Nth Element In Product List    Product List::List                                      2
                            Add Element To Cart
						    Click To                             Product Page::Layer::Proceed To Checkout
						    Click To                             Cart::Proceed To Checkout
						    Write Text                           Authentication Page::Already Registered::Email          ${INPUT_DATA['Email']}
						    Write Text                           Authentication Page::Already Registered::Password       ${INPUT_DATA['Password']}
						    Click To                             Authentication Page::Already Registered::Sign In
						    Click To                             Order Process Layer::Proceed to checkout
                            Click To                             Order Process Layer::Terms
                            Click To                             Order Process Layer::Shipping Proceed To Checkout
                            Click To                             Order Process Layer::Bankwire Payment
                            Click To                             Order Process Layer::Confirm My Order
                            Text Should Be Equal                 Order Process Layer::Success Message                    Your order on My Store is complete.
                            Log                                  User is able to successfully purchase products that have been added to the cart with bank wire
    ${order_reference}=     Get Order Reference
                            Click To                             Dashboard::User Name
                            Click To                             My Account::Order History
    ${success}=             Order List Should Contain            ${order_reference}
                            Should Be True                       ${success}
                            Log                                  Upon order confirmation the order appears on the ‘My Orders’ page
                            Log                                  User sees the same ‘order reference’ that was given on order completion
                            Click To                             Dashboard::Logout
                            Close Current Browser