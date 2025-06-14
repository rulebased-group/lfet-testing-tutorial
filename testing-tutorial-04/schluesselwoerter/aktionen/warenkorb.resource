*** Settings ***
Library     String
Library     Browser
Resource    ../hilfsfunktionen/pruefungen.resource




*** Keywords ***
Produktliste In Warenkorb Legen
    [Arguments]     ${liste}
    ...             ${separator_liste}=#
    ...             ${separator_artikel}=_
    [Documentation]     Mit dem Schlüsselwort wird eine Liste von Produkten in
    ...                 den Warenkorb gelegt. Die Liste ist als Zeichenkette
    ...                 zu übergeben und für jedes Produkt sind Kategorie,
    ...                 Produkt-Id und Artikel-Id durch ein Trennzeichen zu
    ...                 trennen.
    @{artikel}=     Split String    ${liste}    separator=${separator_liste}
    FOR    ${it}    IN    @{artikel}
        Log    ${it}
        @{parameter}=   Split String    ${it}   separator=${separator_artikel}
        Produkt In Warenkorb Legen    ${parameter}[0]    ${parameter}[1]    ${parameter}[2]
    END

Produkt In Warenkorb Legen
    [Arguments]     ${kategorie_id}
    ...             ${produkt_id}
    ...             ${artikel_id}
    ...             ${menge}=1
    [Documentation]     Mit diesem Schlüsselwort wird ein spezieller Artikel
    ...                 in den Warenkorb gelegt, der über die Ids definiert
    ...                 wird.
    Hauptseite aufrufen
    Click           xpath=//div[@id='Main']//div[@id='Sidebar']//a[contains(@href, 'categoryId=${kategorie_id}')]
    Wait For Elements State    xpath=//table[@id='table.catalog.products']
    Click           text=${produkt_id}
    Wait For Elements State    xpath=//table[@id='table.catalog.items']
    Click           xpath=//table[@id='table.catalog.items']//a[@class='Button' and contains(@href, 'Id=${artikel_id}')]
    Wait For Elements State    xpath=//table[@id='cart']
    ${quantity}=    Convert To Integer      ${menge}
    IF    $quantity > 1
        Fill Text   xpath=//table[@id='cart']//input[@name='${artikel_id}']    ${menge}
        Click       xpath=//table[@id='cart']//tr[@id='cart.summary']//input[@name='updateCartQuantities']
        Wait For Condition    Text    xpath=//table[@id='cart']//input[@name='${artikel_id}']   contains    ${menge}
    END
    Click           xpath=//div[@id='BackLink']//a

Warenkorb Aufrufen
    [Arguments]         ${sollwert}=${None}
    [Documentation]     Das Schlüsselwort öffnet über das Icon in der
    ...                 Kopfzeile den Warenkorb.
    ...
    ...                 Wenn im Parameter sollwert ein Wert übergeben wird,
    ...                 dann wird der Wert im Warenkorb mit dem übergebenen
    ...                 Wert verglichen.
    Click                       ${JPET_HEADER.xpath_warenkorb}
    Wait For Elements State     ${JPET_CART.xpath_warenkorb}
    IF    $sollwert != None
        Gesamtsumme Warenkorb Pruefen    ${sollwert}
    END

Vom Warenkorb Zur Kasse Gehen
    [Documentation]     Mit diesem Schlüselwort wird der Inhalt des Warenkobs
    ...                 bestätigt und es geht zum nächsten Formular mit
    ...                 Zahlungsinformationen und Rechnungsanschrift
    Click                       ${JPET_CART.xpath_zur_kasse}
    Wait For Elements State     ${JPET_NEWORDER.xpath_orderdaten}

Zahlungsoptionen Auslesen
    @{optionen}=    Get Select Options  ${JPET_NEWORDER.xpath_zahlungsmittel}
    Log Many    @{optionen}
    RETURN      @{optionen}

Zahlungsoption Pruefen
    [Arguments]     ${zahlungsoption}
    ...             ${vorhanden}=${True}
    ...             ${merkmal}=label
    [Documentation]     Mit diesem Schlüsselwort kann geprüft werden, ob
    ...                 die Zahlungsoption, die im Parameter zahlungsoption
    ...                 übergeben wurde, in der Auswahlbox zur Verfügung steht.
    ...
    ...                 Wenn im Parameter vorhanden der Wert True übergeben
    ...                 wird, dann muss die Option in der Liste sein. Im Falle
    ...                 von False darf sie nicht vorhanden sein.
    @{optionen}=    Zahlungsoptionen Auslesen
    @{optionen}=    Dictionaries Auf Merkmal Reduzieren    ${merkmal}   @{optionen}
    IF    $vorhanden
        List Should Contain Value       ${optionen}    ${zahlungsoption}
    ELSE
        List Should Not Contain Value   ${optionen}    ${zahlungsoption}
    END

Rechnungsinformationen Bestaetigen
    Click                       ${JPET_NEWORDER.xpath_weiter}
    Wait For Elements State     ${JPET_CONFIRMATION.xpath_bestaetigung}

Bestellung Bestaetigen
    Click                       ${JPET_CONFIRMATION.xpath_bestaetigung}
    Wait For Elements State     ${JPET_ORDERSUMMARY.xpath_uebersicht}
    ${bestellung_id}=           Get Text    ${JPET_ORDERSUMMARY.xpath_bestellung_id}
    RETURN      ${bestellung_id}

