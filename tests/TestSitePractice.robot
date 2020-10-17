*** Settings ***
Resource   ../resources/Resource.robot

Suite Setup       Abrir navegador
Suite Teardown    Fechar navegador

Test Setup         Acessar a página home do site
#Test Teardown     Fechar navegador

*** Test Case ***
Caso de Teste 01: Pesquisar produto existente
    Digitar o nome do produto "Blouse" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir se o produto "Blouse" foi listado no site

Caso de Teste 02: Pesquisar produto não existente
    Digitar o nome do produto "produtoNãoExistente" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir mensagem de erro "No results were found for your search "produtoNãoExistente""

Caso de Teste 03: Listar produtos
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Clicar na sub categoria "Summer Dresses"
    Conferir se a categoria "Summer Dresses" foi listada no site

Caso de Teste 04: Adicionar produtos no carrinho
    Digitar o nome do produto "t-shirt" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir se o produto "t-shirt" foi listado no site
    Clicar no botão "Add to cart"
    Clicar no botão "Proceed to chekout"
    Verificar se o produto "t-shirt" foi adicionado ao carrinho

Caso de Teste 05: Remover produtos
    Clicar no ícone carrinho de compras no menu superior direito
    Clicar no botão de remoção de produtos (delete) no produto do carrinho

Caso de Teste 06: Adicionar cliente
    Clicar no botão superior direito "Sign in"
    Inserir um e-mail válido
    Clicar no botão "Create na account"
    Preencher os campos obrigatórios
    Clicar em "Register"para finalizar o cadastro
    
# *** Keywords ***