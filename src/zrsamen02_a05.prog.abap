*&---------------------------------------------------------------------*
*& Report ZRSAMEN02_A05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsamen02_a05_top                       .    " Global Data

INCLUDE zrsamen02_a05_s01                       .  " Selection-Screen
INCLUDE zrsamen02_a05_o01                       .  " PBO-Modules
INCLUDE zrsamen02_a05_i01                       .  " PAI-Modules
INCLUDE zrsamen02_a05_f01                       .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.
  PERFORM get_data.


END-OF-SELECTION.
  IF sy-subrc = 0.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'No Data!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
