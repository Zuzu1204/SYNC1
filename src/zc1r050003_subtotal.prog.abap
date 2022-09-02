*&---------------------------------------------------------------------*
*& Report ZC1R200003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R050003_SUBTOTAL_TOP.
*INCLUDE zc1r200003_top                          .    " Global Data

INCLUDE ZC1R050003_SUBTOTAL_S01.
*INCLUDE zc1r200003_s01                          .  " Selection Screen
INCLUDE ZC1R050003_SUBTOTAL_C01.
*INCLUDE zc1r200003_c01                          .  " Local Class
INCLUDE ZC1R050003_SUBTOTAL_O01.
*INCLUDE zc1r200003_o01                          .  " PBO-Modules
INCLUDE ZC1R050003_SUBTOTAL_I01.
*INCLUDE zc1r200003_i01                          .  " PAI-Modules
INCLUDE ZC1R050003_SUBTOTAL_F01.
*INCLUDE zc1r200003_f01                          .  " FORM-Routines

START-OF-SELECTION.
  PERFORM get_flight_list.
  PERFORM set_carrname.

  CALL SCREEN '0100'.
