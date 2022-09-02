*&---------------------------------------------------------------------*
*& Include ZBC405_A05_M01_TOP                       - Report ZBC405_A05_M01
*&---------------------------------------------------------------------*
REPORT zbc405_a05_m01.

"COMMON VARIABLE
DATA ok_code TYPE sy-ucomm.

TABLES ztsbook_A05. "select-options에 써주기 위해서 선언함

"selection SCREEN
SELECT-OPTIONS : pa_car FOR ztsbook_A05-carrid,  "for 다음에는 이미 선언되어 있는 변수가 와야함
                 pa_con FOR ztsbook_A05-connid.

"ALV 생성
DATA : GO_coN TYPE REF TO cl_gui_custom_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

"IN ALV
TYPES BEGIN OF ts_sbook.
  INCLUDE TYPE ztsbook_A20.
TYPES : light TYPE c LENGTH 1,
        rowcol TYPE c LENGTH 4,
        rowcol2 type c length 4,
        END OF ts_sbook.

"data 담을 변수
DATA : gs_sbook TYPE ts_sbook,
       gt_sbook LIKE TABLE OF gs_sbook.

"ALV 관련변수
DATA : gs_layout TYPE lvc_s_layo,
       gt_fcat TYPE lvc_t_fcat,
       gs_fcat LIKE LINE OF gt_fcat.
