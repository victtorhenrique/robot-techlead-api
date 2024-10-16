*** Settings ***

Documentation    Arquivo que ira conter todos as fixtures, keywords, librares, Variables

Library     RequestsLibrary
Library     Collections
Library     String
Library     FakerLibrary    locale=pt_BR

Variables    ../fixtures/environment/${ENV}.yaml
Variables    ../fixtures/data/user_env.yaml

Resource    keywords.resource

*** Variables ***
${ENV}    default