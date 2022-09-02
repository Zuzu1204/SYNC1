*&---------------------------------------------------------------------*
*& Report ZRSA05_ABAP3_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_abap3_05_top                     .    " Global Data

INCLUDE zrsa05_abap3_05_s01                     .  " Selection-Screen
INCLUDE zrsa05_abap3_05_o01                     .  " PBO-Modules
INCLUDE zrsa05_abap3_05_i01                     .  " PAI-Modules
INCLUDE zrsa05_abap3_05_f01                     .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.
  PERFORM get_data.

  CALL SCREEN 100.
