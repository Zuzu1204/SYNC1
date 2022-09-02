*&---------------------------------------------------------------------*
*& Include ZRSA05_31_TOP                            - Report ZRSA05_31
*&---------------------------------------------------------------------*
REPORT zrsa05_31.

"employee List
DATA: gs_emp TYPE zssa0504,
      gt_emp LIKE TABLE OF gs_emp. "sturucture table 가지고 intertable 만들기

"Selection screen
PARAMETERS: pa_ent_b LIKE gs_emp-entdt,
            pa_ent_e LIKE gs_emp-entdt.
