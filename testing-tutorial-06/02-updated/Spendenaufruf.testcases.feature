# Diese Datei wurde erzeugt durch LF-ET 2.4.0 (250430a) und Kommandozeile:
# -GenTest "D:/data/visual-studio-code/lfet-testing-tutorial/testing-tutorial-06/02-updated/Spendenaufruf.lfet" -Group "gherkin" -NonExecutableRules "50" -RecommendedTestCases -OutGherkin "Spendenaufruf.testcases.feature"
# 
# Aktueller Benutzer: doschweier
# Aktuelles Verzeichnis (user.dir): "D:\data\visual-studio-code\lfet-testing-tutorial\testing-tutorial-06\02-updated"
# Benötigte Zeit: 00:00:00.267 (14.06.2025 14:08:03.093 - 14.06.2025 14:08:03.360)
# 
# Entscheidungstabelle: D:\data\visual-studio-code\lfet-testing-tutorial\testing-tutorial-06\02-updated\Spendenaufruf.lfet
# 
# Regelauswahl und Regelsortierung: Alle Regeln, Standardsortierung
# 
# TestValueGroups: gherkin, *ti.att
# Config: 
# 
# Testfälle mit Fehlern: 0
# 
# Testfälle mit Warnungen: 0
# 
# Informationen: 0

# language: de

Funktion: Spendenaufruf für Tierheime

  @recommended
  Szenario: 0001 Spendenaufruf
    Spendenaufruf
    R01 : B01 Spendenbetrag = <300 ; B02 Spendenquittung erwünscht = J
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       ein Spendenbetrag über 150 Euro erfasst wird
    *          eine Spendenquittung wird erwünscht
    Dann       die Spende wird mit "Vielen Dank für Deine Spende" bestätigt
    *          an die bekannte Mailadresse wird eine automatisch generierte Spendenquittung gesendet.

  @recommended
  Szenario: 0002 Spendenaufruf
    Spendenaufruf
    R02 : B01 Spendenbetrag = <300 ; B02 Spendenquittung erwünscht = N
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       ein Spendenbetrag über 150 Euro erfasst wird
    *          auf eine Spendenquittung wird verzichtet
    Dann       die Spende wird mit "Vielen Dank für Deine Spende" bestätigt

  @recommended
  Szenario: 0003 Spendenaufruf
    Spendenaufruf
    R03 : B01 Spendenbetrag = >=300 ; ~B02 Spendenquittung erwünscht = N
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       ein Spendenbetrag über 650 Euro erfasst wird
    *          auf eine Spendenquittung wird verzichtet
    Dann       die Spende wird mit "Vielen Dank für Deine Spende" bestätigt
    *          an die bekannte Mailadresse wird eine automatisch generierte Spendenquittung gesendet.

  @negative @recommended
  Szenario: 0004 Spendenaufruf
    Spendenaufruf
    R04 : B01 Spendenbetrag = leer ; ~B02 Spendenquittung erwünscht = J
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       das Feld für den Spendenbetrag nicht ausgefüllt wird
    *          eine Spendenquittung wird erwünscht
    Dann       wird die Fehlermeldung "Es muss ein Spendenbetrag eingegeben werden." angezeigt

  @negative @recommended
  Szenario: 0005 Spendenaufruf
    Spendenaufruf
    R05 : B01 Spendenbetrag = neg ; ~B02 Spendenquittung erwünscht = J
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       ein Spendenbetrag über -50 Euro erfasst wird
    *          eine Spendenquittung wird erwünscht
    Dann       wird die Fehlermeldung "Der Spendenbetrag ist zu gering" angezeigt

  @negative @recommended
  Szenario: 0006 Spendenaufruf
    Spendenaufruf
    R06 : B01 Spendenbetrag = text ; ~B02 Spendenquittung erwünscht = N
    Angenommen ein angemeldeter Benutzer hat die Seite für den Spendenaufruf geöffnet
    Wenn       als Spendenbeitrag "EUR" erfasst wird
    *          auf eine Spendenquittung wird verzichtet
    Dann       wird die Fehlermeldung "Der Spendenbetrag ist mit Ziffern anzugeben." angezeigt

### end of generated test cases ###