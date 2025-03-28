*** Settings ***
Library     String
Library     Browser
Resource    ../hilfsfunktionen/pruefungen.resource

*** Variables ***
&{JPET_ACCOUNTFORM}     xpath_account_username=xpath=//form//input[@name="username"]
...                     xpath_account_password=xpath=//form//input[@name="password"]
...                     xpath_account_repeat_password=xpath=//form//input[@name="repeatedPassword"]
...                     xpath_account_firstname=xpath=//form//input[@name="account.firstName"]
...                     xpath_account_lastname=xpath=//form//input[@name="account.lastName"]
...                     xpath_account_email=xpath=//form//input[@name="account.email"]
...                     xpath_account_phone=xpath=//form//input[@name="account.phone"]
...                     xpath_account_address1=xpath=//form//input[@name="account.address1"]
...                     xpath_account_address2=xpath=//form//input[@name="account.address2"]
...                     xpath_account_city=xpath=//form//input[@name="account.city"]
...                     xpath_account_state=xpath=//form//input[@name="account.state"]
...                     xpath_account_zip=xpath=//form//input[@name="account.zip"]
...                     xpath_account_country=xpath=//form//input[@name="account.country"]
...                     xpath_submit=xpath=//form//input[@name="newAccount" and @type="submit"]


*** Keywords ***
Formularfeld Fuellen
    [Arguments]         ${selector}
    ...                 ${text}
    [Documentation]     Mit diesem Schlüsselwort kann ganz allgemein ein
    ...                 Formularfeld gefüllt werden. Dieses Schlüsselwort
    ...                 überschreibt einen möglichen Inhalt in dem Feld.
    Fill Text   ${selector}     ${text}

Benutzername Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann ein Benutzername in das
    ...                 Formular für die Anlage eines neuen Nutzers erfasst
    ...                 werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_username}    ${text}

Passwort Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort wird das Passwort und die
    ...                 Wiederholung des Passwortes in dem Formular für die
    ...                 Anlage eines neuen Nutzers erfasst.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_password}    ${text}
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_repeat_password}    ${text}

Vorname Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann der Vorname in das
    ...                 Formular für die Anlage eines neuen Nutzers erfasst
    ...                 werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_firstname}    ${text}


Nachname Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann der Nachname in das
    ...                 Formular für die Anlage eines neuen Nutzers erfasst
    ...                 werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_lastname}    ${text}


EMail Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann eine EMail-Adresse in das
    ...                 Formular für die Anlage eines neuen Nutzers erfasst
    ...                 werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_email}    ${text}


Telefonnummer Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann eine Telefonnummer in das
    ...                 Formular für die Anlage eines neuen Nutzers erfasst
    ...                 werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_phone}    ${text}


Adresse Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann die erste Adresszeile für
    ...                 die Adresse in das Formular für die Anlage eines neuen
    ...                 Nutzers erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_address1}    ${text}


Adresszusatz Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann die zweite Adresszeile für
    ...                 die Adresse in das Formular für die Anlage eines neuen
    ...                 Nutzers erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_address2}    ${text}


Stadt Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann die Stadt für die
    ...                 Adresse in das Formular für die Anlage eines neuen
    ...                 Nutzers erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_city}    ${text}


Bundesland Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann das Bundesland für die
    ...                 Adresse in das Formular für die Anlage eines neuen
    ...                 Nutzers erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_state}    ${text}


Postleitzahl Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann die Postleitzahl für die
    ...                 Adresse in das Formular für die Anlage eines neuen
    ...                 Nutzers erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_zip}    ${text}


Staat Erfassen
    [Arguments]         ${text}
    [Documentation]     Mit diesem Schlüsselwort kann der Staat für die Adresse
    ...                 in das Formular für die Anlage eines neuen Nutzers
    ...                 erfasst werden.
    Formularfeld Fuellen    ${JPET_ACCOUNTFORM.xpath_account_country}    ${text}

Formular Absenden
    [Arguments]         ${vergleich}=!=
    ...                 ${aktion}=undefined
    [Documentation]
    Click    ${JPET_ACCOUNTFORM.xpath_submit}
    Wait For Load State    networkidle
