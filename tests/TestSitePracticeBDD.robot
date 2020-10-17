*** Settings ***
Resource   ../resources/Resource.robot

#Suite Setup
#Suite Teardown

Test Setup        Abrir navegador
Test Teardown     Fechar navegador

*** Test Case ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar o produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultados da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar o produto "produtoNãoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "produtoNãoExistente""

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar o produto "${PRODUTO}"
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão pesquisar

Então o produto "${PRODUTO}" deve ser listado na página de resultados da busca
    Conferir se o produto "${PRODUTO}" foi listado no site

Então a página deve exibir a mensagem "No results were found for your search "${PRODUTO}""
    Conferir mensagem de erro "No results were found for your search "${PRODUTO}""