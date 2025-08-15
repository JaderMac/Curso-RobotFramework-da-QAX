*** Settings ***
Documentation    Testes cenários de cadastro de tarefas.

Resource    ../../Resources/base.resource
# Resource    ../../Resources/Pages/CreateTasksPage.resource

Library    JSONLibrary

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]      critical
    ${data}     Get fixture    tasks    create
    
    Reset user from database    ${data}[user]    

    Submit login form    ${data}[user]
    User should be logged in

    Go to Task Form

    Submit task form             ${data}[task]    
    Task should be registered    ${data}[task][name]

Não deve cadastrar tarefa duplicada
    [Tags]    duptask    
    
    ${data}     Get fixture    tasks    duplicate

    Reset user from database        ${data}[user] 
    Create a new task from API      ${data} 

    Do Login     ${data}[user]
    
    Go to Task Form
    Submit task form    ${data}[task]   
    Notice should be    Oops! Tarefa duplicada.
    
Não deve cadastrar tarefa com mais de 3 Tags
    [Tags]      tagslimit
    ${data}     Get fixture    tasks    tagslimit

    Reset user from database        ${data}[user] 
    Create a new task from API      ${data} 

    Do Login     ${data}[user]

    Go to Task Form
    Submit task form    ${data}[task]   
    Notice should be    Oops! Limite de tags atingido.