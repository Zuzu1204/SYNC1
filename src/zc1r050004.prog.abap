*&---------------------------------------------------------------------*
*& Report ZC1R050004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050004_top                          .    " Global Data

INCLUDE zc1r050004_s01                          .  " Selection Screen
INCLUDE zc1r050004_c01                          .  " Local Class
INCLUDE zc1r050004_o01                          .  " PBO-Modules
INCLUDE zc1r050004_i01                          .  " PAI-Modules
INCLUDE zc1r050004_f01                          .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.
  PERFORM get_data.

  CALL SCREEN '0100'.
