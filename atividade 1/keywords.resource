*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://www.amazon.com.br/
${BROWSER}        Chrome

*** Keywords  ***
Abrir o navegador
    Open Browser        browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser
       
Acessar a home page do site Amazon.com.br
    Go To              ${LOGIN URL}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.
    Wait Until Element Is Visible   locator=twotabsearchtextbox

Digitar o nome de produto "${produto}" no campo de pesquisa
    Input Text      locator=twotabsearchtextbox     text=${produto}

Clicar no botão de pesquisa
    Click Element   locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${produto}"
    Wait Until Element Is Visible   locator=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${produto}')])[1]
    
Adicionar o produto "${produto}" no carrinho
    Click Element   locator=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${produto}')])[1]
    Wait Until Element Is Visible   locator=//span[@class='a-size-large product-title-word-break'][contains(.,'${produto}')]
    Click Element   locator=//input[contains(@name,'submit.add-to-cart')]

Verificar se o produto "${produto}" foi adicionado com sucesso
    Wait Until Element Is Visible   locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')] 
    Click Element    locator=//a[@href='/gp/cart/view.html?ref_=sw_gtc'][contains(.,'Ir para o carrinho')] 
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'${produto}')]

Remover o produto "${produto}" do carrinho
    Click Element    locator=//input[@value='Excluir']

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible   locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]
