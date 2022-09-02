*&---------------------------------------------------------------------*
*& Include ZBC405_A05_ALV_TOP                       - Report ZBC405_A05_ALV_04
*&---------------------------------------------------------------------*
REPORT zbc405_a05_alv_04.

*type 선언
TYPES: BEGIN OF ts_sflight.
  INCLUDE TYPE zsflight_a05.
types: light type c length 1.
TYPES: END OF ts_sflight.

*data 선언
DATA gt_flt TYPE TABLE OF ts_sflight.
DATA gs_flt TYPE ts_sflight.

*alv 선언
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv_grid TYPE REF TO cl_gui_alv_grid.

*alv setting
DATA : gs_layout TYPE lvc_s_layo.


*selection option
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                   so_con FOR gs_flt-connid MEMORY ID con,
                   so_dat FOR gs_flt-fldate.
  SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN END OF BLOCK b1.
