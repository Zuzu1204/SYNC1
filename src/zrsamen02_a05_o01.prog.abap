*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A05_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-uname sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv OUTPUT.

  PERFORM create_object.



ENDMODULE.
