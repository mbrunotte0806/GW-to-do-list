# GW to-do list – Team-Aufgabenliste

Einfache, moderne Team-Aufgabenliste für Grunwald Flächenheizsysteme als einzelne HTML-Datei (HTML, CSS und JavaScript in einer Datei, keine Abhängigkeiten).

## Nutzung

`index.html` im Browser öffnen – fertig. Alternativ kann die Seite über GitHub Pages veröffentlicht werden (Settings → Pages → Branch `main`, Ordner `/`).

## Funktionen

- Aufgaben anlegen mit Aufgabe, Zuständigkeit, Status (offen / in Bearbeitung / erledigt), Deadline und Priorität (hoch / mittel / niedrig)
- Übersichtliche Tabelle mit farbigen Status- und Prio-Kennzeichnungen
- Status direkt in der Tabelle ändern
- Aufgaben einzeln löschen oder alle erledigten Aufgaben auf einmal entfernen
- Suche, Statusfilter und Sortierung (Deadline, Priorität, Erstellungsdatum)
- Überfällige und bald fällige Deadlines werden hervorgehoben
- Kennzahlen: Gesamt, In Bearbeitung, Erledigt
- Speicherung im Browser (localStorage), Daten bleiben nach dem Neuladen erhalten

## Hinweis

Die Daten liegen nur im Browser des jeweiligen Nutzers. Für eine gemeinsame Liste über mehrere Rechner wäre ein Backend oder eine geteilte Datenbank nötig.
