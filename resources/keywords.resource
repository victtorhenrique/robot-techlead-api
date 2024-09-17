*** Settings ***
Documentation    Arquivo que irá conter keyword de login

Resource    resources.robot

*** Keywords ***
Auth

    ${HEADERS}    Create Dictionary    Content-Type=Application/json
    
    Create Session    auth    ${AMBIENTE.URL}    ${HEADERS}    disable_warnings=${True}
    
    ${body}    Create Dictionary    mail=${USER}    
    ...    password=${PASSWORD}

    ${response}    POST On Session    auth    login/    json=${body}

    Status Should Be    200
    Dictionary Should Contain Key    ${response.json()}    token

    ${TOKEN_ADMIN}    Set Variable   ${response.json()["token"]}

    ${CPF}          Generate Random String    length=11    chars=[NUMBERS]
    ${NOME}         Generate Random String    length=8     chars=[LETTERS]
    ${SOBRENOME}    Generate Random String    length=8     chars=[LETTERS]
    ${FULL_NAME}    Catenate    T${NOME}     T${SOBRENOME}
    ${mail}    Set Variable         teste${CPF}@qa-coders.com.br 

    ${body}    Create Dictionary    
    ...    fullName=${FULL_NAME}
    ...    mail=${mail}
    ...    accessProfile=ADMIN
    ...    cpf=${CPF}
    ...    password=1234@Test
    ...    confirmPassword=1234@Test   
    
    Set To Dictionary    ${HEADERS}    Authorization=${TOKEN_ADMIN}

    ${response_post_user}    POST On Session    auth        user/    json=${body}    headers=${HEADERS}
    
    ${body}    Create Dictionary    mail=${response_post_user.json()["user"]["mail"]}    
    ...    password=1234@Test
    
    ${response_login_new_user}    POST On Session    auth    login/    json=${body}
    Set Test Variable    ${TOKEN}    ${response_login_new_user.json()["token"]}


Gerar um Novo Usuario
    
    ${PRIMEIRO_NOME}    FakerLibrary.First Name
    ${ULTIMO_NOME}      FakerLibrary.Last Name
    ${FULL_NAME}        Catenate    ${PRIMEIRO_NOME}    ${ULTIMO_NOME}

    ${CPF}          FakerLibrary.cpf
    ${CPF}          Remove String    ${CPF}    .    -
    ${MAIL}         FakerLibrary.Email

    ${body}    Create Dictionary    
    ...    fullName=${FULL_NAME}
    ...    mail=${MAIL}
    ...    accessProfile=ADMIN
    ...    cpf=${CPF}
    ...    password=1234@Test
    ...    confirmPassword=1234@Test 
    
    RETURN    ${body}

Gerar Usuario Criado
    
    ${PRIMEIRO_NOME}    FakerLibrary.First Name
    ${ULTIMO_NOME}      FakerLibrary.Last Name
    ${FULL_NAME}        Catenate    ${PRIMEIRO_NOME}    ${ULTIMO_NOME}
    ${MAIL}         FakerLibrary.Email

    ${body}    Create Dictionary    
    ...    fullName=${FULL_NAME}
    ...    mail=${MAIL}

    RETURN    ${body}
