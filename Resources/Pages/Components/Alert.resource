*** Settings ***

Documentation    Ações em elementos do componente de Alerta

Library    Browser

*** Keywords ***
Alert should be
    [Arguments]    ${expected_text}
    Wait For Elements State    css=.alert-error >> text=${expected_text}    
    ...    visible    5