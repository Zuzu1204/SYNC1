*&---------------------------------------------------------------------*
*& Include ZRSAMEN02_A05_TOP                        - Report ZRSAMEN02_A05
*&---------------------------------------------------------------------*
REPORT zrsamen02_a05.

TABLES : sflight, zssa05M01.

DATA : ok_code TYPE sy-ucomm.

DATA : gs_sflight TYPE sflight,
       gt_sflight LIKE TABLE OF gs_sflight.

*ALV생성
DATA : go_con  TYPE REF TO cl_gui_custom_container,
       go_alv  TYPE REF TO cl_gui_alv_grid,
       gs_fcat TYPE lvc_s_fcat,
       gt_fcat TYPE lvc_t_fcat.
