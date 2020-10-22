*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${URL}                   http://automationpractice.com
${BROWSER}               chrome
@{LIST_SUBMENU_ITEMS}    Printed Summer Dress  Printed Summer Dress  Printed Chiffon Dress
&{DICT_PESSOA}           customer_firstname=Teste  customer_lastname=Teste  firstname=Teste  lastname=Teste
...                      address1=Teste  city=Teste  postcode=11111111  id_state=1  id_country=21 
...                      phone_mobile=11111111  alias=My address  id_gender=1

*** Keywords ***

# Setup e Teardown
Exemplo de log de variáveis
    Log  ${BROWSER}
    Log  ${LIST_FRUTAS[0]}
    Log  ${DICT_PESSOAS.firstname}

Abrir navegador
    Open Browser  ${URL}  ${BROWSER}

Fechar navegador
    Close Browser

# Passo à passo
Conferir se a página foi exibida
    Wait Until Element Is Visible  css:#center_column > .page-heading

Criar um email válido
    [Arguments]  ${FIRSTNAME}  ${LASTNAME}
    ${RANDOM}                  Generate Random String  8  [LOWER][UPPER][NUMBERS]
    ${EMAIL} =                 Catenate  SEPARATOR=  ${FIRSTNAME}  ${LASTNAME}  ${RANDOM}  @teste.com.br
    [Return]  ${EMAIL}

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

Clicar na subcategoria "${SUBMENU_ITEM}"
    Click Element  xpath://a[@title='${SUBMENU_ITEM}']

Conferir se a categoria "${MENU_ITEM}" foi listada no site
    Conferir se a página foi exibida
    Element Text Should Be              css:span.category-name  ${MENU_ITEM}

Conferir se a subcategoria "${SUBMENU_ITEM}" foi listada no site
    Page Should Contain Element        xpath=//*[@id="center_column"]/h1/span[contains(text(), "${SUBMENU_ITEM}")]
    FOR  ${ITEM}  IN  @{LIST_SUBMENU_ITEMS}
        ${I} =                         Get Index From List  ${LIST_SUBMENU_ITEMS}  ${ITEM}
        ${I} =                         Evaluate  ${I} + 1
        Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[${I}]/div/div[2]/h5/a[@title="${ITEM}"]
    END

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
    ${EMAIL} =                          Criar um email válido  ${DICT_PESSOA.customer_firstname}  ${DICT_PESSOA.customer_lastname}
    ${PASSWD}                           Generate Random String  5  [LOWER][UPPER][NUMBERS]
    Set To Dictionary                   ${DICT_PESSOA}  email=${EMAIL}  passwd=${PASSWD}
    Scroll Element Into View            id:SubmitCreate
    Input Text                          id:email_create  ${DICT_PESSOA.email}

Clicar no botão "Create na account"
    Click Element  id:SubmitCreate

Preencher os campos obrigatórios
    Wait Until Element Is Visible  css:div.account_creation
    Select Radio Button            id_gender              ${DICT_PESSOA.id_gender}
    Input Text                     id:customer_firstname  ${DICT_PESSOA.customer_firstname}
    Input Text                     id:customer_lastname   ${DICT_PESSOA.customer_lastname}
    Input Text                     id:email               ${DICT_PESSOA.email}
    Input Text                     id:passwd              ${DICT_PESSOA.passwd}
    Scroll Element Into View       id:postcode
    Input Text                     id:firstname           ${DICT_PESSOA.firstname}
    Input Text                     id:lastname            ${DICT_PESSOA.lastname}
    Input Text                     id:address1            ${DICT_PESSOA.address1}
    Input Text                     id:city                ${DICT_PESSOA.city}
    Input Text                     id:postcode            ${DICT_PESSOA.postcode}
    Select From List By Value      id:id_state            ${DICT_PESSOA.id_state}
    Scroll Element Into View       id:submitAccount
    Select From List By Value      id:id_country          ${DICT_PESSOA.id_country}
    Input Text                     id:phone_mobile        ${DICT_PESSOA.phone_mobile}
    Input Text                     id:alias               ${DICT_PESSOA.alias}


Clicar em "Register"para finalizar o cadastro
    Click Element  id:submitAccount
