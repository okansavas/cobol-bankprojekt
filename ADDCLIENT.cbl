       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADDCLIENT.

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
       01 WEITER-FLAGGE     PIC X VALUE 'J'.
       01 TEMP-NR           PIC 9(5).
       01 TEMP-NAME         PIC X(30).
       01 TEMP-KONTO        PIC 9(7)V99.

       PROCEDURE DIVISION.
       BEGIN.

           OPEN EXTEND KUNDEN-DATEI.

           PERFORM UNTIL WEITER-FLAGGE NOT = 'J'
               DISPLAY "Kundennummer eingeben: "
               ACCEPT TEMP-NR
               DISPLAY "Kundenname eingeben: "
               ACCEPT TEMP-NAME
               DISPLAY "Startguthaben eingeben: "
               ACCEPT TEMP-KONTO

               MOVE TEMP-NR    TO KUNDEN-NR
               MOVE TEMP-NAME  TO KUNDEN-NAME
               MOVE TEMP-KONTO TO KUNDEN-KONTO

               WRITE KUNDEN-EINTRAG

               DISPLAY "Noch einen Kunden hinzufuegen? (J/N): "
               ACCEPT WEITER-FLAGGE
           END-PERFORM

           CLOSE KUNDEN-DATEI
           GOBACK.
