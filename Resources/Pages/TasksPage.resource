*** Settings ***
Documentation    Ações da pagina de listagem de tarefas


Library    Browser
Resource    ../env.resource
Library    ../libs/database.py

*** Keywords ***
Task should be registered
    [Arguments]    ${task_name}
    Wait For Elements State    css=.task-todo >> text= ${task_name}
    ...    visible    3
   
Mark task completed
    [Arguments]    ${task_name}
    
    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]
    
    Wait For Elements State    ${element}    visible    5

    Click    ${element}

Request removal
    [Arguments]    ${task_name}
    
    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]
    
    Wait For Elements State    ${element}    visible    5

    Click    ${element}

Task should not exist 
    [Arguments]    ${task_name}
    
    Wait For Elements State    css=.task-todo >> text= ${task_name}
    ...    detached    3