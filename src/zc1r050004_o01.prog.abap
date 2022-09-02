*&---------------------------------------------------------------------*
*& Include          ZC1R050004_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S0100'.
  SET TITLEBAR 'T0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout OUTPUT.
  PERFORM set_fcat_layout.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen OUTPUT.
  PERFORM display_screen.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
  SET PF-STATUS 'S0101'.
  SET TITLEBAR 'T0101'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout_0101 OUTPUT.
  gs_layout_pop-zebra = 'X'.
  gs_layout_pop-sel_mode = 'D'.
  gs_layout_pop-no_toolbar = 'X'.

  "key field ref_t ref_f qunt
  PERFORM set_fcat_pop USING :
  'X'   'CARRID'   'SBOOK'   'CARRID'   ' ',
  'X'   'CONNID'   'SBOOK'   'CONNID'   ' ',
  'X'   'FLDATE'   'SBOOK'   'FLDATE'   ' ',
  ' '   'BOOKID'   'SBOOK'   'BOOKID'   ' ',
  ' '   'CUSTOMID'   'SBOOK'   'CUSTOMID'   ' ',
  ' '   'LUGGEWIGHT'   'SBOOK'   'LUGGEWIGHT'   ' ',
  ' '   'WUNIT'   'SBOOK'   'WUNIT'   ' '.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen_0101 OUTPUT.

  IF gcl_container_pop IS INITIAL.

    CREATE OBJECT gcl_container_pop
      EXPORTING
        container_name = 'GCL_CONTAINER_POP'.


    CREATE OBJECT gcl_grid_pop
      EXPORTING
        i_parent = gcl_container_pop.


    CALL METHOD gcl_grid_pop->set_table_for_first_display
      EXPORTING
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout_pop
      CHANGING
        it_outtab       = gt_sbook
        it_fieldcatalog = gt_fcat_pop.

  ENDIF.

ENDMODULE.
