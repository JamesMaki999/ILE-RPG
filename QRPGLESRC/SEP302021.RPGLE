000100210930         //************************************//
000101210930         // Name: James Maki ******************//
000102210930         // Course: RPG ILE/IV ****************//
000103210930         // Assignment 4 - Chapter 4 **********//
000104210930         // Date: September 30 2021 ************//
000105210930         //************************************//
000106210930
000107210930         // Exercise 1 ************************//
000108210930                   DCL-S totalSALES ZONED(11:0);
000109210930                   DCL-S productDESC CHAR(30);
000110210930                   DCL-S salesTAX ZONED(2:2);  // Depending on place, may need 2 digits //
000111210930                   DCL-S buyDATE DATE;
000112210930
000113210930         // Exercise 2 ************************//
000114210930                   DCL-C commissionRATE CONST(0.025);
000115210930                   DCL-C companyNAME CONST('Acme Explosives Company');
000116210930                   DCL-C cuttoffINCOME CONST(76400);
000117210930                   DCL-C socialEDIT CONST('   -   -    ');
000118210930                   DCL-C theDATE CONST(D'2000-01-01');
000119210930
000120210930         // Exercise 3 & 4 *********************//
000121210930                   DCL-DS labelINFO;
000122210930                     Name CHAR(40);
000123210930                     SSN ZONED(10:0);
000124210930                       firstSocialCode ZONED(3:0) OVERLAY(SSN);
000125210930                       secondSocialCode ZONED(3:0) OVERLAY(SSN:*NEXT);
000126210930                       thirdSocialCode ZONED(4:0) OVERLAY(SSN:*NEXT);
000127210930                     phoneNumber ZONED(10:0);
000128210930                       areaCode ZONED(3:0) OVERLAY(phoneNumber);
000129210930                       exchangeCode ZONED(3:0) OVERLAY(phoneNumber:*NEXT);
000130210930                       localCode ZONED(4:0) OVERLAY(phoneNumber:*NEXT);
000131210930                     firstAddressLine CHAR(40);
000132210930                     secondAddressLine CHAR(30);
000133210930                     cityName CHAR(30);
000134210930                     stateName CHAR(20);
000135210930                     provinceName CHAR(30);
000136210930                     postalCode ZONED(5:0);
000137210930                     countryName CHAR(50);
000138210930                   END-DS;
000139210930
000155210930         // Exercise 5 ************************//
000156210930                   DCL-DS customerStruct QUALIFIED;
000157210930                     iD CHAR(5);
000158210930                     firstName CHAR(30);
000159210930                     lastName CHAR(30);
000160210930                     streetAddress CHAR(50);
000161210930                     cityName  CHAR(30);
000162210930                     stateName CHAR(20);
000163210930                     phoneNumber ZONED(10:0);
000164210930                       areaCode ZONED(3:0) OVERLAY(phoneNumber);
000165210930                       exchangeCode ZONED(3:0) OVERLAY(phoneNumber:*NEXT);
000166210930                       localCode ZONED(4:0) OVERLAY(phoneNumber:*NEXT);
000167210930                     SSN ZONED(10:0);
000168210930                       firstSocialCode ZONED(3:0) OVERLAY(SSN);
000169210930                       secondSocialCode ZONED(3:0) OVERLAY(SSN:*NEXT);
000170210930                       thirdSocialCode ZONED(4:0) OVERLAY(SSN:*NEXT);
000171210930                   END-DS;
000172210930
000173210930                   DCL-DS employeeStruct LIKEDS(customerStruct);
