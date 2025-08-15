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
    ...    senha=112233

    Remove user from database    ${user}[email]

    Go to signup Page
    Submit signup from      ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir cadastro com email duplicado
    [Tags]    dup

    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=112233

    Remove user from database    ${user}[email]    
    Insert user from database    ${user}

    Go to signup Page
    Submit signup from      ${user}
    Notice should be        Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    senha=${EMPTY}     
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
    ...    senha=112233
    
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha de 1 digito
    [Tags]    short
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=1    
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos
Não deve cadastrar com senha de 2 digito
    [Tags]    short
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=12       
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 3 digito
    [Tags]    short
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=123      
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 4 digito
    [Tags]    short
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=1234      
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 5 digito
    [Tags]    short
    ${user}    Create Dictionary
    ...    name=Jader Machado
    ...    email=jadermachado@gmail.com
    ...    senha=12345     
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha curtas - 1 digito
    [Tags]    shortTemplate
    [Template]
    Short pass    1

Não deve cadastrar com senha curtas - 2 digito
    [Tags]    shortTemplate
    [Template]
    Short pass    12

Não deve cadastrar com senha curtas - 3 digito
    [Tags]    shortTemplate
    [Template]
    Short pass    123
Não deve cadastrar com senha curtas - 4 digito
    [Tags]    shortTemplate
    [Template]
    Short pass    1234

Não deve cadastrar com senha curtas - 5 digito
    [Tags]    shortTemplate
    [Template]
    Short pass    12345

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
    ...    senha=${shortpass}   
    Go to signup Page
    Submit signup from      ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos