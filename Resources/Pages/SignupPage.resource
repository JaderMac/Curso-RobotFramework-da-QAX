*** Settings ***
Documentation    Elementos e ações da página de cadastro

Library    Browser
Resource    ../env.resource

*** Keywords ***
Go to signup Page
    Go To    ${BASE_URL}/signup
    Wait For Elements State    xpath=//h1    visible    3
    Get Text                   xpath=//h1    equal      Faça seu cadastro

Submit signup from
    [Arguments]    ${user}
    Fill Text    id=name        ${user}[name] 
    Fill Text    id=email       ${user}[email]
    Fill Text    id=password    ${user}[password]    
    Click        id=buttonSignup

