*&---------------------------------------------------------------------*
*& Include          ZC1R050003_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_flight_list
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_flight_list .

  _clear gs_list gt_list.

  SELECT carrid connid fldate price currency planetype paymentsum
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_list
   WHERE carrid IN so_carr.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .

  gs_layout-zebra = 'X'.
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = 'X'.

  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
    'X'   'CARRID'       ' '   'SFLIGHT'   'CARRID',
    'X'   'CONNID'       ' '   'SFLIGHT'   'CONNID',
    'X'   'FLDATE'       ' '   'SFLIGHT'   'FLDATE',
    ' '   'PRICE'        ' '   'SFLIGHT'   'PRICE',
    ' '   'CURRENCY'     ' '   'SFLIGHT'   'CURRENCY',
    ' '   'PLANETYPE'    ' '   'SFLIGHT'   'PLANETYPE',
    ' '   'PAYMENTSUM'   ' '   'SFLIGHT'   'PAYMENTSUM'.

  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_field pv_text pv_ref_table pv_ref_field.

  gs_fcat = VALUE #( key = pv_key
                     fieldname = pv_field
                     coltext = pv_text
                     ref_table = pv_ref_table
                     ref_field = pv_ref_field ).

  CASE pv_field.
    WHEN 'PRICE' OR 'PAYMENTSUM'. "통화키 맞춰주기
      gs_fcat = VALUE #( BASE gs_fcat
                          cfieldname = 'CURRENCY' ). "큐필드
  ENDCASE.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen OUTPUT.
  PERFORM display_screen.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .

  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = cl_gui_docking_container=>dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    SET HANDLER : lcl_event_handler=>handle_double_click FOR gcl_grid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_list
        it_fieldcatalog = gt_fcat.
  ENDIF.


ENDFORM..
*&---------------------------------------------------------------------*
*& Form handle_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*
FORM handle_double_click  USING ps_row TYPE lvc_s_row
                                ps_column TYPE lvc_s_col.

  READ TABLE gt_list INTO gs_list INDEX ps_row-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  CASE ps_column-fieldname.
    WHEN 'CARRID'.
      IF gs_list-carrid IS INITIAL.
        EXIT.
      ENDIF.

      PERFORM get_airline_info USING gs_list-carrid.

  ENDCASE.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_LIST_CARRID
*&---------------------------------------------------------------------*
FORM get_airline_info  USING pv_carrid TYPE scarr-carrid.

  _clear gs_scarr gt_scarr.

  SELECT carrid carrname currcode url
    FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr
   WHERE carrid = pv_carrid.

  IF sy-subrc NE 0.
    MESSAGE s000 WITH TEXT-m01.
    EXIT.
  ENDIF.

  CALL SCREEN '0101' STARTING AT 20 3.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout_pop
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout_pop .

  gs_layout_pop-zebra      = 'X'.
  gs_layout_pop-cwidth_opt = 'X'.
  gs_layout_pop-sel_mode   = 'D'.
  gs_layout_pop-no_toolbar = 'X'.

  IF gt_fcat_pop IS INITIAL.
    PERFORM set_fcat_pop USING :
    'X'   'CARRID'     ' '    'SCARR'   'CARRID',
    ' '   'CARRNAME'   ' '    'SCARR'   'CARRNAME',
    ' '   'CURRCODE'   ' '    'SCARR'   'CURRCODE',
    ' '   'URL'        ' '    'SCARR'   'URL'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_pop
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat_pop  USING pv_key pv_field pv_text pv_ref_table pv_ref_field.

  gt_fcat_pop = VALUE #( BASE gt_fcat_pop
                          (
                            key       = pv_key
                            fieldname = pv_field
                            coltext   = pv_text
                            ref_table = pv_ref_table
                            ref_field = pv_ref_field
                           )
                         ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen_pop
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen_pop .
  IF gcl_container_pop IS NOT BOUND.
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
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat_pop.

  ENDIF.
ENDFORM.
