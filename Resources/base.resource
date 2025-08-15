*** Settings ***
Library    ../Resources/libs/database.py
Library    Browser
Library    JSONLibrary
Library    RequestsLibrary

Resource    env.resource
Resource    services.resource
Resource    Pages/Components/Notice.resource
Resource    Pages/Components/Alert.resource
Resource    Pages/Components/Header.resource

Resource    Pages/SignupPage.resource
Resource    Pages/LonginPage.resource
Resource    Pages/CreateTasksPage.resource
Resource    Pages/TasksPage.resource

*** Keywords ***
Start Session
    New Browser    browser=${BROWSER}    headless=false 
    New Page    ${BASE_URL}

#Helper
Get fixture
    [Arguments]    ${filename}    ${scenario}
    ${data}     Load Json From File    
    ...    ${EXECDIR}/Resources/fixtures/${filename}.json    encoding=utf-8  
    Log         ${data}   

    RETURN    ${data}[${scenario}]

Reset user from database
    [Arguments]    ${user}
    Clean user from database   ${user}[email]
    Insert user from database  ${user}

Create a new task from API
    [Arguments]    ${data} 
    Post a user session    ${data}[user] 
    Post a new task        ${data}[task]         

Do Login    
    [Arguments]    ${user}
    Submit login form    ${user}
    User should be logged in