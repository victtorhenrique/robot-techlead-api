*** Settings ***

Resource        ../resources/resources.robot

Test Setup      Auth


*** Test Cases ***
Cadastro de um usuário com sucesso
    
    ${body}    Gerar um Novo Usuario
    
    ${HEADERS}    Create Dictionary    Content-Type=Application/json
    ...    Authorization=${TOKEN}

    ${response_post_user}    POST On Session    auth    ${AMBIENTE.ENDPOINTS.USER}    json=${body}    headers=${HEADERS}
    
    Status Should Be    201

    Dictionary Should Contain Key     ${response_post_user.json()["user"]}    _id  
    Dictionary Should Contain Item    ${response_post_user.json()}            msg    Olá ${body.fullName}, cadastro realizado com sucesso.
    Dictionary Should Contain Item    ${response_post_user.json()["user"]}    mail   ${body.mail}
    Dictionary Should Contain Item    ${response_post_user.json()["user"]}    cpf    ${body.cpf}

    Set Test Variable    ${ID}        ${response_post_user.json()["user"]["_id"]}

    ${response_get_user}    GET On Session    auth     ${AMBIENTE.ENDPOINTS.USER}${ID}   headers=${HEADERS}

    Status Should Be    200

    Should Be Equal    ${response_get_user.json()["_id"]}    ${ID}
    
    Should Be Equal    ${response_post_user.json()["user"]["mail"]}    ${response_get_user.json()["mail"]}
    Should Be Equal    ${body.mail}    ${response_get_user.json()["mail"]}


Atualizar um usuario criado

    ${HEADERS}    Create Dictionary    Content-Type=Application/json
    ...    Authorization=${TOKEN}

    ${body}    Gerar um Novo Usuario

    ${response_post_user}    POST On Session    auth    ${AMBIENTE.ENDPOINTS.USER}    json=${body}    headers=${HEADERS}
    
    Status Should Be    201

    Set Test Variable    ${ID}        ${response_post_user.json()["user"]["_id"]}

    ${body}    Gerar Usuario Criado

    ${response}    PUT On Session    auth    ${AMBIENTE.ENDPOINTS.USER}${ID}    json=${body}    headers=${HEADERS}

    Status Should Be    200
    Dictionary Should Contain Item    ${response.json()}    msg    Dados atualizados com sucesso!
       