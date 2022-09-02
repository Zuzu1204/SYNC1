*&---------------------------------------------------------------------*
*& Report ZRSA05_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_09.

DATA gv_d TYPE sy-datum.

gv_d = sy-datum - 365.

CLEAR gv_d.

IF gv_d IS INITIAL. "'00000000'.
  WRITE 'No Date'.
ELSE.
  WRITE 'Exist Date'.
ENDIF.

*DO 10 TIMES.
*  WRITE sy-index.
*  DO 5 TIMES.
*    WRITE sy-index.
*  ENDDO.
*  NEW-LINE.
*
*ENDDO.
