*&---------------------------------------------------------------------*
*& Report ZRSA05_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_30.

*TYPES: BEGIN OF ts_info,
*        stdno TYPE n LENGTH 8,
*        sname TYPE c LENGTH 40,
*       END OF ts_info.

DATA gs_std TYPE zssa0501.

gs_std-stdno = '20220001'.
gs_std-sname = 'Kang SK'.
