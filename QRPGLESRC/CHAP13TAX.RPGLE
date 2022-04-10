000100220409       // ************************************* //
000101220409       // Computer Prog in Advanced ILE RPG *** //
000102220409       // Chapter 13 Prototype Example ******** //
000103220409       // Called Program - Calculates TaxAmount //
000104220409       // James Maki ************************** //
000105220409       // ************************************* //
000106220324
000107220409       // Control Option Declaration ********** //
000108220324       Ctl-Opt Option(*Nodebugio);
000109220324
000110220409       // Prototype Declaration *************** //
000111220324       Dcl-pr CalcTax ExtPgm('CHAP13TAX');
000112220324         Rate       Zoned(7:2)      Const;
000113220324         Amount     Zoned(7:2)      Const;
000114220324         Tax        Zoned(9:2);
000115220324       End-pr;
000116220324
000117220409       // Procedure Interface Declaration ***** //
000118220324       Dcl-pi CalcTax;
000119220324         Rate       Zoned(7:2)      Const;
000120220324         Amount     Zoned(7:2)      Const;
000121220324         Tax        Zoned(9:2);
000122220324       End-pi;
000123220324
000124220409       // Calculate and Init Tax ************** //
000125220324       Tax = Rate * Amount;
000126220324
000127220409       // Inlr & Return *********************** //
000128220324       *Inlr = *On;
000129220324       Return;
