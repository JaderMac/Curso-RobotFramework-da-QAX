*** Settings ***
Resource    ../Resources/base.resource

*** Test Cases ***
Verifica se Mark está online
    Start Session
    Get Title    equal    Mark85 by QAx
