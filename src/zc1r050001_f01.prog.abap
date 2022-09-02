*&---------------------------------------------------------------------*
*& Include          ZC1R050001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_param
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_param .
  pa_carr = 'KA'.
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

  CLEAR   gs_data.
  REFRESH gt_data.

  SELECT carrid connid fldate price currency planetype
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM sflight
   WHERE carrid = pa_carr
     AND connid IN so_conn.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.  "STOP.
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

  gs_fcat = VALUE #( key       = pv_key
                     fieldname = pv_field
                     coltext   = pv_text
                     ref_table = pv_ref_table
                     ref_field = pv_ref_field ).

CASE pv_field.
  WHEN 'PRICE'.
    gs_fcat-cfieldname = 'CURRENCY'.
ENDCASE.

*  gs_fcat-key       = pv_key.
*  gs_fcat-fieldname = pv_field.
*  gs_fcat-coltext   = pv_text.
*  gs_fcat-ref_table = pv_ref_table.
*  gs_fcat-ref_field = pv_ref_field.
*
  APPEND gs_fcat TO gt_fcat.
*  CLEAR  gs_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .

  IF GCL_CONTAINER IS NOT BOUND.

    CREATE OBJECT gcl_container
      EXPORTING
        repid                       = SY-REPID
        dynnr                       = SY-DYNNR
*        side                        = cl_gui_docking_container=>doc_at_left
        side                        = gcl_container->dock_at_left
        extension                   = 3000.


    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent          = gcl_container.

    gs_variant-report = sy-repid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant                    = gs_variant
        i_save                        = 'A'
        i_default                     = 'X'
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_data
        it_fieldcatalog               = gt_fcat.

  ENDIF.

ENDFORM.
