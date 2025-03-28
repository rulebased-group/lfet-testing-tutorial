*** Settings ***
Library     Collections
Library     String
Library     Browser

*** Variables ***
&{JPETSTORE}            url=http://localhost:8080/jpetstore/
...                     title=JPetStore Demo

&{JPET_HEADER}          xpath_logo=xpath=//div[@id="Header"]//div[@id="Logo"]//a[contains(@href, "Catalog.action")]
...                     xpath_warenkorb=//div[@id="Header"]//div[@id="Menu"]//a[contains(@href, "viewCart")]
...                     xpath_anmeldung=xpath=//div[@id="Header"]//div[@id="Menu"]//a[contains(@href, "signonForm")]
...                     xpath_abmeldung=xpath=//div[@id="Header"]//div[@id="Menu"]//a[contains(@href, "signoff")]

&{JPET_SIGNONFORM}      xpath_username=xpath=//form[@id="signon"]//input[@name="username"]
...                     xpath_password=xpath=//form[@id="signon"]//input[@name="password"]
...                     xpath_submit=xpath=//form[@id="signon"]//input[@name="signon"]

&{JPET_CART}            xpath_warenkorb=xpath=//div[@id='Content']//table[@id='cart']
...                     xpath_gesamtsumme=xpath=//div[@id='Content']//table[@id='cart']//td[@id='cart.summary.total']
...                     xpath_aktualisieren=xpath=//div[@id='Content']//table[@id='cart']//tr[@id='cart.summary']//input[@name='updateCartQuantities']
...                     xpath_zur_kasse=//div[@id='Content']//div[@id='Cart']//a[contains(@href,'newOrderForm')]

&{JPET_NEWORDER}        xpath_orderdaten=xpath=//div[@id='Content']//table[@id='order']
...                     xpath_zahlungsmittel=xpath=//div[@id='Content']//table[@id='order']//select[@name='order.cardType']
...                     xpath_weiter=xpath=//div[@id='Content']//input[@name='newOrder']

&{JPET_CONFIRMATION}    xpath_bestaetigung=xpath=//div[@id='Content']//a[contains(@href,'confirmed=true')]

&{JPET_ORDERSUMMARY}    xpath_uebersicht=xpath=//div[@id='Content']//table[@id='orderView']
...                     xpath_bestellung_id=xpath=//div[@id='Content']//table[@id='orderView']//*[@id='order.id']

&{AKTION}               katalog=Catalog.action
...                     konto=Account.action
...                     warenkorb=Cart.action


*** Keywords ***
Aktion Ermitteln
    ${url}=     Get Url
    @{parts}=   Split String    ${url}          separator=/
    @{items}=   Split String    ${parts}[-1]    separator=?
    RETURN      ${items}[0]


Hauptseite aufrufen
    [Documentation]     Dieses Schlüsselwort ruft die Hauptseite mit dem
    ...                 Papagei auf und klickt dazu auf das Logo oben links.
    Click       ${JPET_HEADER.xpath_logo}
    Wait For Load State    networkidle
    Aktion Pruefen      ==      ${AKTION.katalog}

Dictionaries Auf Merkmal Reduzieren
    [Arguments]         ${merkmal}
    ...                 @{liste}
    @{retval}=  Create List
    FOR    ${it}    IN    @{liste}
        ${value}=   Get From Dictionary     ${it}   ${merkmal}
        Append To List    ${retval}     ${value}
    END
    RETURN      @{retval}

Text In Number Umwandeln
    [Arguments]     ${text}
    ...             ${nachkommastellen}=2
    ${text}     Remove String    ${text}    \$
    ${text}     Replace String    ${text}    ,    .
    ${value}    Convert To Number    ${text}    precision=${nachkommastellen}
    RETURN      ${value}
