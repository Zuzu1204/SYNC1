*&---------------------------------------------------------------------*
*& Include ZC1R050001_TOP                           - Report ZC1R050001
*&---------------------------------------------------------------------*
REPORT zc1r050001 MESSAGE-ID zmcsa05.

TABLES : sflight.

DATA : BEGIN OF gs_data,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         planetype TYPE sflight-planetype,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.

*ALV 관련
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       "숫자만 주면 알아서 커짐, alv 전용으로 사용
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       "table type은 자기가 table을 만드는 순간 생긴다.
       gs_layout     TYPE lvc_s_layo,
       gs_variant type disvariant. "layout

DATA : gv_okcode TYPE sy-ucomm.
