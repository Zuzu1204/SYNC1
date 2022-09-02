*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_EXAM01_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv OUTPUT.
  IF go_container IS INITIAL.

*    container
    CREATE OBJECT go_container
      EXPORTING
*        parent                      =
        container_name              = 'MY_CONTROL_AREA' .

    IF sy-subrc = 0.

*      grid
      CREATE OBJECT go_alv_grid
        EXPORTING
          i_parent          = go_container.


           PERFORM make_fieldcatalog.
           PERFORM set_layout.

           SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
           SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
           SET HANDLER lcl_handler=>on_doubleclick FOR go_alv_grid.

           APPEND cl_gui_alv_grid=>mc_fc_loc_cut TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_copy TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_mb_paste TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_undo TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_append_row TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row TO gt_exct.
           APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row TO gt_exct.


*          set table for first display
          CALL METHOD go_alv_grid->set_table_for_first_display
            EXPORTING
*              i_buffer_active               =
*              i_bypassing_buffer            =
*              i_consistency_check           =
              i_structure_name              = 'ztspfli_A05'
              is_variant                    = gs_variant
              i_save                        = 'A'
              i_default                     = 'X'
              is_layout                     = gs_layout
*              is_print                      =
*              it_special_groups             =
              it_toolbar_excluding          = gt_exct
*              it_hyperlink                  =
*              it_alv_graphics               =
*              it_except_qinfo               =
*              ir_salv_adapter               =
            CHANGING
              it_outtab                     = gt_flt
              it_fieldcatalog               = gt_fcat
*              it_sort                       =
*              it_filter                     =
*            EXCEPTIONS
*              invalid_parameter_combination = 1
*              program_error                 = 2
*              too_many_lines                = 3
*              others                        = 4
                  .
          IF sy-subrc <> 0.
*           Implement suitable error handling here
          ENDIF.




    ENDIF.

  ENDIF.
ENDMODULE.
