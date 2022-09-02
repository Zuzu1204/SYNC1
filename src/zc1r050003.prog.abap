*&---------------------------------------------------------------------*
*& Report ZC1R050003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r050003_top                          .    " Global Data

INCLUDE zc1r050003_s01                          .  " Selection Screen
INCLUDE zc1r050003_c01                          .  " Local Class
INCLUDE zc1r050003_o01                          .  " PBO-Modules
INCLUDE zc1r050003_i01                          .  " PAI-Modules
INCLUDE zc1r050003_f01                          .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.
  PERFORM get_flight_list.

  CALL SCREEN 0100.
