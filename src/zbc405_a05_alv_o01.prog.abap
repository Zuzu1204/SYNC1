*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_ALV_O01
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
*& Module CREAT_CONTAINER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE creat_container OUTPUT.
  IF go_container IS INITIAL.

*----container
  CREATE OBJECT go_container
    EXPORTING
*      parent                      =
      container_name              = 'MY_CONTROL_AREA'.

      IF sy-subrc = 0.  "위의 컨테이너가 만들어지면 grid를 실행해라

*---------grid
          CREATE OBJECT go_alv_grid
            EXPORTING
              i_parent = go_container.


*--------------set table for first display
               IF sy-subrc = 0.

                 perform set_layout.

                 CALL METHOD go_alv_grid->set_table_for_first_display
                   EXPORTING
*                     i_buffer_active               =
*                     i_bypassing_buffer            =
*                     i_consistency_check           =
                     i_structure_name              = 'ZSFLIGHT_A05'
*                     is_variant                    =
*                     i_save                        =
*                     i_default                     = 'X'
                     is_layout                     = gs_layout
*                     is_print                      =
*                     it_special_groups             =
*                     it_toolbar_excluding          =
*                     it_hyperlink                  =
*                     it_alv_graphics               =
*                     it_except_qinfo               =
*                     ir_salv_adapter               =
                   CHANGING
                     it_outtab                     = gt_flt
*                     it_fieldcatalog               =
*                     it_sort                       =
*                     it_filter                     =
*                   EXCEPTIONS
*                     invalid_parameter_combination = 1
*                     program_error                 = 2
*                     too_many_lines                = 3
*                     others                        = 4
                         .
                 IF sy-subrc <> 0.
*                  Implement suitable error handling here
                 ENDIF.

               ENDIF.

      ENDIF.


  ENDIF.
ENDMODULE.
