*** Settings ***
Documentation    Elementos e ações da página de login

Library    Browser
Resource    ../env.resource
Library    ../libs/database.py

*** Keywords ***
Submit login form
    [Arguments]    ${user}
    Fill Text      css=input[placeholder$="mail"]    ${user}[email]
    Fill Text      css=input[placeholder="Senha"]    ${user}[password]
    Click          xpath=//button[text()="Entrar"]
    # Click        css=button >> text = "Entrar"


