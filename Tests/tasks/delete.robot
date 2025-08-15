*** Settings ***
Documentation    Testes cenários de cadastro de tarefas.

Resource    ../../Resources/base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder marcar uma tarefa como concluida
    [Tags]    deleted
    ${data}     Get fixture    tasks    delete

    Reset user from database    ${data}[user]  

    Post a user session    ${data}[user]    
    Post a new task        ${data}[task]

    Do Login    ${data}[user]

    Request removal    ${data}[task][name]

    Task should not exist    ${data}[task][name] 