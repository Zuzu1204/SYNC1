*&---------------------------------------------------------------------*
*& Include          YCL105_001_TOP
*&---------------------------------------------------------------------*

TABLES : scarr.

DATA gt_scarr TYPE TABLE OF scarr.
DATA gs_scarr TYPE scarr.   "구조체로 한줄만 존재

DATA ok_code TYPE sy-ucomm.
DATA save_ok TYPE sy-ucomm.  "OK_CODE를 기록보관하기 위함
