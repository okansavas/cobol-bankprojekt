       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISTCLIENTS.

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
       77 EOF-FLAGGE    PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT KUNDEN-DATEI
           DISPLAY "==== Kundenliste ===="

           PERFORM UNTIL EOF-FLAGGE = 'Y'
               READ KUNDEN-DATEI
                   AT END
                       MOVE 'Y' TO EOF-FLAGGE
                   NOT AT END
                       DISPLAY "Nr.:      " KUNDEN-NR
                       DISPLAY "Name:     " KUNDEN-NAME
                       DISPLAY "Guthaben: " KUNDEN-KONTO
                       DISPLAY "-----------------------------"
               END-READ
           END-PERFORM

           CLOSE KUNDEN-DATEI
           STOP RUN.
