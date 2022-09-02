*&---------------------------------------------------------------------*
*& Report ZRSA05_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_36.
TYPES: BEGIN OF ts_dep, "type으로 주면 ref설정을 할 수 없기 때문에 program에서 따로 설정 해줘야함.
        budget TYPE ztsa0502-budget,
        waers TYPE ztsa0502-waers,
       END OF ts_dep.

DATA: gs_dep TYPE zssa0520, "ztsa0502
      gt_dep LIKE TABLE OF gs_dep.

DATA go_salv TYPE REF TO cl_salv_table.

START-OF-SELECTION.
  SELECT *
    FROM ztsa0502
    INTO CORRESPONDING FIELDS OF TABLE gt_dep.

*  cl_demo_output=>display_data( gt_dep ).

cl_salv_table=>factory(
   IMPORTING r_salv_table = go_salv
  CHANGING t_table = gt_dep
    ).
go_salv->display( ).
