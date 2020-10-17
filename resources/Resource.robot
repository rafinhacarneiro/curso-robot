*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}        http://automationpractice.com
${BROWSER}    chrome
${EMAIL}      PLACEHOLDER

*** Keywords ***

# Setup e Teardown
Abrir navegador
    Open Browser  ${URL}  ${BROWSER}

Fechar navegador
    Close Browser

# Passo à passo
Conferir se a página foi exibida
    Wait Until Element Is Visible  css:#center_column > .page-heading

Acessar a página home do site
    Sleep                          1s
    Go To                          ${URL}
    Sleep                          1s
    Title Should Be                My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text  id:search_query_top  ${PRODUTO}

Clicar no botão pesquisar
    Click Element  name:submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Conferir se a página foi exibida
    Title Should Be                      Search - My Store
    Page Should Not Contain Element      css:p.alert
    Element Should Contain               xpath://h5[@itemprop="name"]/a[@class="product-name"]  ${PRODUTO}  None  True
    
Conferir mensagem de erro "No results were found for your search "${PRODUTO}""
    Conferir se a página foi exibida
    Title Should Be                Search - My Store
    Element Text Should Be         css:p.alert  No results were found for your search "${PRODUTO}"

Passar o mouse por cima da categoria "${MENU_ITEM}" no menu principal superior de categorias
    Mouse Over  xpath://a[@title='${MENU_ITEM}']

Clicar na sub categoria "${SUBMENU_ITEM}"
    Click Element  xpath://a[@title='${SUBMENU_ITEM}']

Conferir se a categoria "${MENU_ITEM}" foi listada no site
    Conferir se a página foi exibida
    Element Text Should Be              css:span.category-name  ${MENU_ITEM}

Clicar no botão "Add to cart"
    Scroll Element Into View         css:span.available-now
    Mouse Over                       css:li.ajax_block_product
    Wait Until Element Is Visible    xpath://a[@title='Add to cart']
    Click Element                    xpath://a[@title='Add to cart']

Clicar no botão "Proceed to chekout"
    Wait Until Element Is Visible    id:layer_cart
    Click Element                    xpath://a[@title='Proceed to checkout']

Verificar se o produto "${PRODUTO}" foi adicionado ao carrinho
    Conferir se a página foi exibida
    Title Should Be                     Order - My Store
    Element Text Should Be              id:summary_products_quantity  1 Product

Clicar no ícone carrinho de compras no menu superior direito
    Click Element  xpath://a[@title='View my shopping cart']

Clicar no botão de remoção de produtos (delete) no produto do carrinho
    Conferir se a página foi exibida
    Scroll Element Into View            id:total_product
    Click Element                       xpath://a[@title='Delete']
    Conferir se a página foi exibida
    Page Should Contain Element         css:p.alert

Clicar no botão superior direito "Sign in"
    Click Element  xpath://a[@title='Log in to your customer account']

Inserir um e-mail válido
    Conferir se a página foi exibida
    ${EMAIL}                            Generate Random String  8  [LOWER][UPPER][NUMBERS]
    ${EMAIL} =                          Catenate  SEPARATOR=  ${EMAIL}  @teste.com.br
    Set Suite Variable                  ${EMAIL}
    Scroll Element Into View            id:SubmitCreate
    Input Text                          id:email_create  ${EMAIL}

Clicar no botão "Create na account"
    Click Element  id:SubmitCreate

Preencher os campos obrigatórios
    Wait Until Element Is Visible  css:div.account_creation
    ${PASSW}                       Generate Random String  5  [LOWER][UPPER][NUMBERS]
    Select Radio Button            id_gender              1
    Input Text                     id:customer_firstname  Teste
    Input Text                     id:customer_lastname   Teste
    Input Text                     id:email               ${EMAIL}
    Input Text                     id:passwd              ${PASSW}
    Scroll Element Into View       id:postcode
    Input Text                     id:firstname           Teste
    Input Text                     id:lastname            Teste
    Input Text                     id:address1            Teste
    Input Text                     id:city                Teste
    Input Text                     id:postcode            11111111
    Select From List By Value      id:id_state            1
    Scroll Element Into View       id:submitAccount
    Select From List By Value      id:id_country          21
    Input Text                     id:phone_mobile        11111111
    Input Text                     id:alias               My address


Clicar em "Register"para finalizar o cadastro
    Click Element  id:submitAccount
