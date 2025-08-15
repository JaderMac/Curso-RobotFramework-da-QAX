*** Settings ***

Resource    ../Resources/base.resource
Resource    ../Resources/Pages/LonginPage.resource


Test Setup    Start Session
Test Teardown    Take Screenshot

Library    ../Resources/libs/database.py
Library    String
Library    Collections

*** Test Cases ***
Deve poder logar com um usuário previamente cadastrado
    [Tags]    login
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    password=112233

    Reset user from database    ${user} 

    Submit login form   ${user}
    User should be logged in

Não deve poder logar com senha incorreta
    [Tags]    login
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    password=112233

    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Set To Dictionary    ${user}    password=001122           

    Submit login form   ${user}
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.