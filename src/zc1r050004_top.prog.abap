*&---------------------------------------------------------------------*
*& Include ZC1R050004_TOP                           - Report ZC1R050004
*&---------------------------------------------------------------------*
REPORT zc1r050004 MESSAGE-ID zmcsa05.

TABLES : scarr, sflight.

DATA : BEGIN OF gs_data,
         carrid    TYPE scarr-carrid,
         carrname  TYPE scarr-carrname,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         url       TYPE scarr-url,

       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,

       BEGIN OF gs_sbook,
         carrid      TYPE sbook-carrid,
         connid      TYPE sbook-connid,
         fldate      TYPE sbook-fldate,
         bookid      TYPE sbook-bookid,
         customid    TYPE sbook-customid,
         custtype    TYPE sbook-custtype,
         luggweight  TYPE sbook-luggweight,
         wunit       TYPE sbook-wunit,
       END OF gs_sbook,

       gt_sbook LIKE TABLE OF gs_sbook.

DATA : gv_okcode TYPE sy-ucomm.

*ALV관련
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant.

*Popup 관련
DATA : gcl_container_POP TYPE REF TO cl_gui_custom_container,
       gcl_grid_POP      TYPE REF TO cl_gui_alv_grid,
       gs_fcat_POP       TYPE lvc_s_fcat,
       gt_fcat_POP       TYPE lvc_t_fcat,
       gs_layout_POP     TYPE lvc_s_layo.
