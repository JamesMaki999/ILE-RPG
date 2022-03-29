000100211109         //************************************//
000101211109         // Name: James Maki ******************//
000102211109         // Course: RPG ILE/IV ****************//
000103211109         // Assignment 9 - Chapter 8 **********//
000104211109         // Date: November 10 2021 *************//
000105211109         //************************************//
000106211109
000109211109         // Exercises Declarations ************//
000110211111                   DCL-S STARTDATE DATE INZ(D'1999-12-31');
000111211111                   DCL-S ENDDATE DATE INZ(D'2001-01-01');
000112211111                   DCL-S BIRTHDATE DATE;
000113211111                   DCL-S CURRENTDATE DATE INZ(*SYS);
000114211111                   DCL-S JOBSTARTDATE DATE INZ(*JOB);
000115211111                   DCL-S MIDNIGHT TIME INZ(T'24.00.00');
000116211111                   DCL-S BIRTHTIME TIME INZ(T'06.45.15');
000117211111                   DCL-S JOBSTARTTIME TIME INZ(T'24.00.00');
000118211111                   DCL-S JOBENDTIME TIME INZ(T'06.45.15');
000119211111
000120211111                   DCL-S NUMDAYS UNS(5);
000121211111                   DCL-S NUMYEAR UNS(5);
000122211111                   DCL-S NUMHOUR UNS(10);
000123211111                   DCL-S NUMMINU UNS(10);
000124211111                   DCL-S BIRTHSTAMP TIMESTAMP(0);
000125211111                   DCL-S NUMTENS TIMESTAMP INZ(Z'2005-12-10-06.45.15');
000126211111                   DCL-S NATDAT DATE;
000127211111                   DCL-S NATTIM TIME;
000128211111
000129211111                   DCL-S TODAY DATE INZ(*SYS);
000130211111                   DCL-S DAYSTONEWYEARS ZONED(5);
000132211111                   DCL-C NEWYEARSEVE CONST(D'2015-12-31');
000133211109
000134211109         // Exercise 1 ************************//
000135211111                   NUMDAYS = %DIFF(BIRTHDATE:CURRENTDATE:*DAYS);
000136211109         // Exercise 2 ************************//
000137211111                   NUMYEAR = %DIFF(STARTDATE:CURRENTDATE:*YEARS);
000138211111         // Exercise 3 ************************// fIGURE OUT ERRORS LATER
000139211111                   NUMHOUR = %DIFF(STARTDATE:ENDDATE:*DAYS);
000140211111                   NUMHOUR /= 24;
000141211111         // Exercise 4 ************************//
000142211111                   NUMMINU = %DIFF(BIRTHDATE:CURRENTDATE:*DAYS);
000143211111                   NUMMINU /= 1440;
000144211109         // Exercise 5 ************************//
000145211111                   BIRTHDATE += %YEARS(20);
000146211109         // Exercise 6 ************************//
000147211111                   CURRENTDATE += %MONTHS(30);
000148211109         // Exercise 7 ************************//
000149211111                   JOBSTARTTIME += %HOURS(6);
000150211109         // Exercise 8 ************************//
000151211111                   MIDNIGHT -= %HOURS(8);
000152211109         // Exercise 9 ************************//
000153211111                   BIRTHDATE = D'1951-12-10';
000154211111                   BIRTHTIME = T'06.45.15';
000155211111                   BIRTHSTAMP = %TIMESTAMP(BIRTHDATE + BIRTHTIME);
000156211109         // Exercise 10 ***********************//
000157211111                   NATDAT = %DATE(NUMTENS);
000158211111                   NATTIM = %TIME(NUMTENS);
000159211109         // Exercise 13 ***********************//
000160211111         // New Year's Eve is December 31 2021 //
000161211109         // A *********************************//
000162211111         // Initialized Above *****************//
000163211109         // B *********************************//
000164211111         // Initialized Above *****************//
000165211109         // C *********************************//
000166211111         // Initialized Above *****************//
000167211109         // D *********************************//
000168211111                   DAYSTONEWYEARS = %DIFF(NEWYEARSEVE:TODAY:*DAYS);
