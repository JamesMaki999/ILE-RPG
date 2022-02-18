000001220217       // ************************************* //
000002220217       // Computer Prog in Advanced ILE RPG *** //
000003220217       // Lab 11 SQLRPGLE Program ************* //
000004220217       // James Maki ************************** //
000005220217       // ************************************* //
000006220217
000007220217       // File Declaration ******************** //
000008220217       Dcl-f HNDCH11EX4 Printer Usage(*Output) Oflind(EndOfPage);
000009220217
000010220217       // Constant Variables ****************** //
000011220217       Dcl-c EndOfFile '02000';
000012220217       Dcl-c SIZE 12;
000013220217
000014220217       // Standalone Variables **************** //
000015220217       Dcl-s EndOfPage Ind Inz(*On);
000016220217       Dcl-s I Uns(5);
000017220217       Dcl-s J Uns(5);
000018220217       Dcl-s X Uns(5);
000019220217       Dcl-s Inst Zoned(9:0);
000020220217       Dcl-s InstCnt Uns(5);
000021220217
000022220217       // Main Standalone Variables *********** //
000023220217       Dcl-s SPinst Zoned(9:0);
000024220217       Dcl-s SPYear Zoned(4:0);
000025220217       Dcl-s SPMnths Char (84);
000026220217
000027220217       // Loop's Standalone Variables ********* //
000028220217       Dcl-s IPinst Zoned(9:0);
000029220217       Dcl-s IPYear Zoned(4:0);
000030220217       Dcl-s IPMnths Char (84);
000031220217
000032220217       // Data Structures ********************* //
000033220217       Dcl-s AvgWge Zoned(7:2) Dim(12);
000034220217
000035220217       // Main Data Structure ***************** //
000036220217       Dcl-ds Payments Dim(SIZE) Qualified Inz;
000037220217         Pinst Zoned(9:0);
000038220217         PYear Zoned(4:0);
000039220217         PMnths Char(84);
000040220217       End-ds;
000041220217
000042220217       // Main Data Structure Overlay ********* //
000043220217       Dcl-ds *N;
000044220217         Pays Char(84);
000045220217         PMnthsA Zoned(7:2) Dim(12) Pos(1);
000046220217       End-ds;
000047220217
000048220217       // Loop's Data Struct ****************** //
000049220217       Dcl-ds PaymentsI Dim(SIZE) Qualified Inz;
000050220217         Pinst Zoned(9:0);
000051220217         PYear Zoned(4:0);
000052220217         PMnths Char(84);
000053220217       End-ds;
000054220217
000055220217       // Loop's Data Struct Overlay Declaratio //
000056220217       Dcl-ds *N;
000057220217         PaysI Char(84);
000058220217         PMnthsI Zoned(7:2) Dim(12) Pos(1);
000059220217       End-ds;
000060220217
000061220217       // Main Procedure ********************** //
000062220217       // Main SQL Cursor ********************* //
000063220217       Exec SQL Declare PayCursor Cursor For
000064220217         Select *
000065220217         From Flight2021.WuinPay
000066220217         For Read Only;
000067220217
000068220217       // Loop's SQL Cursor ******************* //
000069220217       Exec SQL Declare PayCursorI Cursor For
000070220217         Select *
000071220217         From Flight2021.WuinPay
000072220217         For Read Only;
000073220217
000074220217       // Open SQL Cursor ********************* //
000075220217       Exec SQL Open PayCursor;
000076220217
000077220217       // For Loop Declaration **************** //
000078220217       For X = 1 to %Elem(Payments);
000079220217
000080220217         // Main SQL Fetch Statement ********** //
000081220217         Exec SQL Fetch Paycursor Into :SPinst, :SPYear, :SPMnths;
000082220217
000083220217
000084220217         // Main SQL Select Statement ********* //
000085220217         Select;
000086220217           When Sqlstate = Endoffile;
000087220217             Leave;
000088220217
000089220217           Other;
000090220217             Payments(X).Pinst = SPinst;
000091220217             Payments(X).PYear = SPYear;
000092220217             Payments(X).PMnths = SPMnths;
000093220217         EndSl;
000094220217
000095220217         // Checks for Diff ID from Current *** //
000096220217         If Payments(X).Pinst <> InstID;
000097220217
000098220217           // Loop to Reset All Months AvgWge * //
000099220217           For I = 1 to 12;
000100220217             AvgWge(I) = 0;
000101220217           EndFor;
000102220217
000103220217           // Reset ID Count ****************** //
000104220217           InstCnt = 0;
000105220217           EndOfPage = *On;
000106220217         EndIf;
000107220217
000108220217         // Main Variables Inz **************** //
000109220217         InstID = Payments(X).Pinst;
000110220217         Pays = Payments(X).PMnths;
000111220217         YrFld = Payments(X).PYear;
000112220217
000113220217         // Checks EndOfPage Status *********** //
000114220217         // Only True if EndOfPage is On, ***** //
000115220217         // which denies the loop to run ****** //
000116220217         // when Details is going to print **** //
000117220217         If EndOfPage = *On;
000118220217
000119220217           // Open Loop SQL Cursor ************ //
000120220217           Exec SQL Open PayCursorI;
000121220217
000122220217           // Header's Loop ******************* //
000123220217           For I = 1 to %Elem(Payments);
000124220217
000125220217               // Loop's Fetch Statement ****** //
000126220217               Exec SQL Fetch PayCursorI Into :IPinst, :IPYear, :IPMnths;
000127220217
000128220217               // Loop's SQL Select Statement * //
000129220217               Select;
000130220217                 When Sqlstate = Endoffile;
000131220217                   Leave;
000132220217               Other;
000133220217                 PaymentsI(I).Pinst = IPinst;
000134220217                 PaymentsI(I).PYear = IPYear;
000135220217                 PaymentsI(I).PMnths = IPMnths;
000136220217               EndSl;
000137220217
000138220217               // Loop's Overlay Increment **** //
000139220217               PaysI = PaymentsI(I).PMnths;
000140220217               Inst = PaymentsI(I).Pinst;
000141220217
000142220217               // Checks PRTF's ID & Loop ID ** //
000143220217               If InstID = Inst;
000144220217
000145220217                 // Inc Each Month's AvgWge *** //
000146220217                 For J = 1 to 12;
000147220217                   Eval(h) AvgWge(J) += PMnthsI(J);
000148220217                 EndFor;
000149220217
000150220217                 // ID Occurrence Counter Inc * //
000151220217                 InstCnt += 1;
000152220217
000153220217               EndIf;
000154220217           EndFor;
000155220217
000156220217           // Total Avg Wage Inz & Increment ** //
000157220217           TtlAvgWge = 0;
000158220217           For J = 1 to 12;
000159220217             Eval(h) TtlAvgWge += (AvgWge(J) / InstCnt);
000160220217           EndFor;
000161220217
000162220217           // PRTF's AvgWges Inz ************** //
000163220217           Eval(h) AvgWge1 = (AvgWge(1) / InstCnt);
000164220217           Eval(h) AvgWge2 = (AvgWge(2) / InstCnt);
000165220217           Eval(h) AvgWge3 = (AvgWge(3) / InstCnt);
000166220217           Eval(h) AvgWge4 = (AvgWge(4) / InstCnt);
000167220217           Eval(h) AvgWge5 = (AvgWge(5) / InstCnt);
000168220217           Eval(h) AvgWge6 = (AvgWge(6) / InstCnt);
000169220217           Eval(h) AvgWge7 = (AvgWge(7) / InstCnt);
000170220217           Eval(h) AvgWge8 = (AvgWge(8) / InstCnt);
000171220217           Eval(h) AvgWge9 = (AvgWge(9) / InstCnt);
000172220217           Eval(h) AvgWge10 = (AvgWge(10) / InstCnt);
000173220217           Eval(h) AvgWge11 = (AvgWge(11) / InstCnt);
000174220217           Eval(h) AvgWge12 = (AvgWge(12) / InstCnt);
000175220217
000176220217           // Close Loop SQL Cursor *********** //
000177220217           Exec SQL Close PayCursorI;
000178220217         EndIf;
000179220217
000180220217         // PRTF's Month Wage Inz ************* //
000181220217         MthWge1 = PMnthsA(1);
000182220217         MthWge2 = PMnthsA(2);
000183220217         MthWge3 = PMnthsA(3);
000184220217         MthWge4 = PMnthsA(4);
000185220217         MthWge5 = PMnthsA(5);
000186220217         MthWge6 = PMnthsA(6);
000187220217         MthWge7 = PMnthsA(7);
000188220217         MthWge8 = PMnthsA(8);
000189220217         MthWge9 = PMnthsA(9);
000190220217         MthWge10 = PMnthsA(10);
000191220217         MthWge11 = PMnthsA(11);
000192220217         MthWge12 = PMnthsA(12);
000193220217
000194220217         // Total Wage Inz & Increment ******** //
000195220217         TtlWge = 0;
000196220217         For J = 1 to 12;
000197220217           TtlWge += PMnthsA(J);
000198220217         EndFor;
000199220217
000200220217         // Calls Overflow Subroutine ********* //
000201220217         Exsr Overflow;
000202220217
000203220217         // Writes PRTF's Detail Rec ********** //
000204220217         Write Detail;
000205220217
000206220217       EndFor;
000207220217
000208220217       // Close SQL Cursor ******************** //
000209220217       Exec SQL Close PayCursor;
000210220217
000211220217       *Inlr = *On;
000212220217       Return;
000213220217
000214220217       // Overflow Subroutine ***************** //
000215220217       Begsr Overflow;
000216220217         if EndOfPage;
000217220217           Write Header;
000218220217           EndOfPage = *Off;
000219220217         EndIf;
000220220217       EndSr;
