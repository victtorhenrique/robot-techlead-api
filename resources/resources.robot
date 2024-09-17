*** Settings ***
Documentation    Arquivo que ira conter todos as fixtures, keywords, librares, Variables

Library     RequestsLibrary
Library     Collections
Library     String
Library     FakerLibrary    locale=pt_BR

Variables    ../fixtures/data.yaml
Variables    ../fixtures/enviorements.yaml

Resource    keywords.resource
