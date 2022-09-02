*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A05_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS : so_car FOR zssa05m01-carrid NO-EXTENSION,
                   so_con FOR zssa05m01-connid NO-EXTENSION,
                   so_fld FOR sflight-fldate   NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK bl1.
