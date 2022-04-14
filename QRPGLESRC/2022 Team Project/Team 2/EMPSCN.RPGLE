000100220409        //*********************************************************************
000101220409        //     Written by Cameron Murray
000102220409        //
000103220409        //     Date: 04/06/22
000104220409        //     Program name: EMPSCN
000105220409        //     Description:  Prompts the user for a employee number. It lists the
000106220409        //     information of that particular employee.
000107220409        //**********************************************************************
000108220409        //----------------------------------------------------------------------
000109220409        //     Control Options
000110220409        //----------------------------------------------------------------------
000111220409
000112220409          ctl-opt option(*nodebugio);
000113220409        //----------------------------------------------------------------------
000114220409        //      Declarations
000115220409        //----------------------------------------------------------------------
000116220409
000117220409        //Files
000118220409          Dcl-f EMPSCNDSPF Workstn INDDS(Indicators);
000119220409          dcl-f EMPLOYEE Disk(*Ext) Usage(*Input)keyed;
000120220409
000121220409        //Data Structure
000122220409           Dcl-ds Indicators Len(99);
000123220409           Exit Ind Pos(3);
000124220409           Cancel Ind Pos(12);
000125220409         END-DS;
000126220409
000127220409        //Service Program
000128220409         dcl-pr Propercase;
000129220409          TempString  Char(39);
000130220409         END-PR;
000131220409
000132220409          dcl-s StringProp  Char(39);
000133220409          dcl-s city        char(30);
000134220409          dcl-s st          char(2);
000135220409          dcl-s zip         char(5);
000136220409          dcl-c LowerCase   'abcdefghijklmnopqrstuvwxyz';
000137220409          dcl-c UpperCase   'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
000138220409        //***************************************
000139220409        // MAIN
000140220409        //***************************************
000142220409         DOW Not Exit;
000143220409         EXFMT EMPNOINP;
000144220409
000145220409          If Not Exit or Cancel;
000147220409           Chain EMPNO EMPLOYEE;
000148220409          if %Found(EMPLOYEE);
000149220409               //Service Program Convert Name to Proper case
000150220409          EMPNM = %Trim(ELName) + ', ' + %trim(EFName);
000151220409           Callp Propercase(StringProp);
000152220409            StringProp= EMPNM;
000153220409
000154220409           //edit city
000155220409           city =  %Trim(eCity);
000156220409           Callp Propercase(StringProp);
000157220409            StringProp= city;
000158220409
000159220409           //edit State
000160220409           st = %Xlate(LowerCase:UpperCase:EState);
000161220409                     //concatenate city, state, and zip
000162220409
000163220409           Callp Propercase(StringProp);
000164220409           csz = %Trim(city) + ', ' + st + ', ' + %Trim(ezip);
000165220409           StringProp = csz;
000166220409           EXFMT EMPDSP;
000167220409          ENDIF;
000168220409          ENDIF;
000169220409         Enddo;
000170220409
000171220409         *INLR = *on;
000172220409         Return;
