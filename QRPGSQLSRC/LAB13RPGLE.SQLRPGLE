000100220327       // ************************************* //
000101220316       // Computer Prog in Advanced ILE RPG *** //
000102220323       // Lab 13 SQLRPGLE Program ************* //
000103220327       // GTC Time Conversion - Main PGM ****** //
000104220316       // James Maki ************************** //
000105220316       // ************************************* //
000106220316
000107220327       Ctl-Opt          Option(*NodeBugio);
000108220324
000109220323       // File Declaration ******************** //
000110220327       Dcl-f LAB13PRTF  Printer Usage(*Output) Oflind(EndOfPage);
000111220316
000112220323       // Constant Variables ****************** //
000113220327       Dcl-c EDITT      '  :  :  ';
000114220327       Dcl-c EndOfFile  '02000';
000115220323
000116220327       // Standalone Variables **************** //
000119220327       Dcl-s CalDte     Date(*USA);
000120220327       Dcl-s CalTimM    Zoned(6:0);
000121220327       Dcl-s CalTimM2   Zoned(6:0);
000122220327       Dcl-s EndOfPage  Ind Inz(*On);
000123220327       Dcl-s FName      Char(15);
000124220327       Dcl-s LName      Char(15);
000125220327       Dcl-s PhoNum     Zoned(10:0);
000126220327       Dcl-s TotalV     Zoned(5:0);
000127220327       Dcl-s X          Uns(5);
000128220325
000129220327       // Day of Week Calculation Variables *** //
000130220327       Dcl-s DateVar    Zoned(8:0);
000131220326
000132220327       // Century Code ************************ //
000133220327       Dcl-s CCSubStr   Char(4);
000134220327       Dcl-s CCZoned    Zoned(4:0);
000135220327       Dcl-s CCCode     Zoned(2:0);
000136220327
000137220327       // Day Code **************************** //
000138220327       Dcl-s DDSubStr   Char(2);
000139220327       Dcl-s DDZoned    Zoned(2:0);
000140220327       Dcl-s DDCode     Zoned(2:0);
000141220326
000142220327       // Month Code ************************** //
000143220327       Dcl-s MMSubStr   Char(2);
000144220327       Dcl-s MMZoned    Zoned(2:0);
000145220327       Dcl-s MMCode     Zoned(2:0);
000146220326
000147220327       // Leap Year Code ********************** //
000148220327       Dcl-s LYSubStr   Char(4);
000149220327       Dcl-s LYZoned    Zoned(4:0);
000150220327       Dcl-s LYCode     Zoned(2:0);
000151220327
000152220327       // Year Code *************************** //
000153220327       Dcl-s YYSubStr   Char(2);
000154220327       Dcl-s YYZoned    Zoned(2:0);
000155220327       Dcl-s YYCode     Zoned(2:0);
000156220326
000157220327       // DayOfWeek Procedure ***************** //
000158220327       Dcl-pr DayOfWeek ExtPgm('LAB13DTE');
000159220327         CodeDD         Zoned(2:0);
000160220327         CodeST         Char(9);
000161220325       End-pr;
000162220327
000163220327       // MonthCode Procedure ***************** //
000164220327       Dcl-pr MonthCode ExtPgm('LAB13MMC');
000165220327         ZonedMM        Zoned(2:0);
000166220327         CodeMM         Zoned(2:0);
000167220327       End-pr;
000168220323
000169220323       // Main Procedure ********************** //
000170220327       // SQL Cursor ************************** //
000171220323       Exec SQL Declare TimeCursor Cursor For
000172220325         Select lsp.CPHONE, stp.CFNAME, stp.CLNAME,
000173220326         lsp.CALDATL, lsp.CALTIM, lsp.CALDAT
000174220325         From Flight2021.GTCSTP AS stp
000175220325         Inner Join Flight2021.GTCLSP AS lsp
000176220325         On stp.CPHONE = lsp.CPHONE
000177220323         For Read Only;
000178220323
000179220327       // Write PRTF's Header Record ********** //
000180220327       Write Header;
000181220324
000182220323       // Open SQL Cursor ********************* //
000183220323       Exec SQL Open TimeCursor;
000184220323
000185220327       // Do Until End Of SQL Cursor ********** //
000186220325       Dou Sqlstate = Endoffile;
000187220325
000188220327         // Initialize EndOfPage to On ******** //
000189220325         EndOfPage = *On;
000190220325
000191220325         // Main SQL Fetch Statement ********** //
000192220325         Exec SQL Fetch TimeCursor Into :PhoNum, :FName, :LName,
000193220326           :CalDte, :CalTimM, :DateVar;
000194220325
000195220327         // Initialize PRTF's Phone Number Fld  //
000196220325         PNUM = PhoNum;
000197220323
000198220327         // Initialize PRTF's First Name Fld ** //
000199220325         FNAME = FName;
000200220324
000201220327         // Initialize PRTF's Last Name Fld *** //
000202220325         LNAME = LName;
000203220325
000204220327         // Initialize PRTF's Call Date Fld *** //
000205220327         CALLDATE = CalDte;
000208220326
000209220327         // Initialize PRTF's Military Time Fld //
000210220327         MILTIM = CalTimM;
000212220326
000213220327         // Calculate Century Code ************ //
000214220327         CCSubStr = %subst(%char(DateVar):1:4);
000215220327         CCZoned = %dec(CCSubStr:4:0);
000216220327         Select;
000217220327           When CCZoned < 2100 AND CCZoned > 1999;
000218220327             CCCode = 6;
000219220327           When CCZoned < 2000 AND CCZoned > 1899;
000220220327             CCCode = 0;
000221220327         EndSl;
000222220326
000223220327         // Calculate Leap Year Code ********** //
000224220327         LYSubStr = %subst(%char(DateVar):1:4);
000225220326         LYZoned = %dec(LYSubStr:4:0);
000226220326         If %rem(LYZoned:4) = 0;
000227220326           LYCode = 1;
000228220327         Else;
000229220327           LYCode = 0;
000230220327         EndIf;
000232220326
000233220327         // Calculate Month Code ************** //
000234220326         MMSubStr = %subst(%char(DateVar):5:2);
000235220327         MMZoned = %dec(MMSubStr:2:0);
000237220327
000238220327         // Call Procedure to Solve MonthCode * //
000239220327         Callp MonthCode(MMZoned:MMCode);
000252220326
000253220327         // Calculate Year Code *************** //
000254220326         YYSubStr = %subst(%char(DateVar):3:4);
000255220326         YYZoned = %dec(YYSubStr:2:0);
000256220326         YYCode = %rem((YYZoned + %div(YYZoned:4)):7);
000257220326
000258220327         // Calculate Day Code **************** //
000259220326         DDSubStr = %subst(%char(DateVar):7:2);
000260220326         DDZoned = %dec(DDSubStr:2:0);
000261220327         DDCode = %rem((DDZoned + MMZoned + YYZoned + CCZoned - LYZoned):7);
000278220327
000279220327         // Call Procedure to Solve DayOfWeek * //
000280220327         Callp DayOfWeek(DDCode:DOWEEK);
000283220327
000284220327         // Execute if Time > 12PM ************ //
000285220326         If CalTimM > 125999;
000286220326           CalTimM2 = CalTimM - 120000;
000287220327           CVTTIM = %editw(CalTimM2:EDITT);
000290220326           X = %len(CVTTIM) - 7;
000291220326           CVTTIM = %replace('PM':CVTTIM:X:%len(CVTTIM));
000292220326
000293220327         // Execute if Time between 11:59PM *** //
000294220327         // & 1PM ***************************** //
000295220327         ElseIf CalTimM > 115959 AND CalTimM < 130000;
000296220326           CVTTIM = %editw(CalTimM:EDITT);
000297220326           CVTTIM = %replace('PM':CVTTIM:X:%len(CVTTIM));
000298220326
000299220327         // Execute if Time is less than 1AM  * //
000300220326         ElseIf CalTimM < 10000;
000301220326           CalTimM2 = CalTimM + 120000;
000302220326           CVTTIM = %editw(CalTimM2:EDITT);
000303220326           CVTTIM = %replace('AM':CVTTIM:X:%len(CVTTIM));
000304220326
000305220327         // Execute if Time between 1AM & Noon  //
000306220326         ElseIf CalTimM < 120000 AND CalTimM > 5999;
000307220326           CVTTIM = %editw(CalTimM:EDITT);
000308220326           CVTTIM = %replace('AM':CVTTIM:X:%len(CVTTIM));
000309220326
000310220327         // Shouldn't even be called, but JIC * //
000311220326         Else;
000312220326           CVTTIM = %char(CalTimM);
000313220326         EndIf;
000314220325
000315220327         // Total Counter ********************* //
000316220325         Eval TotalV += 1;
000317220325
000318220327         // Execute Overflow Subroutine ******* //
000319220325         Exsr Overflow;
000320220323
000321220325       EndDo;
000322220323
000323220323       // Close SQL Cursor ******************** //
000324220323       Exec SQL Close TimeCursor;
000325220323
000326220327       // Initialize PRTF's Total ************* //
000327220325       TTLCALL = TotalV;
000328220325
000329220327       // Display PRTF's Total Record ********* //
000330220323       Write Total;
000331220323
000332220323       *Inlr = *On;
000333220323       Return;
000334220323
000335220323       // Overflow Subroutine ***************** //
000336220323       Begsr Overflow;
000337220323         if EndOfPage;
000338220324           Write Details;
000339220325           EndOfPage = *Off;
000340220323         EndIf;
000341220323       EndSr;
