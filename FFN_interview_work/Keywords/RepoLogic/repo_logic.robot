*** Settings ***
Library   String
Library   Collections
Variables   ../../Objects/automationpractice_objects.yaml

*** Keywords ***
Get Selector From Objects  [Arguments]   ${name}
    [Documentation]    Keyword for getting selector by given name from the object store.
    ...    @param1:   Name of the object to locate in the Object Repository. For example: Landing Page::Sign In
    ...    Return:  Selector of the corresponding object as a string.
    @{dataTreeList} =   Split String   ${name}   ::
    ${cnt}=    Get length    ${dataTreeList}
    ${first}=   Get From List   ${dataTreeList}   0
    Remove From List   ${dataTreeList}   0
    ${temp}=   Set Variable   ${first}
    FOR   ${element}   IN   @{dataTreeList}
       ${temp}=   Run Keyword If   "${temp}"=="${first}"   Get From Dictionary   ${${temp}}   ${element}
        ...   ELSE   Get From Dictionary   ${temp}   ${element}
    END
    ${temp}=   Run Keyword If   "${cnt}"=="1"   Set Variable   ${${temp}}
    ...   ELSE   Set Variable   ${temp}
    [Return]   ${temp}