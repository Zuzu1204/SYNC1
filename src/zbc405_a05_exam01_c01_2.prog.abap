*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_EXAM01_C01
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_toolbar FOR EVENT toolbar
                        OF cl_gui_alv_grid
                 IMPORTING e_object,
      on_user_command FOR EVENT user_command
                        OF cl_gui_alv_grid
                 IMPORTING e_ucomm,
      on_doubleclick FOR EVENT double_click
                        OF cl_gui_alv_grid
                 IMPORTING e_row e_column es_row_no.
ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.

  "버튼 넣기
  METHOD on_toolbar.
    DATA: ls_button TYPE stb_button.

    CLEAR ls_button.
    ls_button-function = 'GETNAME'.
    ls_button-icon     = icon_ws_plane.
    ls_button-quickinfo = 'Get Airline Name'.
    ls_button-butn_type = '0'.
    ls_button-text     = 'Flight'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'FLINFO'.
    ls_button-quickinfo = 'GoTo Flight info list'.
    ls_button-butn_type = '0'.
    ls_button-text     = 'Flight Info'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'FLDATA'.
    ls_button-quickinfo = 'GoTo Maintain Flight Data'.
    ls_button-butn_type = '0'.
    ls_button-text     = 'Flight Data'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
  ENDMETHOD.

  "버튼 기능넣기
  METHOD on_user_command.

    DATA : ls_row TYPE lvc_s_row,
           ls_col TYPE lvc_s_col,
           lv_text TYPE scarr-carrname,
           lt_rows type LVC_T_ROW,
           ls_row type lvc_s_row.

    CALL METHOD go_alv_grid->get_current_cell
      IMPORTING
        es_row_id = ls_row   "index
        es_col_id = ls_col.  "fieldname

    CASE e_ucomm.
*      첫번째버튼
      WHEN 'GETNAME'.
        IF ls_col-fieldname = 'CARRID'.

          READ TABLE gt_flt INTO gs_flt INDEX ls_row-index.
          SELECT SINGLE carrname
            FROM scarr
            INTO lv_text
           WHERE carrid = gs_flt-carrid.

            IF sy-subrc = 0.
              MESSAGE i000(zmcsa05) WITH lv_text.
            ELSE.
              MESSAGE i000(zmcsa05) WITH 'Check again.'.
            ENDIF.
        ELSE.
          MESSAGE i000(zmcsa05) WITH 'Click Airline.'.
        ENDIF.


*      두번째버튼
      WHEN 'FLINFO'.
        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
            et_index_rows = lt_rows.
*            et_row_no     =.

        LOOP AT lt_rows into ls_row.
          READ TABLE gt_flt INTO gs_flt INDEX ls_row-

        ENDLOOP.

    ENDCASE.

  ENDMETHOD.


    METHOD on_doubleclick.
    IF e_column-fieldname = 'CARRID' OR e_column-fieldname = 'CONNID'.
      READ TABLE gt_flt INTO gs_flt INDEX e_row-index.
      IF sy-subrc = 0.
        SUBMIT bc405_event_s4 AND RETURN  "and return 쓰지 않으면 종료됨!
          WITH so_car = gs_flt-carrid
          WITH so_con = gs_flt-connid.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
