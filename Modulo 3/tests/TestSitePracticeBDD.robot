*** Settings ***
Library    Selenium

*** Variables ***
${URL}        https://automationpractice.com
${BROWSER}    chrome

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