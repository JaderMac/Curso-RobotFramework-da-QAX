*** Settings ***

Documentation    Ações em elementos do componente de Notificação

Library    Browser

*** Keywords ***
Notice should be   
    [Arguments]    ${expected_message}
    ${Element}    Set Variable    css=.notice p

    Wait For Elements State    css=.notice p    visible    5
    Get Text    css=.notice p    equal   ${expected_message} 