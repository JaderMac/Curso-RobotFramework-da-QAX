*** Settings ***

Documentation    Ações em elementos do componente header

Library    Browser

*** Keywords ***

User should be logged in
    Wait For Elements State    css=header .right small    visible    5
    Get Text    css=header .right small    contains    Olá,

Go to Task Form
    Click    css=.button-add