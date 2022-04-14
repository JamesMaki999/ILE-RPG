000100220412       // ************************************* //
000101220412       // Computer Prog in Advanced ILE RPG *** //
000102220412       // Final Exam Team Project RPGLE Program //
000103220412       // RPGLE program for JOB_DSPF.DSPF ***** //
000104220412       // Lists Job Type Details ************** //
000105220412       // James Maki ************************** //
000106220412       // ************************************* //
000107220412
000108220413       // Control Option Declaration ********** //
000109220412       Ctl-Opt Option(*NodeBugio);
000110220412
000111220413       // File Declaration ******************** //
000112220413       Dcl-f JOBTYPE Disk(*Ext) Usage(*Input) Keyed;
000113220412       Dcl-f JOB_DSPF Workstn Indds(Indicators);
000114220412
000115220413       // Data Structure Declaration ********** //
000116220412       Dcl-ds Indicators Len(99);
000117220412         Exit Ind Pos(3);
000118220412         Cancel Ind Pos(12);
000119220412       End-ds;
000120220412
000121220413       // Do While Not Indds Exit Loop Start ** //
000122220412       Dow Not Exit;
000123220412         Exfmt JOB_SELECT;
000124220412         If Not Exit;
000125220412           Chain JTID JOBTYPE;
000126220412           If %Found(JOBTYPE);
000127220412             Exfmt JOB_DSPLY;
000128220412           EndIf;
000129220412         EndIf;
000130220413
000131220413       // Do While Not Indds Exit Loop End **** //
000132220412       EndDo;
000133220412
000134220413       // Inlr & Return *********************** //
000135220412       *Inlr = *On;
000136220412       Return;
