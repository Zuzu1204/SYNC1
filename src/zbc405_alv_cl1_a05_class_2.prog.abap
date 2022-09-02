*&---------------------------------------------------------------------*
*& Include          ZBC405_ALV_CL1_A05_CLASS
*&---------------------------------------------------------------------*

*---정의
CLASS lcl_handler DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS :
      on_doubleclick FOR EVENT
                  double_click OF cl_gui_alv_grid
                  IMPORTING e_row e_column es_row_no,
      on_toolbar FOR EVENT  "이름은 on_toolbar로 할거야
                  toolbar OF cl_gui_alv_grid  "원래이름 : double_click, cl_gui~~에
                  IMPORTING E_object,
      on_usercommand FOR EVENT
                  user_command OF cl_gui_alv_grid
                  IMPORTING e_ucomm,
      on_data_changed FOR EVENT  "우리는 이걸로 쓸거야
                  data_changed OF cl_gui_alv_grid
                  IMPORTING er_data_changed,
      on_data_changed_finish FOR EVENT
                  data_changed_finished OF cl_gui_alv_grid
                  IMPORTING e_modified et_good_cells.  "테이블을 바로 알려준다.

ENDCLASS.

*---기술
CLASS lcl_handler IMPLEMENTATION.

  METHOD on_data_changed_finish.
    DATA : ls_mod_cells TYPE lvc_s_modi.
    CHECK e_modified = 'X'. "이 조건이 참일 때만 아래를 수행하라. 거짓일 경우 이 메소드는 그냥 빠져나감.

    LOOP AT et_good_cells INTO ls_mod_cells.

      PERFORM modify_check USING ls_mod_cells.

    ENDLOOP.
  ENDMETHOD.



  METHOD on_data_changed.
    FIELD-SYMBOLS : <fs> LIKE gt_sbook.

    DATA : ls_mod_cells TYPE lvc_s_modi,
          ls_ins_cells TYPE lvc_s_moce,
          LS_DEL_cells TYPE lvc_s_moce.


    LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.
      CASE ls_mod_cells-fieldname..
        WHEN 'CUSTOMID'.  "customid를 변경할거야
          PERFORM customer_change_part USING er_data_changed
                                         ls_mod_cells.
        WHEN 'CANCELLED'.
      ENDCASE.

    ENDLOOP.

*-- inserted parts
    IF  er_data_changed->mt_inserted_rows IS NOT INITIAL.

      ASSIGN  er_data_changed->mp_mod_rows->* TO <fs>.
      IF sy-subrc EQ 0.
        APPEND LINES OF <fs> TO gt_sbook.
        LOOP AT er_data_changed->mt_inserted_rows INTO ls_ins_cells.

          READ TABLE gt_sbook INTO gs_sbook INDEX ls_ins_cells-row_id.
          IF sy-subrc EQ 0.
*
            PERFORM insert_parts USING er_data_changed
                                          ls_ins_cells.

          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.


*-- delete parts

    IF  er_data_changed->mt_DELETED_rows IS NOT INITIAL.

      LOOP AT er_data_changed->mt_DELETED_rows INTO ls_DEL_cells.

        READ TABLE gt_sbook INTO gs_sbook INDEX ls_DEL_cells-row_id.
        IF sy-subrc EQ 0.
          MOVE-CORRESPONDING gs_sbook to dw_sbook.
          APPEND dw_sbook TO dl_sbook.
        ENDIF.
      ENDLOOP.


    ENDIF.

  ENDMETHOD.

*버튼 기능 넣기
  METHOD  on_usercommand.
    DATA : ls_col TYPE lvc_s_col,
           ls_roid TYPE lvc_s_roid.

      CALL METHOD go_alv->get_current_cell
        IMPORTING
          es_col_id = ls_col
          es_row_no = ls_roid.


    CASE e_ucomm.
      WHEN 'GOTOFL'.
        READ TABLE gt_sbook INTO gs_sbook
             INDEX ls_roid-row_id.
        IF sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_sbook-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sbook-connid.

          CALL TRANSACTION 'SAPBC405CAL'.  "위의 값들로 채워진다.
        ENDIF.
    ENDCASE.

  ENDMETHOD.





*버튼추가
  METHOD on_toolbar.
    DATA : wa_button TYPE stb_button.

    wa_button-butn_type = '3'.   "seperator
    INSERT wa_button INTO TABLE e_object->mt_toolbar.
    "insert: mt_toolbar라는 table타입에 wa_button을 채우는것.

    CLEAR : wa_button.
    wa_button-butn_type = '0'.  "normal button
    wa_button-function = 'GOTOFL'.  "flight connection
    wa_button-icon = icon_flight.
    wa_button-quickinfo = 'Go to flight connection'.
    wa_button-text = 'Flight'.
    INSERT wa_button INTO TABLE e_object->mt_toolbar.

  ENDMETHOD.




*  doubleclick
  METHOD on_doubleclick.
    DATA : carrname TYPE scarr-carrname.
    CASE e_column-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook
          INDEX e_row-index. "row의 위치
          IF sy-subrc EQ 0.
            SELECT SINGLE carrname
              INTO carrname
              FROM scarr
             WHERE carrid = gs_sbook-carrid.
              IF sy-subrc EQ 0.
                MESSAGE i000(zt03_msg) WITH carrname.
              ENDIF.
          ENDIF.

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
