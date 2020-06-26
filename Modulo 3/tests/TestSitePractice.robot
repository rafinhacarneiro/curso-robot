*** Settings ***
Library    Selenium

*** Variables ***
${URL}        https://automationpractice.com
${BROWSER}    chrome

*** Test Case ***
Caso de Teste 01: Pesquisar produto existente
    Acessar a página home do site
    Conferir se a página foi exibida
    Digitar o nome do produto "Blouse" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir se o produto "Blouse" foi listado no site

Caso de Teste 02: Pesquisar produto não existente
    Acessar a página home do site
    Conferir se a página foi exibida
    Digitar o nome do produto "produtoNãoExistente" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir mensagem de erro "No results were found for your search "produtoNãoExistente""

*** Keywords ***