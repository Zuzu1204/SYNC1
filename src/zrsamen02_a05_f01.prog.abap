*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A05_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form create_object
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object .

  CREATE OBJECT go_con
    EXPORTING
      container_name = 'MY_CONTROL_AREA'.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_con.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT'
*     is_variant       =
*     i_save           =
*     i_default        = 'X'
*     is_layout        =
*     is_print         =
*     it_special_groups             =
*     it_toolbar_excluding          =
*     it_hyperlink     =
*     it_alv_graphics  =
*     it_except_qinfo  =
*     ir_salv_adapter  =
    CHANGING
      it_outtab        = gt_sflight
      it_fieldcatalog  = gt_fcat
*     it_sort          =
*     it_filter        =
*    EXCEPTIONS
*     invalid_parameter_combination = 1
*     program_error    = 2
*     too_many_lines   = 3
*     others           = 4
    .



ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sflight
   WHERE carrid IN so_car
     AND connid IN so_con
     AND fldate IN so_fld.


ENDFORM.
