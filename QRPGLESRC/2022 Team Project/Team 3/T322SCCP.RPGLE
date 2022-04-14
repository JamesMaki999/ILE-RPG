000100220413        //*******************************************************
000101220413        // Written by: Christina Pitner                         *
000102220413        // Date: 4/12/2022                                      *
000103220413        // Program Name: T322SCCP.PGLE                          *
000104220413        // Input file(s): FLIGHT2021.SUPPLIER                   *
000105220413        // Output file(s): T322DSPCP.DSPF(Display file)         *
000106220413        // Description: This program uses a screen to take an ID*
000107220413        // from a user, check the SUPPLIER data file for ID and *
000108220413        // if the ID exists, display SUPPLIER INFO ON SCREEN    *
000109220413        // ******************************************************
000110220413
000113220412        //Control Options
000114220412        Ctl-Opt Option(*Nodebugio);
000115220412
000116220412        //File Declarations
000117220412        Dcl-f SUPPLIER Disk Usage(*Input) Keyed;
000118220412        Dcl-f T322DSPCP Workstn Indds(Indicators);
000119220412
000120220412        //Variable Declarations
000121220412        Dcl-Ds Indicators Len(99);
000122220412            Exit Ind Pos(3);
000123220412            Cancel Ind Pos(12);
000124220412        End-Ds;
000125220412
000126220412        //Main Procedure
000127220412
000128220413        //Do While Loop so check for Exits, and if info is correct,
000129220413        //display Supplier info onto screen
000130220412        DoW Not Exit;
000131220412          Exfmt SUIDSEL;
000132220412          If Not Exit;
000133220412            Chain SUID SUPPLIER;
000134220412            If %Found(SUPPLIER);
000135220412              Exfmt SUVIEW;
000136220412            ENDIF;
000137220412          ENDIF;
000138220412        EndDo;
000139220412
000140220412       *Inlr = *On;
000141220412       Return;
