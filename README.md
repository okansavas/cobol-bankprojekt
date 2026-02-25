# 🏦 COBOL Bankenverwaltungssystem (BankProjekt)

Dieses Projekt ist eine dateibasierte Kunden- und Kontoverwaltungssimulation, entwickelt in **COBOL** – der Sprache, die das Rückgrat des globalen Finanzwesens bildet. Ziel des Projekts ist es, die Arbeitsweise von Legacy-Systemen und die Disziplin der Datenverarbeitung in einer modularen Struktur zu demonstrieren.

---

## 🚀 Funktionen

Das System umfasst mehrere Module, die die grundlegenden Bankoperationen (CRUD-Operationen) abbilden:

* **Hauptmenü (BANKMAIN):** Die zentrale Steuereinheit, die alle Programmbereiche koordiniert.
* **Kundenanlage (ADDCLIENT):** Erfasst neue Kundendaten und speichert sie sicher in der Datei `kunden.dat`.
* **Kontostand-Aktualisierung (UPDATEBALANCE):** Ermöglicht die sichere Anpassung von Salden bestehender Kunden.
* **Kundenabfrage (VIEWCLIENT):** Gezielte Suche und Anzeige von Einzelkunden-Details.
* **Kundenliste (LISTCLIENTS):** Erstellt einen Bericht über alle im System registrierten Kunden.

---

## 🛠 Technische Details

* **Sprache:** COBOL (Kompatibel mit GnuCOBOL)
* **Datenverwaltung:** Physische Dateiverarbeitung über `kunden.dat`.
* **Architektur:** Modulare Programmierung durch Einsatz von `CALL` und `LINKAGE SECTION`.

---

## 💻 Installation und Ausführung

Um das Projekt lokal auszuführen, benötigen Sie einen COBOL-Compiler (z. B. **GnuCOBOL**).

1. **Repository klonen:**
   ```bash
   git clone [https://github.com/okansavas/cobol-bankprojekt.git](https://github.com/okansavas/cobol-bankprojekt.git)
   cd cobol-bankprojekt

   Programm kompilieren
   cobc -x -o BANKMAIN BANKMAIN.cbl ADDCLIENT.cbl LISTCLIENTS.cbl UPDATEBALANCE.cbl VIEWCLIENT.cbl

   Programm starten
   ./BANKMAIN



Entwickler
Okan Savas 

   
