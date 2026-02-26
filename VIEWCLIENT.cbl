       IDENTIFICATION DIVISION.
       PROGRAM-ID. VIEWCLIENT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEN-DATEI ASSIGN TO "kunden.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEN-DATEI.
       01 KUNDEN-EINTRAG.
           05 K-NR             PIC 9(5).
           05 K-NAME           PIC X(30).
           05 K-KONTO          PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 SUCH-NR              PIC 9(5).
       01 GEFUNDEN-FLAGGE      PIC X VALUE 'N'.
       01 EOF-FLAGGE           PIC X VALUE 'N'.
       01 MASK-KONTO           PIC Z(7).99.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT KUNDEN-DATEI
           
           DISPLAY " "
           DISPLAY "--- KUNDENDATEN ANZEIGEN ---"
           DISPLAY "Bitte Kundennummer eingeben: "
           ACCEPT SUCH-NR

           PERFORM UNTIL EOF-FLAGGE = 'J'
               READ KUNDEN-DATEI
                   AT END
                       MOVE 'J' TO EOF-FLAGGE
                   NOT AT END
                       IF K-NR = SUCH-NR
                           MOVE K-KONTO TO MASK-KONTO
                           DISPLAY "----------------------------"
                           DISPLAY "Name     : " K-NAME
                           DISPLAY "Guthaben : " MASK-KONTO " EUR"
                           DISPLAY "----------------------------"
                           MOVE 'Y' TO GEFUNDEN-FLAGGE
                           MOVE 'J' TO EOF-FLAGGE
                       END-IF
               END-READ
           END-PERFORM

           IF GEFUNDEN-FLAGGE NOT = 'Y'
               DISPLAY "Fehler: Kunde mit Nummer " SUCH-NR " nicht gefunden."
           END-IF

           CLOSE KUNDEN-DATEI
           GOBACK.
