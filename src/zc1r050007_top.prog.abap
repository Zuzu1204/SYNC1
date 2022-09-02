*&---------------------------------------------------------------------*
*& Include ZC1R050007_TOP                           - Report ZC1R050007
*&---------------------------------------------------------------------*
REPORT zc1r050007 MESSAGE-ID zmcsa05.

TABLES : ztsa0501.

DATA : BEGIN OF gs_data,
         mark,
         pernr  TYPE ztsa0501-pernr,
         ename  TYPE ztsa0501-ename,
         entdt  TYPE ztsa0501-entdt,
         gender TYPE ztsa0501-gender,
         depcd  TYPE ztsa0501-depcd,
         carrid TYPE ztsa0501-carrid,
         carrname type scarr-carrname,
         gtext  TYPE ztsa0501-gtext,
         style type lvc_t_styl,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,
       gt_data_del LIKE TABLE OF gs_data.

DATA : gv_okcode TYPE sy-ucomm.

DATA : gt_rows TYPE lvc_t_row,
       gs_row TYPE lvc_s_row.  "사용자가 선택한 행의 정보 저장할 ITAB

*ALV관련
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_Fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant,
       gs_stable     TYPE lvc_s_stbl.
