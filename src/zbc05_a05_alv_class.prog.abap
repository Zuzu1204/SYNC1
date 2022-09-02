*&---------------------------------------------------------------------*
*& Include          ZBC05_A05_ALV_CLASS
*&---------------------------------------------------------------------*
*

*더블클릭하는 순간 이코노미, 비즈니스, 퍼스트의 부킹된 좌석수 합산해서 보여주기
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
        on_doubleclick FOR EVENT double_click
                              OF cl_gui_alv_grid
                       IMPORTING e_row e_column es_row_no,
*        on_hotspot FOR EVENT hotspot_click
*                          OF cl_gui_alv_grid
*                   IMPORTING e_row_id e_column_id es_row_no,
        on_toolbar FOR EVENT toolbar
                          OF cl_gui_alv_grid
                   IMPORTING e_object,
        on_user_command FOR EVENT user_command
                          OF cl_gui_alv_grid
                   IMPORTING e_ucomm,
        on_button_click FOR EVENT button_click
                               OF cl_gui_alv_grid
                        IMPORTING es_col_id es_row_no,
        on_context_menu_request FOR EVENT context_menu_request
                                       OF cl_gui_alv_grid
                                IMPORTING E_object,
        on_before_user_com FOR EVENT before_user_command
                                       OF cl_gui_alv_grid
                                IMPORTING e_ucomm.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION. "이벤트가 어떤 역할을 하냐

  METHOD on_before_user_com.
    CASE e_ucomm.
      WHEN cl_gui_alv_grid=>mc_fc_detail.  "기존 툴발의 버튼이름
      CALL METHOD go_alv_grid->set_user_command
        EXPORTING
          i_ucomm = 'SCHE'.  "function code
    ENDCASE.
  ENDMETHOD.

  METHOD on_context_menu_request.

    DATA: lv_col_id TYPE lvc_s_col,
          lv_row_id TYPE lvc_s_row.

    CALL METHOD go_alv_grid->get_current_cell
      IMPORTING
*        e_row     =
*        e_value   =
*        e_col     =
        es_row_id = lv_row_id
        es_col_id = lv_col_id.

    IF lv_col_id-fieldname = 'CARRID'.


*CALL METHOD cl_ctmenu=>load_gui_status "cl_ctmenu안에 있는 load_gui_status를 가져온다.
*  EXPORTING
*    program    = sy-cprog
*    status     = 'CT_MENU'
**    disable    =
*    menu       = e_object
*  EXCEPTIONS
*    read_error = 1
*    OTHERS     = 2.
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

CALL METHOD e_object->add_separator.

CALL METHOD e_object->add_function
  EXPORTING
    fcode             = 'DIS_CARR'
    text              = 'Display Airline'
*    icon              =
*    ftype             =
*    disabled          =
*    hidden            =
*    checked           =
*    accelerator       =
*    insert_at_the_top = SPACE
    .
    ENDIF.
  ENDMETHOD.


  METHOD on_button_click.
    READ TABLE gt_flt INTO gs_flt
         INDEX es_row_no-row_id.



    IF ( gs_flt-seatsmax_B NE gs_flt-seatsocc_B ) OR
        "이코노미 총 좌석수와 예약된 좌석수가 같지 않거나" 혹은 "이코노미 예약가능 좌석이 남았는지 "
       ( gs_flt-seatsmax_F NE gs_flt-seatsocc_f ).
        "1등석 총 좌석수와 예약된 좌석 수가 같지않거나" 혹은 "1등석에 예약가능 좌석이 남았는지"

      MESSAGE i000(zt03_msg) WITH '다른 등급의 좌석을 예약하세요!'.
    ELSE.
      MESSAGE i000(zt03_msg) WITH '모든 좌석이 예약이 된 상태입니다!'.
    ENDIF.

  ENDMETHOD.

  METHOD on_user_command.
    DATA : lv_occp TYPE i, "전체 occpy들어감
               lv_capa TYPE i,  "누적된 capa 들어감
               lv_perct TYPE p LENGTH 8 DECIMALS 1, "결과값
               lv_text(20).

    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows TYPE lvc_s_roid,
           lv_row_id TYPE lvc_s_row,
           lv_col_id TYPE lvc_s_col.

    CASE e_ucomm.

      "첫번째 버튼
      WHEN 'PERCENTAGE'.
        LOOP AT gt_flt INTO gs_flt.
          lv_occp = lv_occp + gs_flt-seatsocc.
          lv_capa = lv_capa + gs_flt-seatsmax.
        ENDLOOP.

        lv_perct = lv_occp / lv_capa * 100.
        lv_text = lv_perct.
        CONDENSE lv_text.

        MESSAGE i000(zt03_msg) WITH 'Percentage of occupied seats: ' lv_text '%'.

      "두번째 버튼: 내가 선택한 부분의 퍼센테이지 보여주기
      WHEN 'PERCENTAGE_MARKED'.

        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*            et_index_rows =
            et_row_no = lt_rows.

        IF lines( lt_rows ) > 0.  "lt_rows의 라인개수를 알려준다. 라인이 하나이상 선택될 때 아래 루프문을 돈다.
          LOOP AT lt_rows INTO ls_rows. "현재의 위치를 알려주고

              READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id. "table 정보 읽기
              IF sy-subrc EQ 0.
                lv_occp = lv_occp + gs_flt-seatsocc.
                lv_capa = lv_capa + gs_flt-seatsmax.
              ENDIF.
          ENDLOOP.

          lv_perct = lv_occp / lv_capa * 100.
          lv_text = lv_perct.
          CONDENSE lv_text.
          MESSAGE i000(zt03_msg) WITH 'Percentage of Marked occupied seats: ' lv_text '%'.
        ELSE.
          MESSAGE i000(zt03_msg) WITH 'Please select at least one line!'.
        ENDIF.

      "세번째 버튼
      WHEN  'FULLNAME'.
        CALL METHOD go_alv_grid->get_current_cell  "현재 내가 선택한 정보를 가져와라
          IMPORTING
*            e_row     =
*            e_value   =
*            e_col     =
            es_row_id = lv_row_id
            es_col_id = lv_col_id.

       IF lv_col_id-fieldname = 'CARRID'.
        READ TABLE gt_flt INTO gs_flt INDEX lv_row_id-index.

         IF sy-subrc EQ 0.
           SELECT SINGLE carrname
             INTO lv_text
             FROM scarr
            WHERE carrid = gs_flt-carrid.

             IF sy-subrc EQ 0.
               MESSAGE i000(zt03_msg) WITH lv_text.
             ELSE.
               MESSAGE i000(zmcsa05) WITH 'No found!'.
             ENDIF.
         ENDIF.
       ELSE."CARRID가 아닌 다른 셀을 찍었을 때
           MESSAGE i000(zmcsa05) WITH 'Select Carrid Cell!'.
           EXIT.
       ENDIF.

      "goto flight schedule report.
      WHEN 'SCHE'.
        READ TABLE gt_flt INTO gs_flt INDEX lv_row_id-index.
        IF sy-subrc EQ 0.
          SUBMIT bc405_event_d4 AND RETURN
          "submit: 다른프로그램을 call하는 기능 / 프로그램 이름치고 /
          "and return: 결과를 보고 프로그램으로 돌아와라
                WITH so_car EQ gs_flt-carrid  "with 다음은 select option조건을 주고 돌리겠다.
                WITH so_con EQ gs_flt-connid.
        ENDIF.
    ENDCASE.

  ENDMETHOD.


  METHOD on_toolbar.
    DATA : ls_button TYPE stb_button.
    ls_button-function = 'PERCENTAGE'.
*    ls_button-icon = ? "버튼 타입
    ls_button-quickinfo = 'Percentage'.
    ls_button-butn_type = '0'.  "normal button
    ls_button-text = 'Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-butn_type = '3'.   "seperator
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-function = 'PERCENTAGE_MARKED'.
*    ls_button-icon = ? "버튼 타입
    ls_button-quickinfo = 'Occupied Marked Percentage'.
    ls_button-butn_type = '0'.  "normal button
    ls_button-text = 'Marked Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-butn_type = '3'.   "seperator
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR : ls_button.
    ls_button-function = 'DIS_CARR'.
    ls_button-quickinfo = 'Airline Name'.
    ls_button-butn_type = '0'.
*    ls_button-text = ''.
    ls_button-icon = icon_ws_plane.  "비행기 아이콘
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

  ENDMETHOD.



*  METHOD on_hotspot.
*    DATA carr_name TYPE scarr-carrname.
*
*    CASE e_column_id-fieldname.
*      WHEN 'CARRID'.
*          READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
*          IF sy-subrc EQ 0.
*            SELECT SINGLE carrname
*              INTO carr_name
*              FROM scarr
*             WHERE carrid = gs_flt-carrid.
*             IF sy-subrc EQ 0.
*               MESSAGE i000(zt03_msg) WITH carr_name.
*             ELSE.
*               MESSAGE i000(zt03_msg) WITH 'No found!'.
*             ENDIF.
*         ELSE.
*           MESSAGE i075(bc405_408).
*           EXIT.
*         ENDIF.
*
*    ENDCASE.
* ENDMETHOD.

  METHOD on_doubleclick.
    DATA : total_occ TYPE i,"값을 선언할 공간
           total_occ_c TYPE c LENGTH 10.

    CASE e_column-fieldname.
      WHEN 'CHANGES_POSSIBLE'.


      READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id."더블클릭한 위치를 알려줌
      IF sy-subrc EQ 0.
         total_occ = gs_flt-seatsocc +
                     gs_flt-seatsocc_b +
                     gs_flt-seatsocc_f.
         total_occ_c = total_occ.
         CONDENSE total_occ_c. "condense: 정렬해서 caracter처럼 왼쪽으로 가게해라
         MESSAGE i000(zt03_msg) WITH 'Total number of boiokings:'
                           total_occ_c.
      ELSE.
        MESSAGE i075(bc405_408).
        EXIT.
      ENDIF.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
