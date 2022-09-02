*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0504
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa0503top                             .    " Global Data

 INCLUDE mzsa0503o01                             .  " PBO-Modules
 INCLUDE mzsa0503i01                             .  " PAI-Modules
 INCLUDE mzsa0503f01                             .  " FORM-Routines

LOAD-OF-PROGRAM.
  SELECT pernr ename
    FROM ztsa0501 UP TO 1 ROWS
    INTO CORRESPONDING FIELDS OF zssa0561.
  ENDSELECT.
