*&---------------------------------------------------------------------*
*& Include          ZRSA05_ABAP3_05_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS     : pa_wer TYPE mast-werks OBLIGATORY DEFAULT '1010'.
  SELECT-OPTIONS : so_mat FOR mast-matnr.
SELECTION-SCREEN END OF BLOCK bl1.
