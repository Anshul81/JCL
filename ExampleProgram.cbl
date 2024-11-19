       IDENTIFICATION DIVISION.
       PROGRAM-ID. ExampleProgram.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile ASSIGN TO 'input.dat'
                  ORGANIZATION IS SEQUENTIAL
                  ACCESS MODE IS SEQUENTIAL
                  FILE STATUS IS FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  InputFile.
       01  InputRecord.
           05  Field1              PIC X(20).
           05  Field2              PIC X(30).

       WORKING-STORAGE SECTION.
       01  FileStatus              PIC XX.
       01  EndOfFile               PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       Begin.
           OPEN INPUT InputFile
           IF FileStatus = '00'
               DISPLAY 'File opened successfully.'
           ELSE
               DISPLAY 'Error opening file. Status: ' FileStatus
               STOP RUN
           END-IF

           PERFORM UNTIL EndOfFile = 'Y'
               READ InputFile INTO InputRecord
                   AT END
                       MOVE 'Y' TO EndOfFile
                   NOT AT END
                       DISPLAY 'Field1: ' Field1
                       DISPLAY 'Field2: ' Field2
               END-READ
           END-PERFORM

           CLOSE InputFile
           DISPLAY 'File processing completed.'
           STOP RUN.
