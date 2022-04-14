000100220413       // ************************************* //
000101220413       // Computer Prog in ILE RPG ************ //
000102220413       // Final Exam Team Project RPGLE Program //
000103220413       // RPGLE program for STREMPPTF.PRTF **** //
000104220413       // Lists Student Details *************** //
000105220413       // Created: 12/03/2021 ***************** //
000106220413       // Edited: 04/13/2022 ****************** //
000107220413       // James Maki ************************** //
000108220413       // ************************************* //
000109220413
000110220413       // File Declaration ******************** //
000111220413       DCL-F STREMPINF2 DISK;
000112220413       DCL-F STREMPPTF PRINTER OFLIND(ENDOFPAGE);
000113220413
000114220413       // Standalone Variable Declaration ***** //
000115220413       DCL-S ENDOFPAGE IND INZ(*ON);
000116211202
000117220413       // Write PRTF's RECORD1 Record ********* //
000118220413       WRITE RECORD1;
000119220413
000120220413       // Read Logical File ******************* //
000121220413       READ STREMPINF2;
000122220413
000123220413       // Do While Not End of LF Start ******** //
000124220413       DOW NOT %EOF(STREMPINF2);
000125220413
000126220413         // Write PRTF's RECORD2 Record ******* //
000127220413         WRITE RECORD2;
000128220413
000129220413         // Read Logical File ******************* //
000130220413         READ STREMPINF2;
000131220413
000132220413       // Do While Not End of LF End ********** //
000133220413       ENDDO;
000134211202
000135220413       // Inlr & Return *********************** //
000136220413       *INLR = *ON;
000137220413       RETURN;
