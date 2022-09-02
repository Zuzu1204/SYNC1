*----------------------------------------------------------------------*
***INCLUDE ZET_0810_ALV_A00_O01
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_CONTROL_PROCESSING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_control_processing OUTPUT.

  IF go_container IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
*        parent                      =
        container_name              = 'MY_CONTROL_AREA'   .

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent          = go_container.

CALL METHOD go_alv_grid->set_table_for_first_display
  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
    i_structure_name              = 'SBOOK'
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = gt_book.

  ENDIF.

ENDMODULE.
