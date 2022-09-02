*&---------------------------------------------------------------------*
*& Include ZRSA05_23_TOP                            - Report ZRSA05_23
*&---------------------------------------------------------------------*
REPORT zrsa05_23.

" Sch Date Info

"internal table 선언
DATA: gt_info TYPE TABLE OF zsinfo00,
      gs_info LIKE LINE OF gt_info.

*Selection Screen
PARAMETERS: pa_car type sbook-carrid DEFAULT 'AA',
            pa_con type sbook-connid DEFAULT '0017'.
