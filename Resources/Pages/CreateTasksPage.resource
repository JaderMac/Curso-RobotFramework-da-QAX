*** Settings ***
Documentation    Ações da pagina de criação de tarefas

Library     Browser
Library     ../libs/database.py

Resource    ../env.resource

*** Keywords ***
Submit task form    
    [Arguments]     ${task}
    Fill Text       css=input[placeholder$="tarefa"]    ${task}[name]

    ${tags-element}    Set Variable   css=input[name=tags] 

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text      ${tags-element}     ${tag}
        Sleep          1                   # Thinking Time Sleep    
        Press Keys     ${tags-element}     Enter
    END

    Click    css=button >> text=Cadastrar