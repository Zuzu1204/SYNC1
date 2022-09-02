*&---------------------------------------------------------------------*
*& Report ZRSA05_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_08.
*PARAMETERS pa_date TYPE sy-datum.
*
*DATA gv_date LIKE pa_date.
*MOVE pa_date TO gv_date.
*
*IF gv_date > gv_date + 6.
*  WRITE 'ABAP Dictionary'.
*
*ELSEIF pa_date < pa_date - 6.
*  WRITE 'SAPUI5'.
*
*ENDIF.
PARAMETERS pa_code TYPE c LENGTH 4 DEFAULT 'SYNC'.  "default 선언
PARAMETERS pa_date TYPE sy-datum.
DATA gv_cond_d1 LIKE pa_date.  "value 선언

gv_cond_d1 = sy-datum + 7.

CASE pa_code.
  WHEN 'SYNC'.
    IF pa_date > gv_cond_d1.
      WRITE 'Abap Dictionary'(t02).
    ELSE.
      WRITE 'ABAP Workbench'(t01).
    ENDIF.
  WHEN OTHERS.
    WRITE '다음 기회에 수강'(t03).
ENDCASE.
