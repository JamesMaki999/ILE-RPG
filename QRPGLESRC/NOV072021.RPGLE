000100211106         //************************************//
000101211106         // Name: James Maki ******************//
000102211106         // Course: RPG ILE/IV ****************//
000103211106         // Assignment 8 - Chapter 7 **********//
000104211106         // Date: November 7 2021 ***********//
000105211106         //************************************//
000106211106
000107211106                   DCL-C EDITT '   -   -    ';
000108211106                   DCL-S NAME CHAR(15) INZ('JOHN SMITH');
000109211106                   DCL-S NAME2 CHAR(18) INZ('James Thomas Wells');
000110211106                   DCL-S NUMBER PACKED(11:0) INZ(2625643158);
000111211106                   DCL-S NUMBER2 CHAR(20) INZ('262-564-3158');
000112211106                   DCL-S EXAMPLE CHAR(20);
000113211106                   DCL-S REPLACE CHAR(1) INZ('');
000114211106                   DCL-S EX4A CHAR(20) INZ('JAMES CARTER THOMAS');
000115211106                   DCL-S EX4B CHAR(35) INZ('200 WEST STREET KENOSHA WI 53142');
000116211106                   DCL-S EX4C CHAR(19) INZ('Alice Susan Simmons');
000117211106                   DCL-S EX4D CHAR(11) INZ('938-58-7843');
000118211106
000119211106         // Question 1 ************************//
000120211106                   NAME = %REPLACE('John Smith':NAME);
000121211106                   NAME2 = %REPLACE('J. T. WELLS':NAME2);
000122211106
000123211106         // Question 2 ************************//
000124211106                   EXAMPLE = %EDITW(NUMBER:EDITT);
000125211106                   EXAMPLE = %SCANRPL(REPLACE:'-':NUMBER2) + '513465262';
000126211106
000127211106         // Question 4 ************************//
000128211106                   EX4A = %REPLACE('James Thomas Carter':EX4A);
000129211106                   EX4B = %REPLACE('200 West Street Kenosha, WI 53142':EX4B);
000130211106                   EX4C = %REPLACE('A. S. Simmons':EX4C);
000131211106                   EX4D = %SCANRPL('66':'58':EX4D);
000132211106
