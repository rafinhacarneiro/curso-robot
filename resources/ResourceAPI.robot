*** Settings ***

Documentation     Requests Keywords: https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
...               Documentação da API: http://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books/

Library           RequestsLibrary
Library           Collections
Library           json

*** Variables ***

${URL}         http://fakerestapi.azurewebsites.net/api/
${ENDPOINT}    Books/

&{HEADERS}       content-type=application/json

&{DATA}          ID=0
...              Title=Teste,
...              Description=Teste
...              PageCount=0
...              Excerpt=Teste
...              PublishDate=2020-10-22T03:00:25.937Z

&{BOOK_FIXED}    ID=15
...              Title=Book 15
...              PageCount=1500

@{BOOK_VAR}      Description  Excerpt  PublishDate

*** Keywords ***

Conectar a API
    Create Session     fakeAPI  ${URL}

Requisitar todos os livros
    ${RESPONSE}            Get Request  fakeAPI  ${ENDPOINT}
    Set Test Variable      ${RESPONSE}

Requisitar o livro "${ID}"
    ${RESPONSE}            Get Request  fakeAPI  ${ENDPOINT}${ID}
    Set Test Variable      ${RESPONSE}

Cadastrar um livro
    ${REQ_DATA}            Json.Dumps    ${DATA}
    ${RESPONSE}            Post Request  alias=fakeAPI  uri=${ENDPOINT}
    ...                                  headers=${HEADERS}
    ...                                  data=${REQ_DATA}
    Set Test Variable      ${RESPONSE}

Alterar o livro "${ID}"
    ${REQ_DATA}            Json.Dumps    ${DATA}
    ${RESPONSE}            Put Request   alias=fakeAPI  uri=${ENDPOINT}${ID}
    ...                                  headers=${HEADERS}
    ...                                  data=${REQ_DATA}
    Set Test Variable      ${RESPONSE}

Deletar o livro "${ID}"
    ${RESPONSE}            Delete Request   fakeAPI  ${ENDPOINT}${ID}
    Set Test Variable      ${RESPONSE}

Conferir o status code
    [Arguments]        ${STATUS_CODE}
    Should Be Equal As Strings        ${RESPONSE.status_code}  ${STATUS_CODE}
    
Conferir o reason
    [Arguments]        ${REASON}
    Should Be Equal As Strings        ${RESPONSE.reason}  ${REASON}

Conferir se é retornado uma lista com "${QTD}" livros
    Length Should Be  ${RESPONSE.json()}  ${QTD}

Conferir se os dados retornados estão corretos
    FOR      ${KEY}        IN  @{BOOK_VAR}
        Should Not Be Empty             ${RESPONSE.json()['${KEY}']}
    END
    FOR  ${KEY}  ${VALUE}  IN  &{BOOK_FIXED}
        Dictionary Should Contain Item  ${RESPONSE.json()}  ${KEY}  ${VALUE}
    END

Conferir a resposta da API
    FOR  ${KEY}  ${VALUE}  IN  &{DATA}
        Dictionary Should Contain Item  ${RESPONSE.json()}  ${KEY}  ${VALUE}
    END

Conferir se o livro foi deletado
    Should Be Empty   ${RESPONSE.content}