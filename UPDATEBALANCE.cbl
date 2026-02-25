      IDENTIFICATION DIVISION.
       PROGRAM-ID. UPDATEBALANCE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEN-DATEI ASSIGN TO "kunden.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TEMP-DATEI ASSIGN TO "kunden.tmp"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEN-DATEI.
       01 KUNDEN-EINTRAG.
           05 K-NR             PIC 9(5).
           05 K-NAME           PIC X(30).
           05 K-KONTO          PIC 9(7)V99.

       FD TEMP-DATEI.
       01 TEMP-EINTRAG.
           05 T-NR             PIC 9(5).
           05 T-NAME           PIC X(30).
           05 T-KONTO          PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 SUCH-NR              PIC 9(5).
       01 GEFUNDEN-FLAGGE      PIC X VALUE 'N'.
       01 EOF-FLAGGE           PIC X VALUE 'N'.
       01 AUSWAHL              PIC 9.
       01 BETRAG               PIC 9(7)V99.
       01 MASK-KONTO           PIC Z(7).99.

       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY " "
           DISPLAY "--- GUTHABEN AKTUALISIEREN ---"
           DISPLAY "Bitte Kundennummer eingeben: "
           ACCEPT SUCH-NR

           OPEN INPUT KUNDEN-DATEI
           OPEN OUTPUT TEMP-DATEI

           PERFORM UNTIL EOF-FLAGGE = 'J'
               READ KUNDEN-DATEI
                   AT END 
                       MOVE 'J' TO EOF-FLAGGE
                   NOT AT END
                       IF K-NR = SUCH-NR
                           MOVE 'Y' TO GEFUNDEN-FLAGGE
                           PERFORM KONTO-UPDATE-LOGIK
                       END-IF
                       *> Daten in die temporäre Datei schreiben
                       MOVE K-NR TO T-NR
                       MOVE K-NAME TO T-NAME
                       MOVE K-KONTO TO T-KONTO
                       WRITE TEMP-EINTRAG
               END-READ
           END-PERFORM

           CLOSE KUNDEN-DATEI
           CLOSE TEMP-DATEI

           IF GEFUNDEN-FLAGGE = 'Y'
               *> Dateien im System ersetzen
               CALL "SYSTEM" USING "rm kunden.dat"
               CALL "SYSTEM" USING "mv kunden.tmp kunden.dat"
               DISPLAY "Update erfolgreich abgeschlossen."
           ELSE
               CALL "SYSTEM" USING "rm kunden.tmp"
               DISPLAY "Fehler: Kunde nicht gefunden!"
           END-IF

           GOBACK.

       KONTO-UPDATE-LOGIK.
           MOVE K-KONTO TO MASK-KONTO
           DISPLAY "Kunde      : " K-NAME
           DISPLAY "Aktuelles Guthaben: " MASK-KONTO " EUR"
           DISPLAY "1 - Einzahlung (Yatirma)"
           DISPLAY "2 - Auszahlung (Cekme)"
           DISPLAY "Auswahl: "
           ACCEPT AUSWAHL
           DISPLAY "Betrag eingeben: "
           ACCEPT BETRAG

           IF AUSWAHL = 1
               ADD BETRAG TO K-KONTO
           ELSE
               IF AUSWAHL = 2
                   IF BETRAG <= K-KONTO
                       SUBTRACT BETRAG FROM K-KONTO
                   ELSE
                       DISPLAY "Fehler: Nicht genuegend Guthaben!"
                   END-IF
               ELSE
                   DISPLAY "Ungueltige Auswahl! Keine Aenderung."
               END-IF
           END-IF.
