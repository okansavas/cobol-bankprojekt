       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKMAIN.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEN-DATEI ASSIGN TO "kunden.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEN-DATEI.
       01 KUNDEN-EINTRAG.
           05 KUNDEN-NR     PIC 9(5).
           05 KUNDEN-NAME   PIC X(30).
           05 KUNDEN-KONTO  PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       77 WAHL           PIC 9.
       77 ENDE-FLAGGE    PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROZEDUR.
           PERFORM UNTIL ENDE-FLAGGE = 'Y'
               DISPLAY "==== BANKSYSTEM ===="
               DISPLAY "1. Neuer Kunde hinzufügen"
               DISPLAY "2. Kunde anzeigen"
               DISPLAY "3. Guthaben aktualisieren"
               DISPLAY "4. Kundenliste anzeigen"
               DISPLAY "5. Beenden"
               DISPLAY "Ihre Auswahl: "
               ACCEPT WAHL

               EVALUATE WAHL
                   WHEN 1
                       CALL "ADDCLIENT"
                   WHEN 2
                       CALL "VIEWCLIENT"
                   WHEN 3
                       CALL "UPDATEBALANCE"
                   WHEN 4
                       CALL "LISTCLIENTS"
                   WHEN 5
                       MOVE 'Y' TO ENDE-FLAGGE
                   WHEN OTHER
                       DISPLAY "Ungültige Auswahl, bitte erneut "
                               "versuchen."
               END-EVALUATE
           END-PERFORM.

           STOP RUN.


