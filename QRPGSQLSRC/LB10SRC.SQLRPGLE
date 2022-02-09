000100220205       // ************************************* //
000101220209       // Computer Prog in Advanced ILE RPG *** //
000102220209       // Lab 10 SQLRPGLE Program ************* //
000103220205       // James Maki ************************** //
000104220205       // ************************************* //
000105220205
000106220205       // Control Options Declaration ********* //
000107220209       CTL-OPT DFTACTGRP(*NO);
000108220205
000109220205       // File Declaration ******************** //
000110220209       DCL-F LAB10PRTF Printer Usage(*Output) Oflind(EndOfPage);
000111220205
000112220205       // Data Struct Declaration ************* //
000113220209       DCL-DS GTCStruct;
000114220205         CPHONE Zoned(10:0); // Shared ******** //
000115220205         CLNAME Char(15);    // GTCSTP ******** //
000116220205         CFNAME Char(10);    // GTCSTP********* //
000117220205         CSTRET Char(20);    // GTCSTP ******** //
000118220205         CCITY Char(15);     // GTCSTP ******** //
000119220205         CSTAT Char(2);      // GTCSTP ******** //
000120220205         CZIP Zoned(5:0);    // GTCSTP ******** //
000121220205         DATRCVL Date(*USA); // GTCPAYP ******* //
000122220205         PAYDATL Date(*USA); // GTCSTP ******** //
000123220205       END-DS;
000124220205
000125220205       // EndOfFile/Page Declaration ********** //
000126220209       DCL-C EndOfFile '02000';
000127220209       DCL-S EndOfPage Ind Inz(*ON);
000128220205
000129220205       // Constants and Standalone Declarations //
000130220209       DCL-C ZipEd '     ';
000131220209       DCL-S TotCust Zoned(4:0);
000132220209       DCL-S AvgDays Zoned(8:0);
000133220205
000134220205       // SQL Cursor Declaration ************** //
000135220205       Exec SQL Declare StructCur Cursor For
000136220205         Select s.CPHONE, s.CLNAME, s.CFNAME,
000137220205         s.CSTRET, s.CCITY, s.CSTAT,
000138220205         s.CZIP, p.DATRCVL, s.PAYDATL
000139220205         From FLIGHT2021.GTCSTP s
000140220205         Inner Join FLIGHT2021.GTCPAYP p
000141220205         On p.CPHONE = s.CPHONE
000142220205         Order By s.CLNAME ASC, s.CFNAME ASC
000143220205         For Read Only;
000144220205
000145220205       // SQL Open Cursor ********************* //
000146220205       Exec SQL Open StructCur;
000147220205
000148220205       // Do Until EndOfFile Loop ************* //
000149220205       dou SQLState = EndOfFile;
000150220205
000151220205         // Fetch Cursor Values Into Struct *** //
000152220205         Exec SQL Fetch StructCur Into :GTCStruct;
000153220205
000154220205         // Empty File Check ****************** //
000155220205         Select;
000156220205           When SQLState = EndOfFile;
000157220205             Leave;
000158220205         ENDSL;
000159220205
000160220205         // Calls Overflow Subroutine ********* //
000161220205         Exsr Overflow;
000162220205
000163220205         // Printer File's Fields Initialized * //
000164220205         CustPho = CPHONE;
000166220205         CustName = %trim(CFName) + ', ' + %trim(CLName);
000168220205         CustLocat = %trim(CSTRET) + '. ' +
000169220205           %trim(CCITY) + ', ' + %trim(CSTAT) +
000170220205           '. ' + %editw(CZIP:ZipEd);
000172220205         CustPay = %dec(PAYDATL);
000174220205         CustRcv = %dec(DATRCVL);
000175220205
000176220205         // Processing Days ******************* //
000177220205         ProDay = %diff(PAYDATL:DATRCVL:*Days);
000178220205
000179220205         // Total Customers Incrementation **** //
000180220205         TotCust += 1;
000181220205
000182220205         // Average Days Incrementation ******* //
000183220205         AvgDays += %diff(PAYDATL:DATRCVL:*Days);
000184220205
000185220205         // Write Printer File Detail Record ** //
000186220209         WRITE Details;
000187220205
000188220205       ENDDO;
000189220205
000190220209       // Adding the Day Average ************** //
000191220205       AvgDaysNum += AvgDays / TotCust;
000192220205
000193220209       // Adding to Customer Total ************ //
000194220205       CustTot += TotCust;
000195220205
000196220209       // SQL Close Cursor ******************** //
000197220205       Exec SQL Close StructCur;
000198220205
000199220209       // Write Printer File Total Record ***** //
000200220209       WRITE Total;
000201220205
000202220205       *Inlr = *On;
000203220205       Return;
000204220205
000205220209       // Overflow Subroutine ***************** //
000206220205       Begsr Overflow;
000207220205         if EndOfPage;
000208220209           WRITE Header;
000209220205           EndOfPage = *Off;
000210220205         ENDIF;
000211220205       ENDSR;
