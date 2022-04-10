000100220409       // ************************************* //
000101220407       // Computer Prog in Advanced ILE RPG *** //
000102220407       // Lab 14 RPGLE Program **************** //
000103220407       // CSINVP Currency - Calc Exchange ***** //
000104220407       // James Maki ************************** //
000105220407       // ************************************* //
000106220407
000107220407       // Control Option Declaration ********** //
000108220407       Ctl-Opt Option(*Nodebugio);
000109220408
000110220408       // Prototype Declaration *************** //
000111220408       Dcl-pr CalcExch ExtPgm('LAB14CALC');
000112220407         PRTF_Field         Packed       (7:2);
000113220407         SRC_Cost           Zoned        (7:2);
000116220407         SRC_ExcRte         Zoned        (5:2);
000117220408       End-pr;
000118220407
000119220407       // Procedure Interface Declaration ***** //
000120220407       Dcl-pi CalcExch;
000121220407         PRTF_Field         Packed       (7:2);
000122220407         SRC_Cost           Zoned        (7:2);
000127220407         SRC_ExcRte         Zoned        (5:2);
000128220407       End-pi;
000129220407
000130220407       // Current Cost Calc and Init ********** //
000131220407       Eval(h) PRTF_Field = SRC_Cost * SRC_ExcRte;
000137220407
000138220407       // Inlr & Return *********************** //
000139220407       *Inlr = *On;
000140220407       Return;
