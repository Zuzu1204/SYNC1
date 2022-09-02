*&---------------------------------------------------------------------*
*& Report ZC1R050005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050005_top                          .    " Global Data

INCLUDE zc1r050005_s01                          .  " PBO-Modules
INCLUDE zc1r050005_c01                          .  " PBO-Modules
INCLUDE zc1r050005_o01                          .  " PBO-Modules
INCLUDE zc1r050005_i01                          .  " PAI-Modules
INCLUDE zc1r050005_f01                          .  " FORM-Routines

INITIALIZATION.
  PERFORM init_param.

START-OF-SELECTION.
  PERFORM get_belnr.

  CALL SCREEN '100'.
