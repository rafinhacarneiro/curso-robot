*** Settings ***

Documentation     Requests Keywords: https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
...               Documentação da API: http://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books/

Library           RequestsLibrary
Library           Collections

*** Variables ***

${URL}         http://fakerestapi.azurewebsites.net/api/
${ENDPOINT}    Books/

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