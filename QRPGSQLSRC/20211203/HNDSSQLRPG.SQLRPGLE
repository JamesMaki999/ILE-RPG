000100220413       // ************************************* //
000101220413       // Computer Prog in ILE RPG ************ //
000102220413       // Final Exam Team Project RPGLE Program //
000103220413       // RPGLE program for HNDSPRTF.PRTF ***** //
000104220413       // Lists Student Details *************** //
000105220413       // Created: 12/03/2021 ***************** //
000106220413       // Edited: 04/13/2022 ****************** //
000107220413       // James Maki ************************** //
000108220413       // ************************************* //
000109220413
000110220413       // File Declaration ******************** //
000111220413       DCL-F HNDSPRTF PRINTER OFLIND(ENDOFPAGE);
000112211203
000113220413       // Constant Variable Declaration ******* //
000114220413       DCL-C ENDOFFILE '02000';
000115220413
000116220413       // Standalone Variable Declaration ***** //
000117220413       DCL-S STUD_ID ZONED(3:0);
000118220413       DCL-S MRKS ZONED(3:0);
000119220413
000120220413       // Write PRTF's RECORD1 Record ********* //
000122220413       WRITE RECORD1;
000123211203
000124220413       // SQL Cursor MARKSCUR Declaration ***** //
000125220413       EXEC SQL DECLARE MARKSCUR CURSOR FOR
000126220413            SELECT STUDENTID, MARK FROM ITPA453.MRKSFIN17
000127220413              FOR READ ONLY;
000128211203
000129220413       // Start SQL MARKSCUR Cursor *********** //
000130220413       EXEC SQL OPEN MARKSCUR;
000131211203
000132220413       // Do Until SQLState Loop Start ******** //
000133220413       DOU SQLSTATE = ENDOFFILE;
000134211203
000135220413         // SQL Fetch Values ****************** //
000136220413         EXEC SQL FETCH MARKSCUR INTO :STUD_ID, :MRKS;
000137211203
000138220413         // Main SQL Select Statement Start *** //
000139220413         SELECT;
000140220413
000141220413           WHEN SQLSTATE = ENDOFFILE;
000142220413             LEAVE;
000143220413
000144220413         // Main SQL Select Statement End ***** //
000145220413         ENDSL;
000146211203
000147220413         // Init PRTF's Values w/Fetched Values //
000148220413         FLDID = STUD_ID;
000149220413         FLDMRKS = MRKS;
000150220413
000151220413         // Write PRTF's RECORD2 Record ******* //
000152220413         WRITE RECORD2;
000153220413
000154220413       // Do Until SQLState Loop End ********** //
000155220413       ENDDO;
000156211203
000157220413       // Inlr & Return *********************** //
000158220413       *INLR = *ON;
000159220413       RETURN;
