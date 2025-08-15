*** Settings ***
Documentation    Implantação de template de testes a nível de suite

Resource    ../Resources/base.resource
Resource    ../Resources/Pages/SignupPage.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

Test Template    Short pass

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

*** Test Cases ***
Não deve cadastrar com senha curtas - 1 digito
    [Tags]    shortSuitTemplate
    [Template]
    Short pass    1

Não deve cadastrar com senha curtas - 2 digitos
    [Tags]    hortSuitTemplate
    [Template]
    Short pass    12

Não deve cadastrar com senha curtas - 3 digitos
    [Tags]    shortSuitTemplate
    [Template]
    Short pass    123
Não deve cadastrar com senha curtas - 4 digitos
    [Tags]    shortSuitTemplate
    [Template]
    Short pass    1234

Não deve cadastrar com senha curtas - 5 digitos
    [Tags]    shortSuitTemplate
    [Template]
    Short pass    12345