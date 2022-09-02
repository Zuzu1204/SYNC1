*&---------------------------------------------------------------------*
*& Report ZRSA05_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_01.

PARAMETERS pa_carr TYPE scarr-carrid.
PARAMETERS pa_carr1(3) TYPE c.

DATA gs_scarr TYPE scarr.


PERFORM get_data.


*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
SELECT SINGLE * FROM scarr
                INTO gs_scarr
                WHERE carrid = pa_carr.

IF sy-subrc = 0.

  NEW-LINE.

  WRITE: gs_scarr-carrid,
         gs_scarr-carrname,
         gs_scarr-url.

ELSE.

  WRITE 'Sorry, no data found!'(t03).
* MESSAGE 'Sorry, no data found!' TYPE 'I'.

ENDIF.

ENDFORM.
