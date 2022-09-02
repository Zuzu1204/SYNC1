*&---------------------------------------------------------------------*
*& Include          YCL105_002_CLS
*&---------------------------------------------------------------------*

DATA : gr_con TYPE REF TO cl_gui_custom_container,
       gr_alv TYPE REF TO cl_gui_alv_grid.

*ALV 표현
DATA : gs_layout TYPE lvc_s_layo,
       gs_fcat   TYPE lvc_t_fcat,
       gt_fcat   TYPE lvc_t_fcat.
