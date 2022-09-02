*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA0514
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa0506_top.
*INCLUDE mzsa0514_top                            .    " Global Data

INCLUDE mzsa0506_o01.
* INCLUDE mzsa0514_o01                            .  " PBO-Modules
INCLUDE mzsa0506_i01.
* INCLUDE mzsa0514_i01                            .  " PAI-Modules
INCLUDE mzsa0506_f01.
* INCLUDE mzsa0514_f01                            .  " FORM-Routines


 LOAD-OF-PROGRAM.
 PERFORM set_default CHANGING zssa0073.
 CLEAR: gv_r1, gv_r2, gv_R3.
 gv_r2 = 'X'.
