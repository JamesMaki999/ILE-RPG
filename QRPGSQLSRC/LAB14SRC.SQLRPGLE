000100220405       // ************************************* //
000101220403       // Computer Prog in Advanced ILE RPG *** //
000102220403       // Lab 14 SQLRPGLE Program ************* //
000103220405       // CSINVP Currency Exchange ************ //
000104220403       // James Maki ************************** //
000105220403       // ************************************* //
000107220403
000108220407       // Control Option Declaration ********** //
000109220407       Ctl-Opt              Option       (*NodeBugio);
000110220403
000111220407       // Output PRTF File Declaration ******** //
000112220407       Dcl-f LAB14PRTF      Printer Usage(*Output) Oflind(EndOfPage);
000113220403
000114220405       // Constant Variables ****************** //
000115220407       Dcl-c EndOfFile      '02000';
000116220405
000117220405       // Standalone Variables **************** //
000118220407       Dcl-s CurrNam        Char         (3);
000119220407       Dcl-s CurrVal        Zoned        (5:2);
000120220407       Dcl-s CD_Exch        Zoned        (5:2);
000121220407       Dcl-s EU_Exch        Zoned        (5:2);
000122220407       Dcl-s US_Exch        Zoned        (5:2);
000125220407       Dcl-s X              Uns          (5);
000126220405
000127220407       // SQL CSINVP Cursor Standalone Variable //
000128220407       Dcl-s CSIN_AvgCst    Zoned        (7:2);
000129220407       Dcl-s CSIN_CurCst    Zoned        (7:2);
000130220407       Dcl-s CSIN_Desc      Char         (30);
000131220407       Dcl-s CSIN_Prod      Zoned        (6);
000132220407       Dcl-s CSIN_SellP     Zoned        (7:2);
000133220407       Dcl-s CSIN_QTYOH     Zoned        (4);
000136220405
000137220405       // Main Data Structure ***************** //
000138220405       Dcl-ds CurrDS Dim(3) Qualified Inz;
000139220407         CurrName           Char         (3);
000140220407         CurrValu           Zoned        (5:2);
000141220405       End-ds;
000142220405
000143220407       // CalcExch Procedure ****************** //
000144220407       Dcl-pr CalcExch ExtPgm('LAB14CALC');
000145220407         PRTF_Field         Packed       (7:2);
000146220407         SRC_Cost           Zoned        (7:2);
000147220407         SRC_ExcRte         Zoned        (5:2);
000148220407       End-pr;
000153220405
000154220405       // SQL Cursor Currency Declaration ***** //
000155220404       Exec SQL Declare CurrCursor Cursor For
000156220404         Select * From Flight2021.CURRENCY
000157220404         Where ABBR = 'USA' OR ABBR = 'CAD'
000158220404         OR ABBR = 'EUR'
000159220404         For Read Only;
000160220405
000161220405       // SQL Cursor CSINVP Declaration ******* //
000162220405       Exec SQL Declare CSINCursor Cursor For
000163220405         Select c.PRODNO, c.DESCRP, c.SELLPR,
000164220405         c.QTYOH, c.CURCST, c.AVGCST
000165220405         From Flight2021.CSINVP AS c
000166220405         For Read Only;
000167220403
000168220404       // Open SQL Cursor ********************* //
000169220404       Exec SQL Open CurrCursor;
000170220404
000171220407       // Currency For Loop Declaration Start * //
000172220405       For X = 1 to %Elem(CurrDS);
000173220407
000174220407         // SQL Fetch Currency Values ********* //
000175220407         Exec SQL Fetch CurrCursor Into
000176220404           :CurrNam, :CurrVal;
000177220404
000178220407         // DataStruct's Currency Values Init * //
000179220405         CurrDS(X).CurrName = CurrNam;
000180220405         CurrDS(X).CurrValu = CurrVal;
000181220405
000182220407         // If Statement to Assign Exchange Rte //
000183220405         If CurrNam = 'USA';
000184220404           US_Exch = CurrVal;
000185220405         ElseIf CurrNam = 'CAD';
000186220404           CD_Exch = CurrVal;
000187220405         ElseIf CurrNam = 'EUR';
000188220404           EU_Exch = CurrVal;
000189220404         EndIf;
000190220404
000191220407       // Currency For Loop Declaration End *** //
000192220405       EndFor;
000193220404
000194220404       // Close SQL Cursor ******************** //
000195220404       Exec SQL Close CurrCursor;
000196220404
000197220405       // Write PRTF's Header ***************** //
000198220405       Write Header;
000199220405
000200220405       // Open SQL CSINVP Cursor ************** //
000201220405       Exec SQL Open CSINCursor;
000202220405
000203220407       // Do Until SQLState Loop Start ******** //
000204220405       Dou SQLState = EndOfFile;
000205220407
000206220407         // SQL Fetch Values ****************** //
000207220405         Exec SQL Fetch CSINCursor Into
000208220405           :CSIN_Prod, :CSIN_Desc, :CSIN_SellP,
000209220405           :CSIN_QTYOH, :CSIN_CurCst, :CSIN_AvgCst;
000210220405
000211220407         // PRTF Field Initialize Values ****** //
000212220405         L14_ProNum = CSIN_Prod;
000213220405         L14_Desc = CSIN_Desc;
000214220405         L14_QTY = CSIN_QTYOH;
000215220405
000216220407         // Current Price Calc and Init ******* //
000217220407         Callp CalcExch(L14_USD:CSIN_CurCst:US_Exch);
000218220407         Callp CalcExch(L14_CAD:CSIN_CurCst:CD_Exch);
000219220407         Callp CalcExch(L14_EURO:CSIN_CurCst:EU_Exch);
000220220405
000221220405         // Current Price Total Calc and Init * //
000222220405         TTLUSCST += L14_USD;
000223220405         TTLCDCST += L14_CAD;
000224220405         TTLEUCST += L14_EURO;
000225220405
000226220407         // Average Price Calc and Init ******* //
000228220407         Callp CalcExch(L14_USDA:CSIN_AvgCst:US_Exch);
000229220407         Callp CalcExch(L14_CADA:CSIN_AvgCst:CD_Exch);
000230220407         Callp CalcExch(L14_EURA:CSIN_AvgCst:EU_Exch);
000233220405
000234220405         // Average Price Total Calc and Init * //
000235220405         TTLUSAVG += L14_USDA;
000236220405         TTLCDAVG += L14_CADA;
000237220405         TTLEUAVG += L14_EURA;
000238220405
000239220407         // Selling Price Calc and Init ******* //
000242220407         Callp CalcExch(L14_USDS:CSIN_SellP:US_Exch);
000243220407         Callp CalcExch(L14_CADS:CSIN_SellP:CD_Exch);
000244220407         Callp CalcExch(L14_EURS:CSIN_SellP:EU_Exch);
000247220405
000248220405         // Selling Price Total Calc and Init * //
000249220405         TTLUSPRC += L14_USDS;
000250220405         TTLCDPRC += L14_CADS;
000251220407         TTLEUPRC += L14_EURS;
000253220405
000254220407         // Write PRTF's Details Record ******* //
000255220405         Write Details;
000256220405
000257220407         // PRTF's Total Counter += 1 ********* //
000258220405         TTLPRTS += 1;
000259220405
000260220407       // Do Until SQLState Loop End ********** //
000261220405       EndDo;
000262220405
000263220407       // Close SQL CSINVP Cursor ************* //
000264220405       Exec SQL Close CSINCursor;
000265220405
000266220407       // Write PRTF's Summary Records ******** //
000267220405       Write HeadSum;
000268220405       Write TTLSum;
000269220405
000270220407       // Inlr & Return *********************** //
000271220405       *Inlr = *On;
000272220408       Return;
