       IDENTIFICATION DIVISION.
       PROGRAM-ID. UPDATEBALANCE.

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
       01 SUCH-NR            PIC 9(5).
       01 GEFUNDEN-FLAGGE    PIC X VALUE 'N'.
       01 AUSWAHL            PIC 9.
       01 BETRAG             PIC 9(7)V99.
       01 NEUES-GUTHABEN     PIC 9(7)V99.
       01 EOF-FLAGGE         PIC X VALUE 'N'.

       PROCEDURE DIVISION.

       BEGIN.
           OPEN I-O KUNDEN-DATEI

           DISPLAY "Bitte Kundennummer eingeben: "
           ACCEPT SUCH-NR

           PERFORM SUCHE-MODUL

           IF GEFUNDEN-FLAGGE = 'Y'
               DISPLAY "Kunde: " KUNDEN-NAME
               DISPLAY "Aktuelles Guthaben: " KUNDEN-KONTO
               DISPLAY "1. Einzahlung"
               DISPLAY "2. Auszahlung"
               DISPLAY "Wahl: "
               ACCEPT AUSWAHL
               DISPLAY "Betrag eingeben: "
               ACCEPT BETRAG

               EVALUATE AUSWAHL
                   WHEN 1
                       COMPUTE NEUES-GUTHABEN = KUNDEN-KONTO + BETRAG
                   WHEN 2
                       IF BETRAG > KUNDEN-KONTO
                           DISPLAY "Nicht genug Guthaben!"
                           MOVE KUNDEN-KONTO TO NEUES-GUTHABEN
                       ELSE
                           COMPUTE NEUES-GUTHABEN = KUNDEN-KONTO -BETRAG
                       END-IF
                   WHEN OTHER
                       DISPLAY "Ungueltige Auswahl."
                       PERFORM SCHLIESSEN
                       STOP RUN
               END-EVALUATE

               MOVE NEUES-GUTHABEN TO KUNDEN-KONTO
               REWRITE KUNDEN-EINTRAG
               DISPLAY "Guthaben aktualisiert: " KUNDEN-KONTO
           ELSE
               DISPLAY "Kunde nicht gefunden."
           END-IF

           PERFORM SCHLIESSEN
           STOP RUN.

       SUCHE-MODUL.
           PERFORM UNTIL EOF-FLAGGE = 'Y'
               READ KUNDEN-DATEI
                   AT END
                       MOVE 'Y' TO EOF-FLAGGE
                   NOT AT END
                       IF KUNDEN-NR = SUCH-NR
                           MOVE 'Y' TO GEFUNDEN-FLAGGE
                           MOVE 'Y' TO EOF-FLAGGE
                       END-IF
               END-READ
           END-PERFORM.

       SCHLIESSEN.
           CLOSE KUNDEN-DATEI. 
           