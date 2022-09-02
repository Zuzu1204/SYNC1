*&---------------------------------------------------------------------*
*& Include SAPMZSA0502_TOP                          - Report SAPMZSA0502
*&---------------------------------------------------------------------*
REPORT sapmzsa0502.

*DATA: BEGIN OF gs_cond,
*        carrid TYPE sflight-carrid,
*        connid TYPE sflight-connid,
*      END OF gs_cond.

" Condition
TABLES zssa0560.
data gs_cond type zssa0560.
DATA: ok_code TYPE sy-ucomm.
