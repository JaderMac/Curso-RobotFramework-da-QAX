*** Settings ***
Resource    ../Resources/base.resource
Resource    ../Resources/Pages/SignupPage.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuario
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    password=112233

    Remove user from database    ${user}[email]

    Go to signup Page
    Submit signup from      ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir cadastro com email duplicado
    [Tags]    dup

    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    password=112233

    Reset user from database    ${user} 

    Go to signup Page
    Submit signup from      ${user}
    Notice should be        Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}     
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar email incorreto
    [Tags]    inv
    ${user}    Create Dictionary
    ...    name=Charles Xavier
    ...    email=xavier.com.br 
    ...    password=112233
    
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senhas curtas
    [Tags]    shortCombo
    @{password-list}    Create List    1    12    123    1234    12345

    FOR    ${element}    IN    @{password-list}
        Short pass    ${element}
    END
    
*** Keywords ***
Short pass
    [Arguments]    ${shortpass}
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    password=${shortpass}   
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos