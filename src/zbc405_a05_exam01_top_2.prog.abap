*&---------------------------------------------------------------------*
*& Include ZBC405_A05_EXAM01_TOP                    - Report ZBC405_A05_EXAM01
*&---------------------------------------------------------------------*
REPORT zbc405_a05_exam01.

*type 선언
TYPES : BEGIN OF ts_sflight.
          INCLUDE TYPE ztspfli_A05.

TYPES:  iandd TYPE c LENGTH 1,
        fltype_icon TYPE icon-id,
        frtzone TYPE sairport-time_zone,
        totzone TYPE sairport-time_zone,
        it_color type lvc_t_scol,
        light type c length 1,
        END OF ts_sflight.


*Ok_code
DATA: ok_code LIKE sy-ucomm.

*data 선언
DATA gt_flt TYPE TABLE OF ts_sflight.
DATA gs_flt TYPE ts_sflight.

DATA: gt_sairp TYPE TABLE OF sairport,
      gs_sairp TYPE sairport.

*alv data 선언
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv_grid TYPE REF TO cl_gui_alv_grid.
DATA : gs_variant TYPE disvariant.
DATA : gs_layout TYPE lvc_s_layo,
       gt_fcat TYPE lvc_t_fcat,
       gs_fcat TYPE lvc_s_fcat,
       gs_color type lvc_s_scol,
       gt_exct type ui_functions.

*selection option
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                   so_con FOR gs_flt-connid MEMORY ID con.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN SKIP 1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(14) TEXT-t02.
    SELECTION-SCREEN POSITION POS_LOW.
    PARAMETERS pa_var TYPE disvariant-variant.
    SELECTION-SCREEN COMMENT pos_high(10) text-t03.
    PARAMETERS pa_edit AS CHECKBOX.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.
