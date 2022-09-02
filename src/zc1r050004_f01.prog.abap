*&---------------------------------------------------------------------*
*& Include          ZC1R050004_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  CLEAR gt_data.
*  refresh screen. "헤더라인이 있는 테이블에서 몸통만 지우고 싶을 때.
  SELECT a~carrid a~carrname a~url
         b~connid b~fldate   b~planetype b~price b~currency
    FROM scarr AS a
   INNER JOIN sflight AS b
      ON a~carrid = b~carrid
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE a~carrid    IN so_carr
     AND b~connid    IN so_conn
     AND b~planetype IN so_plan.

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

    "key fieldname coltext ref_t ref_f currency
    PERFORM set_fcat USING :
    'X'   'CARRID'     ' '   'SCARR'     'CARRID'      ' ',
    ' '   'CARRNAME'   ' '   'SCARR'     'CARRNAME'    ' ',
    ' '   'CONNID'     ' '   'SFLIGHT'   'CONNID'      ' ',
    ' '   'FLDATE'     ' '   'SFLIGHT'   'FLDATE'      ' ',
    ' '   'PLANETYPE'  ' '   'SFLIGHT'   'PLANETYPE'   ' ',
    ' '   'PRICE'      ' '   'SFLIGHT'   'PRICE'       ' ',
    ' '   'CURRENCY'   ' '   'SFLIGHT'   'CURRENCY'    ' ',
    ' '   'URL'        ' '   'SCARR'     'URL'         ' '.
  ENDIF.


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

  IF gcl_container IS NOT BOUND.

    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
*       side      = cl_gui_docking_container=>dock_at_left
        side      = GCL_CONtainer->dock_at_left
        extension = 3000.


    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    SET HANDLER : lcl_event_handler=>on_double_click FOR gcl_grid.


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
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_fname pv_text pv_ref_t pv_ref_f pv_curr.

  CLEAR gs_fcat.

  gs_fcat-key = pv_key.
  gs_fcat-fieldname = pv_fname.
  gs_fcat-coltext = pv_text.
  gs_fcat-ref_table = pv_ref_t.
  gs_fcat-ref_field = pv_ref_f.
  gs_fcat-cfieldname = pv_curr.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*
FORM on_double_click  USING ps_row    TYPE lvc_s_row
                            ps_column TYPE lvc_s_col.

  READ TABLE gt_Data INTO gs_data INDEX ps_row-INdex.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  IF ps_column-fieldname NE 'PLANETYPE'.

    SELECT carrid connid fldate bookid customid custtype
           luggweight wunit
      FROM sbook
      INTO CORRESPONDING FIELDS OF TABLE gt_sbook
     WHERE carrid = gs_data-carrid
       AND connid = gs_data-connid
       AND fldate = gs_data-fldate.

    call screen '0101' STARTING AT 20 10.
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
FORM set_fcat_pop  USING pv_key pv_fname pv_ref_t pv_ref_f pV_QUNT.

  GT_FCAT_POP = VALUE #( BASE GT_FCAT_POP
                          ( KEY = PV_KEY
                            FIELDNAME = pv_fname
                            ref_table = pv_ref_t
                            ref_field = pv_ref_f
                            qfieldname = pv_qunt
                           )
                         ).

ENDFORM.
