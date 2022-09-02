*&---------------------------------------------------------------------*
*& Include ZBC405_A05_ALV_05_TOP                    - Report ZBC405_A05_ALV_05
*&---------------------------------------------------------------------*
REPORT zbc405_a05_alv_05.

DATA ok_code TYPE sy-ucomm.

TABLES ztspfli_t03.

SELECT-OPTIONS : pa_car FOR ztspfli_t03-carrid,
                 pa_con FOR ztspfli_t03-connid.

*ALV생성
DATA : go_con TYPE REF TO cl_gui_custom_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

*in ALV
TYPES BEGIN OF ts_spfli.
  INCLUDE TYPE ztspfli_t03.
TYPES :

        END OF ts_spfli.

*data 담을 변수
DATA : gs_spfli TYPE ts_spfli,
       gt_spfli LIKE TABLE OF gs_spfli.
