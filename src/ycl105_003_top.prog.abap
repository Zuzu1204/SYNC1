*&---------------------------------------------------------------------*
*& Include          YCL105_002_TOP
*&---------------------------------------------------------------------*

TABLES : scarr.

DATA : ok_code TYPE sy-ucomm,
       save_ok TYPE sy-ucomm.

DATA : gt_scarr TYPE TABLE OF scarr.

SELECTION-SCREEN BEGIN OF SCREEN 0101 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-t01.

    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(10) TEXT-l02 FOR FIELD s_carrid. " 항공사ID
      SELECT-OPTIONS s_carrid FOR scarr-carrid.
    SELECTION-SCREEN END OF LINE.

    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(10) TEXT-l03 FOR FIELD s_carrnm. " 항공사명
      SELECT-OPTIONS s_carrnm FOR scarr-carrname.
      SELECTION-SCREEN PUSHBUTTON 77(10) TEXT-l01 USER-COMMAND search.
    SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN END OF BLOCK b01.

SELECTION-SCREEN END OF SCREEN 0101.
