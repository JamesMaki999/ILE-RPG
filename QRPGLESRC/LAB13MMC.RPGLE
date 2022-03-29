000100220327       // ************************************* //
000101220327       // Computer Prog in Advanced ILE RPG *** //
000102220327       // Lab 13 SQLRPGLE Program ************* //
000103220327       // GTC Time Conversion - MonthCode PGM * //
000104220327       // James Maki ************************** //
000105220327       // ************************************* //
000106220327
000107220327       Ctl-Opt Option(*Nodebugio);
000108220327
000109220327       Dcl-pr MonthCode ExtPgm('LAB13MMC');
000110220327         ZonedMM        Zoned(2:0);
000111220327         CodeMM         Zoned(2:0);
000112220327       End-pr;
000113220327
000114220327       Dcl-pi MonthCode;
000115220327         ZonedMM        Zoned(2:0);
000116220327         CodeMM         Zoned(2:0);
000117220327       End-pi;
000118220327
000119220327       // Select statement to determine the *** //
000120220327       // Month Code, based on the inputted *** //
000121220327       // ZonedMM value *********************** //
000122220327       Select;
000123220327         When ZonedMM = 1;
000124220327           CodeMM = 0;
000125220327         When ZonedMM = 2;
000126220327           CodeMM = 3;
000127220327         When ZonedMM = 3;
000128220327           CodeMM = 3;
000129220327         When ZonedMM = 4;
000130220327           CodeMM = 6;
000131220327         When ZonedMM = 5;
000132220327           CodeMM = 1;
000133220327         When ZonedMM = 6;
000134220327           CodeMM = 4;
000135220327         When ZonedMM = 7;
000136220327           CodeMM = 6;
000137220327         When ZonedMM = 8;
000138220327           CodeMM = 2;
000139220327         When ZonedMM = 9;
000140220327           CodeMM = 5;
000141220327         When ZonedMM = 10;
000142220327           CodeMM = 0;
000143220327         When ZonedMM = 11;
000144220327           CodeMM = 3;
000145220327         When ZonedMM = 12;
000146220327           CodeMM = 5;
000147220327       EndSl;
000166220327
000167220327       *Inlr = *On;
000168220327       Return;
