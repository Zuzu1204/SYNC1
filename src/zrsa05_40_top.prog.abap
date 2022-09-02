*&---------------------------------------------------------------------*
*& Include ZRSA05_40_TOP                            - Report ZRSA05_40
*&---------------------------------------------------------------------*
REPORT zrsa05_40.

PARAMETERS pa_pernr TYPE ztsa0501-pernr.

DATA: gs_list TYPE zssa0530,
      gt_list LIKE TABLE OF gs_list.
