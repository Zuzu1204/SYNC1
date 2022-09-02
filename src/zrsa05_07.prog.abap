*&---------------------------------------------------------------------*
*& Report ZRSA05_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_07.

PARAMETERS pa_date TYPE sy-datum.

DATA gv_date LIKE pa_date.
MOVE pa_date TO gv_date.

*IF gv_date > gv_date + 6.
*  WRITE 'ABAP Dictionary'.
*
*ELSEIF pa_date < pa_date - 6.
*  WRITE 'SAPUI5'.
*
*ENDIF.
