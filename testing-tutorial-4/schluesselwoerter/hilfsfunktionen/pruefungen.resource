*** Settings ***
Library     Browser
Library     String
Resource    allgemeines.resource

*** Keywords ***
Aktion Pruefen
    [Arguments]         ${vergleich}=!=
    ...                 ${aktion}=undefined
    ${ist_aktion}=      Aktion Ermitteln
    IF      "${vergleich}" == "=="
        Should Be Equal As Strings          ${ist_aktion}     ${aktion}
    ELSE IF     "${vergleich}" == "!="
        Should Not Be Equal As Strings      ${ist_aktion}     ${aktion}
    END

Gesamtsumme Warenkorb Pruefen
    [Arguments]         ${sollwert}
    ${expectedValue}    Text In Number Umwandeln    ${sollwert}
    ${total}            Get Text    ${JPET_CART.xpath_gesamtsumme}
    ${currentValue}     Text In Number Umwandeln    ${total}
    Should Be Equal As Numbers    ${currentValue}    ${expectedValue}