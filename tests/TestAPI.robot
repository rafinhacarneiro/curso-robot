*** Settings ***
Resource   ../resources/ResourceAPI.robot

Suite Setup       Conectar a API

*** Test Case ***

Buscar a listagem de todos os livros
    Requisitar todos os livros
    Conferir o status code        200
    Conferir o reason             OK
    Conferir se é retornado uma lista com "200" livros

Buscar livro específico
    Requisitar o livro "15"
    Conferir o status code        200
    Conferir o reason             OK
    Conferir se os dados retornados estão corretos

# *** Keywords ***