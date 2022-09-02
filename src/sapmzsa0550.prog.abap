*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0550
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa0550_top                            .    " Global Data

 INCLUDE mzsa0550_o01                            .  " PBO-Modules
 INCLUDE mzsa0550_i01                            .  " PAI-Modules
 INCLUDE mzsa0550_f01                            .  " FORM-Routines

 LOAD-OF-PROGRAM.
  zssa0550-carrid = 'AA'.
  zssa0550-mealnumber = '00000007'.
