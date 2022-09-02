*&---------------------------------------------------------------------*
*& Report ZBC400_SA05_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_sa05_compute.

PARAMETERS pa_int1 TYPE i.
PARAMETERS pa_op TYPE c LENGTH 1.
PARAMETERS pa_int2 LIKE pa_int1.

DATA gv_result TYPE p LENGTH 16 DECIMALS 2.

IF pa_op = '+'.
  gv_result = pa_int1 + pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

ELSEIF
  pa_op = '-'.
  gv_result = pa_int1 - pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

ELSEIF
  pa_op = '*'.
  gv_result = pa_int1 * pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

ELSE.
  pa_op = '/'.
  gv_result = pa_int1 / pa_int2.
  WRITE gv_result.
  CLEAR gv_result.


ENDIF.
