*&---------------------------------------------------------------------*
*& Include          ZRSA05_31_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_default
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_default .
  pa_ent_b = sy-datum - 365.
  pa_ent_e = sy-datum.
ENDFORM.
