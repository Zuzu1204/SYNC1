*&---------------------------------------------------------------------*
*& Report ZRCA05_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca05_04.

PARAMETERS pa_car TYPE scarr-carrid.
*PARAMETERS pa_car1 TYPE c LENGTH 3.

DATA gs_info TYPE scarr.  "g는 global의 약자, v는 version, s의 약자는 structure

CLEAR gs_info.
SELECT SINGLE carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_info
*  INTO gs_info
WHERE carrid = pa_car.

IF sy-subrc = 0.
ENDIF.

WRITE: gs_info-mandt, gs_info-carrid, gs_info-carrname.
