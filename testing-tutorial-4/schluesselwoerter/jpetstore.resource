*** Settings ***
Library     Browser
Resource    ./aktionen/warenkorb.resource
Resource    ./aktionen/registrierung.resource
Resource    ./hilfsfunktionen/pruefungen.resource

*** Variables ***



*** Keywords ***
JPetStore Oeffnen
    [Arguments]         ${url}=${JPETSTORE.url}
    ...                 ${browser}=chromium
    ...                 ${headless}=${True}
    [Documentation]     Mit diesem Schlüsselwort wird eine neue Browserinstanz
    ...                 geöffnet und die Applikation JPetStore gestartet.
    New Browser         ${browser}      headless=${headless}
    New Page            ${url}
    Get Title           ==      ${JPETSTORE.title}
    Click               id=enter
    Wait For Load State    networkidle
    Aktion Pruefen      ==      ${AKTION.katalog}

Anmelden
    [Arguments]         ${benutzername}     ${passwort}
    [Documentation]     Mit diesem Schlüsselwort wird ein Benutzer am JPetStore
    ...                 angemeldet.
    ...
    ...                 Eine Anmeldung erfolgt grundsätzlich nur, wenn im
    ...                 Browser die Hauptseite zu sehen ist und noch kein
    ...                 Benutzer angemeldet ist.
    Aktion Pruefen      ==      ${AKTION.katalog}
    Click               ${JPET_HEADER.xpath_anmeldung}
    Fill Text           ${JPET_SIGNONFORM.xpath_username}    ${benutzername}
    Fill Text           ${JPET_SIGNONFORM.xpath_password}    ${passwort}
    Click               ${JPET_SIGNONFORM.xpath_submit}
    Wait For Load State    networkidle
    Aktion Pruefen      ==      ${AKTION.katalog}


Abmelden
    [Documentation]     Mit diesen Schlüsselwort wird der angemeldete Benutzer
    ...                 vom Shop abgemeldet.
    Click               ${JPET_HEADER.xpath_abmeldung}
    Wait For Load State    networkidle
    Aktion Pruefen      ==      ${AKTION.katalog}

Warenkorb Direkt Bestellen
    Warenkorb Aufrufen
    Vom Warenkorb Zur Kasse Gehen
    Rechnungsinformationen Bestaetigen
    ${bestellung_id}=           Bestellung Bestaetigen
    RETURN    ${bestellung_id}
