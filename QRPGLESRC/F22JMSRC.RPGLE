000100220406       // ************************************* //
000101220406       // Computer Prog in Advanced ILE RPG *** //
000102220406       // Final Exam Team Project RPGLE Program //
000103220406       // RPGLE program for F22JMDSPF.DSPF **** //
000104220406       // Lists Customer Details ************** //
000105220406       // James Maki ************************** //
000106220406       // ************************************* //
000107220330
000108220413       // Control Option Declaration ********** //
000109220330       Ctl-Opt Option(*NodeBugio);
000110220330
000111220413       // File Declaration ******************** //
000112220413       Dcl-f CUSTOMER Disk(*Ext) Usage(*Input) Keyed
000113220413       EXTDESC('FLIGHT2021/CUSTOMER') EXTFILE(*EXTDESC);
000114220330       Dcl-f F22JMDSPF Workstn Indds(Indicators);
000115220330
000116220413       // Data Structure Declaration ********** //
000117220330       Dcl-ds Indicators Len(99);
000118220330         Exit Ind Pos(3);
000119220330         Cancel Ind Pos(12);
000120220330       End-ds;
000121220330
000122220413       // Do While Not Indds Exit Loop Start ** //
000123220330       Dow Not Exit;
000124220413
000125220413         // Execute DSPF's Select Screen ****** //
000126220330         Exfmt CST_SELECT;
000127220413
000128220413         // If Not Indds Exit Condition Start * //
000129220330         If Not Exit;
000130220413
000131220413           // Chain DSPF's Input to File ****** //
000132220330           Chain CUSTNO CUSTOMER;
000133220413
000134220413           // If Input is Found Condition Start //
000135220330           If %Found(CUSTOMER);
000136220413
000137220413             // Execute DSPF's Display Screen * //
000138220330             Exfmt CST_DSPLY;
000139220413
000140220413           // If Input is Found Condition End * //
000141220413           EndIf;
000142220413
000143220413         // If Not Indds Exit Condition End *** //
000144220413         EndIf;
000145220413
000146220413       // Do While Not Indds Exit Loop End **** //
000147220330       EndDo;
000148220330
000149220413       // Inlr & Return *********************** //
000150220330       *Inlr = *On;
000151220330       Return;
