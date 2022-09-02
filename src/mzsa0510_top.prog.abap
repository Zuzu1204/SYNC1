*&---------------------------------------------------------------------*
*& Include MZSA0510_TOP                             - Module Pool      SAPMZSA0510
*&---------------------------------------------------------------------*
PROGRAM sapmzsa0510.

"Common Variable
DATA ok_code TYPE sy-ucomm.
DATA gv_subrc TYPE sy-subrc. "0이면 성공 0이 아니면 실패

"Condition
TABLES zssa0580. "Use Screen ==> 잘 만든 structure만 쓸 때 의미있음
*DATA gs_cond TYPE ZSSA0580. "Use ABAP: 내가 얼마든지 변경 가능

"Airline info
TABLES zssa0581.
*DATA gs_airline TYPE zssa0581.

"Connection Info
TABLES zssa0582.
*DATA gs_conn TYPE zssa0082.
