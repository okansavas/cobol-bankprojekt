       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKMAIN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       *> Menüauswahl
       01 WAHL             PIC 9.
       *> Programmbeendungs-Flagge
       01 ENDE-FLAGGE      PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROZEDUR.
           PERFORM UNTIL ENDE-FLAGGE = 'Y'
               DISPLAY " "
               DISPLAY "=============================="
               DISPLAY "       BANKENSYSTEM v1.0      "
               DISPLAY "=============================="
               DISPLAY "1. Neuen Kunden hinzufuegen"
               DISPLAY "2. Kundendaten anzeigen"
               DISPLAY "3. Guthaben aktualisieren"
               DISPLAY "4. Kundenliste anzeigen"
               DISPLAY "5. Beenden"
               DISPLAY "------------------------------"
               DISPLAY "Ihre Auswahl (1-5): "
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
                       DISPLAY "Das System wird beendet. Auf Wiedersehen!"
                   WHEN OTHER
                       DISPLAY "Ungueltige Auswahl, bitte erneut versuchen."
               END-EVALUATE
           END-PERFORM.

           STOP RUN.
