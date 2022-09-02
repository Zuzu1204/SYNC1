*&---------------------------------------------------------------------*
*& Report SAPMZSA0502
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE sapmzsa0502_top                         .    " Global Data

 INCLUDE sapmzsa0502_o01                         .  " PBO-Modules
 INCLUDE sapmzsa0502_i01                         .  " PAI-Modules
 INCLUDE sapmzsa0502_f01                         .  " FORM-Routines

 LOAD-OF-PROGRAM.
  PERFORM set_default.
