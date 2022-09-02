*&---------------------------------------------------------------------*
*& Report ZRSA05_ABAP3_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050002_top.
*INCLUDE zrsa05_abap3_05_top                     .    " Global Data

INCLUDE zc1r050002_c01.
INCLUDE zc1r050002_s01.
*INCLUDE zrsa05_abap3_05_s01                     .  " Selection-Screen
INCLUDE zc1r050002_o01.
*INCLUDE zrsa05_abap3_05_o01                     .  " PBO-Modules
INCLUDE zc1r050002_i01.
*INCLUDE zrsa05_abap3_05_i01                     .  " PAI-Modules
INCLUDE zc1r050002_f01.
*INCLUDE zrsa05_abap3_05_f01                     .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.
  PERFORM get_data.

  CALL SCREEN 100.
