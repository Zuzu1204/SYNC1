*&---------------------------------------------------------------------*
*& Include          ZRSA05_ABAP3_05_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv OUTPUT.

  CREATE OBJECT go_con
    EXPORTING
*     parent    =
      repid     = sy-repid
      dynnr     = sy-dynnr
*     side      = DOCK_AT_LEFT
      extension = 3000.


  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_con.


  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
*     i_buffer_active =
*     i_bypassing_buffer            =
*     i_consistency_check           =
*     i_structure_name              =
*     is_variant      =
*     i_save          =
*     i_default       = 'X'
      is_layout       = gs_layout
*     is_print        =
*     it_special_groups             =
*     it_toolbar_excluding          =
*     it_hyperlink    =
*     it_alv_graphics =
*     it_except_qinfo =
*     ir_salv_adapter =
    CHANGING
      it_outtab       = gt_data
      it_fieldcatalog = gt_fcat.





ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
