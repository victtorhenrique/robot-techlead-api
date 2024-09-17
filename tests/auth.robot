*** Settings ***

Resource    ../resources/resources.robot

*** Test Cases ***
Login com sucesso

    ${HEADERS}    Create Dictionary    Content-Type=Application/json
    
    Create Session    auth    ${AMBIENTE.URL}    ${HEADERS}    disable_warnings=${True}
    
    ${body}    Create Dictionary    mail=${USER}    
    ...    password=${PASSWORD}

    ${response}    POST On Session    auth    login/    json=${body}

    Status Should Be    200
    Dictionary Should Contain Key    ${response.json()}    token
