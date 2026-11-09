# GW to-do list – Aufgabenliste

Team-Aufgabenliste für Grunwald Flächenheizsysteme. Die Oberfläche ist eine einzelne HTML-Datei ohne Build-Schritt, die Daten liegen in einer Supabase-Datenbank.

Live: https://grunwald.brunotte.de

## Nutzung

`index.html` im Browser öffnen oder die Live-Adresse aufrufen. Die Seite fragt beim Öffnen das gemeinsame Team-Passwort ab. Danach bleibt die Anmeldung im Browser erhalten, bis man sich abmeldet.

## Funktionen

- Aufgaben anlegen mit Aufgabe, Zuständigkeit, Status (offen / in Bearbeitung / erledigt), Deadline, Priorität (hoch / mittel / niedrig) und Notizen
- Zuständigkeit als Auswahl der Team-Kürzel: CH, JB, JBS, MB, NW
- Oben wählt man das eigene Kürzel. Es wird im Browser gemerkt und bei neuen Aufgaben als "Erfasst von" vermerkt
- Aufgaben vollständig bearbeiten, Status zusätzlich direkt in der Tabelle ändern
- Aufgaben einzeln löschen oder alle erledigten Aufgaben auf einmal entfernen
- Suche über Aufgabe, Zuständigkeit, Notizen und Erfasser, dazu Statusfilter und Sortierung (Deadline, Priorität, Erstellungsdatum)
- Überfällige und bald fällige Deadlines werden hervorgehoben
- Kennzahlen: Gesamt, In Bearbeitung, Erledigt
- Änderungen erscheinen sofort in allen geöffneten Browsern

## Datenbank

Die Tabelle, die Zugriffsregeln und die Freigabe für die Live-Aktualisierung stehen in `supabase/schema.sql`. Das Skript ist wiederholbar und wird im SQL Editor des Supabase-Projekts ausgeführt.

Der Zugriffsschutz arbeitet auf Zeilenebene. Ohne Anmeldung ist nichts lesbar und nichts änderbar. Erlaubt ist alles nur für angemeldete Nutzer, also für das eine gemeinsame Team-Konto. Die Selbstregistrierung ist im Supabase-Projekt abgeschaltet, damit sich niemand von außen ein Konto anlegen kann.

Der in der Seite hinterlegte Schlüssel ist der öffentliche Schlüssel. Er ist dafür gedacht, im Quelltext zu stehen, und reicht allein nicht aus, um an die Daten zu kommen.

## Veröffentlichung

Jeder Push auf `main` löst ein neues Deployment bei Vercel aus.
