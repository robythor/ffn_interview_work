*** Settings ***
Resource    ../Keywords/UserKeywords/user_keywords.robot

*** Test Cases ***
Delete products from cart 
    [Documentation]   User is able to delete items from the cart
    ...               User sees the TOTAL price amount decreasing
    ...               The reduction equals the price amount of the item that has been deleted
    ...               Whenever the last item is removed from the cart the page states that the shopping cart is empty
                                Open Browser And Go To               http://automationpractice.com/index.php
                                Click Nth Element In Product List    Product List::List                           1
                                Add Element To Cart
                                Click To                             Product Page::Layer::Continue Shopping
                                Click To                             Product Page::Home
                                Click Nth Element In Product List    Product List::List                           2
                                Add Element To Cart
                                Click To                             Product Page::Layer::Continue Shopping
                                Click To                             Product Page::Home
                                Click To                             Landing Page::Cart    
    ${expected_total_price}=    Get Cart Total Price                 Cart::Total Price
    ${row_price}=               Get Cart Row Total Price By Index    1
                                Delete A Row By Index                1
    ${expected_total_price}=    Evaluate                             ${expected_total_price}-${row_price}
    ${expected_total_price}=    Evaluate                             "%.2f" % ${expected_total_price}
    ${total_price}=             Get Cart Total Price                 Cart::Total Price
                                Should Be Equal As Strings           '${expected_total_price}'                    '${total_price}'
                                Log                                  User is able to delete items from the cart
                                Log                                  User sees the TOTAL price amount decreasing
                                Log                                  The reduction equals the price amount of the item that has been deleted
                                Delete A Row By Index                1
    ${empty_message}=           Wait And Get Element Text            Cart::Empty Message
                                Should Be Equal As Strings           ${empty_message}                             Your shopping cart is empty.
                                Log                                  Whenever the last item is removed from the cart the page states that the shopping cart is empty
                                Close Current Browser