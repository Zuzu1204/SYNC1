*&---------------------------------------------------------------------*
*& Report ZC1R050007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050007_top                          .    " Global Data

INCLUDE zc1r050007_s01                          .  " PBO-Modules
INCLUDE zc1r050007_c01                          .  " PBO-Modules
INCLUDE zc1r050007_o01                          .  " PBO-Modules
INCLUDE zc1r050007_i01                          .  " PAI-Modules
INCLUDE zc1r050007_f01                          .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_style.

  CALL SCREEN '100'.
