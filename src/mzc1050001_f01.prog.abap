*&---------------------------------------------------------------------*
*& Include          SAPMZC1050001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f4_werks
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f4_werks .

  SELECT werks, name1, ekorg, land1
    INTO TABLE @DATA(lt_werks)
    FROM t001w.


  IF sy-subrc NE 0.
    MESSAGE s001.
    EXIT.
  ENDIF.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield     = 'WERKS'
      dynpprog     = sy-repid
      dynpnr       = sy-dynnr
      dynprofield  = 'GS_DATA-WERKS'
      window_title = TEXT-t01
      value_org    = 'S'
    TABLES
      value_tab    = lt_werks.

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

  REFRESH gt_data.

  SELECT matnr werks mtart matkl menge meins dmbtr waers
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztsa0510.

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
  gs_layout-cwidth_opt = 'X'.
  gs_layout-sel_mode = 'D'.

  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
    'X'   'MATNR'   ' '   'ZTSA0510'   'MATNR'   ' '       ' ',
    'X'   'WERKS'   ' '   'ZTSA0510'   'WERKS'   ' '       ' ',
    ' '   'MTART'   ' '   'ZTSA0510'   'MTART'   ' '       ' ',
    ' '   'MATKL'   ' '   'ZTSA0510'   'MATKL'   ' '       ' ',
    ' '   'MENGE'   ' '   'ZTSA0510'   'MENGE'   'MEINS'   ' ',
    ' '   'MEINS'   ' '   'ZTSA0510'   'MEINS'   ' '       ' ',
    ' '   'DMBTR'   ' '   'ZTSA0510'   'DMBTR'   ' '       'WAERS',
    ' '   'WAERS'   ' '   'ZTSA0510'   'WAERS'   ' '       ' '.
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
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key
                     pv_field
                     pv_text
                     pv_ref_table
                     pv_ref_field
                     pv_qfield
                     pv_cfield.

  gt_fcat = VALUE #( BASE gt_fcat
                     (
                       key        = pv_key
                       fieldname  = pv_field
                       coltext    = pv_text
                       ref_table  = pv_ref_table
                       ref_field  = pv_ref_field
                       qfieldname = pv_qfield
                       cfieldname = pv_cfield
                     )
                   ).
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        container_name = 'GCL_CONTAINER'.


    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_data .

*  data : ls_save type ZTSA0510,
*         lt_save type TABLE OF ZTSA0510,

*  DATA : lt_save TYPE TABLE OF ztsa0510,
*         ls_save LIKE LINE OF lt_save.

  DATA : ls_save TYPE ztsa0510.

  CLEAR ls_save.
*  REFRESH lt_save.

  IF gs_data-matnr IS INITIAL OR
     gs_data-werks IS INITIAL.
    MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  ls_save = CORRESPONDING #( gs_data ).

*  APPEND ls_save TO lt_save.

  MODIFY ztsa0510 FROM ls_save.

  IF sy-dbcnt > 0.
    COMMIT WORK AND WAIT.
    MESSAGE s000 WITH TEXT-m01.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s000 WITH TEXT-m02 DISPLAY LIKE 'W'.
  ENDIF.

ENDFORM.
