*&---------------------------------------------------------------------*
*& Include ZRSA05_ABAP3_05_TOP                      - Report ZRSA05_ABAP3_05
*&---------------------------------------------------------------------*
REPORT zrsa05_abap3_05 MESSAGE-ID zmcsa05.

CLASS lcl_event_handler DEFINITION DEFERRED.  "글로벌 형태로 참조할 수 있게 만들어줌

TABLES : mast.

DATA : BEGIN OF gs_data ,
         matnr TYPE mast-matnr,
         maktx TYPE makt-maktx,
         stlan TYPE mast-stlan,
         stlnr TYPE mast-stlnr,
         stlal TYPE mast-stlal,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.

DATA : ok_code TYPE sy-ucomm.

*ALV 생성
DATA : go_con TYPE REF TO cl_gui_docking_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

*ALV
DATA : gs_fcat     TYPE lvc_s_fcat,
       gt_fcat     TYPE lvc_t_fcat,
       gcl_handler TYPE REF TO lcl_event_handler,
       gs_layout   TYPE lvc_s_layo,
       gs_variant  TYPE disvariant.


DEFINE _clear.

  CLEAR &1.
  REFRESH &1.

END-OF-DEFINITION.
