*** Settings ***

Resource        ../resources/resources.robot

Test Setup      Auth


*** Test Cases ***
Cadastrar nova Company
    
    ${dict_adrres}    Create Dictionary
    ...    zipCode=04777001
    ...    city=São Paulo
    ...    state=SP
    ...    district=Rua das Flores
    ...    street=Avenida Interlagos
    ...    number=50
    ...    complement=de 4503 ao fim - lado ímpar
    ...    country=Brazil

    ${address}    Create List    ${dict_adrres}

    ${body}    Create Dictionary    
    ...    corporateName=Control Testes Delivery
    ...    registerCompany=12126456000669
    ...    mail=lima12463@qacoders.com
    ...    matriz=Principal
    ...    responsibleContact=Marcio
    ...    telephone=99999999999999
    ...    serviceDescription=Desenvolvimento
    ...    address=${address}
    
    ${HEADERS}    Create Dictionary    Authorization=${TOKEN}    Content-Type=Application/json

    Create Session    company    ${AMBIENTE.URL}

    ${response}    POST On Session    company    company/    headers=${HEADERS}    json=${body}

    Status Should Be    201    
    Should Be Equal    ${response.json()['newCompany']['corporateName']}    ${body.corporateName}
    Should Be Equal    ${response.json()['newCompany']['address'][0]['country']}     ${body.address[0]['country']}   
