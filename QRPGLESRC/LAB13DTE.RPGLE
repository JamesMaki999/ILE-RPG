000100220327       // ************************************* //
000101220327       // Computer Prog in Advanced ILE RPG *** //
000102220327       // Lab 13 SQLRPGLE Program ************* //
000103220327       // GTC Time Conversion - DayOfWeek PGM * //
000104220327       // James Maki ************************** //
000105220327       // ************************************* //
000106220327
000107220326       Ctl-Opt Option(*Nodebugio);
000108220326
000109220327       Dcl-pr DayOfWeek ExtPgm('LAB13DTE');
000110220327         CodeDD         Zoned(2:0);
000111220327         CodeST         Char(9);
000112220327       End-pr;
000113220326
000114220327       Dcl-pi DayOfWeek;
000115220327         CodeDD         Zoned(2:0);
000116220327         CodeST         Char(9);
000117220326       End-pi;
000118220326
000119220327       // Select Statement to determine the ** //
000120220327       // day of week, depending on the ****** //
000121220327       // inputted CodeDD value ************** //
000122220327       Select;
000123220327         When CodeDD = 0;
000124220327           CodeST = 'Sunday';
000125220327         When CodeDD = 1;
000126220327           CodeST = 'Monday';
000127220327         When CodeDD = 2;
000128220327           CodeST = 'Tuesday';
000129220327         When CodeDD = 3;
000130220327           CodeST = 'Wednesday';
000131220327         When CodeDD = 4;
000132220327           CodeST = 'Thursday';
000133220327         When CodeDD = 5;
000134220327           CodeST = 'Friday';
000135220327         When CodeDD = 6;
000136220327           CodeST = 'Saturday';
000137220327       EndSl;
000138220327
000152220326       *Inlr = *On;
000153220326       Return;
