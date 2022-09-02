*&---------------------------------------------------------------------*
*& Report ZRCA05_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca05_01.

DO 6 TIMES.
  WRITE sy-index.  " -가 들어가면 structure ~라고 부른다.
  NEW-LINE.
  ENDDO.

*DATA gv_gender TYPE c LENGTH 1.  "M, F
*gv_gender = 'X'.
*CASE gv_gender.
* WHEN 'M'.
*
* WHEN 'F'.
*
* WHEN OTHERS.
*
* ENDCASE.
*
*IF gv_gender = 'M'.
*
*ELSEIF gv_gender = 'F'.
*
*ELSE.
*
*ENDIF.


gv_gender = 'F'.
