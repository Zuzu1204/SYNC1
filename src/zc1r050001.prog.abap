
*&---------------------------------------------------------------------*
*& Report ZC1R050001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050001_top                          .    " Global Data

INCLUDE zc1r050001_s01                          .  " Selection Screen
INCLUDE zc1r050001_o01                          .  " PBO-Modules
INCLUDE zc1r050001_i01                          .  " PAI-Modules
INCLUDE zc1r050001_f01                          .  " FORM-Routines

INITIALIZATION.
  PERFORM init_param.

START-OF-SELECTION.
  PERFORM get_data.

*  if gt_data is not initial.  이렇게 할 때도 있음
  CALL SCREEN '0100'.
