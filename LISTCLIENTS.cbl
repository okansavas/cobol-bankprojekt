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
           05 KUNDEN-NR      PIC 9(5).
           05 KUNDEN-NAME    PIC X(30).
           05 KUNDEN-KONTO   PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 EOF-FLAGGE         PIC X VALUE 'N'.
       01 MASK-KONTO         PIC Z(7).99.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT KUNDEN-DATEI
           DISPLAY " "
           DISPLAY "========== KUNDENLISTE =========="
           DISPLAY "NR     NAME                           GUTHABEN"
           DISPLAY "----------------------------------------------"

           PERFORM UNTIL EOF-FLAGGE = 'Y'
               READ KUNDEN-DATEI
                   AT END
                       MOVE 'Y' TO EOF-FLAGGE
                   NOT AT END
                       MOVE KUNDEN-KONTO TO MASK-KONTO
                       DISPLAY KUNDEN-NR "  " KUNDEN-NAME "  " MASK-KONTO " EUR"
               END-READ
           END-PERFORM

           CLOSE KUNDEN-DATEI
           GOBACK.
