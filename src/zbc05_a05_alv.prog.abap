*&---------------------------------------------------------------------*
*& Report ZBC05_A05_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc05_a05_alv.

TYPES: BEGIN OF typ_flt.
  INCLUDE TYPE sflight.
TYPES: changes_possible TYPE icon-id.
TYPES : btn_text TYPE c LENGTH 10.
TYPES: light TYPE c LENGTH 1.
TYPES: row_color TYPE c LENGTH 4.
TYPES: it_color TYPE lvc_t_scol.
TYPES : it_styl TYPE lvc_t_styl.   "셀의 스타일을 정의하는 타입지정
TYPES: END OF typ_flt.


DATA gt_flt TYPE TABLE OF typ_flt.  "sflight
DATA gs_flt TYPE typ_flt.
DATA ok_code LIKE sy-ucomm.

*alv data 선언
DATA: go_container TYPE REF TO cl_gui_custom_container, "container을 위함
      go_alv_grid TYPE REF TO cl_gui_alv_grid, "ALV를 위함
      gv_variant TYPE disvariant,
      gv_save TYPE c LENGTH 1,
      gs_layout TYPE lvc_s_layo,
      gt_sort TYPE lvc_t_sort,"internal table
      gs_sort TYPE lvc_s_sort, "table을 넣기위한 work area
      gs_color TYPE lvc_s_scol,
      gt_exct TYPE ui_functions,
      gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat,
      gs_styl TYPE lvc_s_styl.

DATA : gs_stable TYPE lvc_s_stbl,
       gv_soft_refresh TYPE abap_bool.

INCLUDE ZBC05_A05_ALV_class. "위의 변수들도 써야하기 때문에 위치가 중요

*selection-screen

SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                 so_con FOR gs_flt-connid MEMORY ID con,
                 so_dat FOR gs_flt-fldate.

SELECTION-SCREEN SKIP 1.

PARAMETERS : p_date TYPE sy-datum DEFAULT '20201001'.
PARAMETERS : pa_lv TYPE disvariant-variant.



"이벤트 시작
AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.  "pa_lv변수를 위한 f4버튼

gv_variant-report = sy-cprog.  "많은 프로그램 가운데 현재프로그램임을 나타냄, key값을 주는 것과 유사

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
   EXPORTING
     i_save_load                 = 'F'  "S, F: possible로 보여줌, L
    CHANGING
      cs_variant                  = gv_variant
   EXCEPTIONS
     not_found                   = 1
     wrong_input                 = 2
     fc_not_complete             = 3
     OTHERS                      = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here

  ELSE.
    pa_lv = gv_variant-variant.
  ENDIF.
"이벤트 끝

*INITIALIZATION.

"메인프로그램 시작
START-OF-SELECTION.

PERFORM get_data.




  CALL SCREEN 100.

INCLUDE zbc05_a05_alv_status_0100o01.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      CALL METHOD go_alv_grid->free.
      CALL METHOD go_container->free.

      FREE : go_alv_grid, go_container.
      LEAVE TO SCREEN 0.
   ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.

  IF go_container IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'MY_CONTROL_AREA'
      EXCEPTIONS
        OTHERS                      = 6
        .
    IF sy-subrc <> 0.

    ENDIF.


CREATE OBJECT go_alv_grid
  EXPORTING
    i_parent          = go_container
  EXCEPTIONS
    OTHERS            = 5.
IF sy-subrc <> 0.
ENDIF.


PERFORM make_variant.
PERFORM make_layout.
PERFORM make_sort.
PERFORM make_fieldcatalog.

APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct. "=> : attribute를 직접 참조한다 라는 뜻
APPEND cl_gui_alv_grid=>mc_fc_info TO gt_exct.

*APPEND cl_gui_alv_grid=>mc_fc_excl_all TO gt_exct.


"핸들러를 트리거해주는 명령어가 있다.
"set handler라는 말이 이벤트를 할수 있게 해준다.
SET HANDLER lcl_handler=>on_doubleclick FOR go_alv_grid.
*SET HANDLER lcl_handler=>on_hotspot FOR go_alv_grid.
SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
SET HANDLER lcl_handler=>on_button_click FOR go_alv_grid.
SET HANDLER lcl_handler=>on_context_menu_request FOR go_alv_grid.
SET HANDLER lcl_handler=>on_before_user_com FOR go_alv_grid.

CALL METHOD go_alv_grid->set_table_for_first_display
  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
    i_structure_name              = 'SFLIGHT' "내가 보여줄 internal table이 참조하는건 sflight다.
    is_variant                    = gv_variant
    i_save                        = gv_save
    i_default                     = 'X'       "X, A, U
    is_layout                     = gs_layout
*    is_print                      =
*    it_special_groups             =
    it_toolbar_excluding          = gt_exct
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = gt_flt "나는 gt_flt를 보여줄거야
    it_fieldcatalog               = gt_fcat
    it_sort                       = gt_sort
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
ELSE.

*  on change of gt_flt.
  gv_soft_refresh = 'X'.
  gs_stable-row = 'X'.
  gs_stable-col = 'X'.

    CALL METHOD go_alv_grid->refresh_table_display
      EXPORTING
        is_stable      = gs_stable
        i_soft_refresh = gv_soft_refresh
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2
            .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT *
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_flt
 WHERE carrid IN so_car AND
       connid IN so_con AND
       fldate IN so_dat.



    LOOP AT gt_flt INTO gs_flt.
      IF gs_flt-seatsocc < 5.
        gs_flt-light = 1.  "red

      ELSEIF gs_flt-seatsocc < 100.
        gs_flt-light = 2. "yellow

        ELSE.
          gs_flt-light = 3. "green

      ENDIF.

      IF gs_flt-fldate+4(2) = sy-datum+4(2).
          gs_flt-row_color = 'C711'.
      ENDIF.


      IF gs_flt-planetype = '747-400'.
        gs_color-fname = 'PLANETYPE'.
        gs_color-color-col = col_total.
        gs_color-color-int = '1'.
        gs_color-color-inv = '0'.
        APPEND gs_color TO gs_flt-it_color.
      ENDIF.

      IF gs_flt-seatsocc_B = 0.
        gs_color-fname = 'SEATSOCC_B'.
        gs_color-color-col = col_negative.
        gs_color-color-int = '1'.
        gs_color-color-inv = '0'.
        APPEND gs_color TO gs_flt-it_color.
      ENDIF.

    IF gs_flt-fldate < p_date.
      gs_flt-changes_possible = icon_space.
    ELSE.
      gs_flt-changes_possible = icon_okay.

    ENDIF.


    "버튼만들기
    IF gs_flt-seatsmax_B = gs_flt-seatsocc_B.
      gs_flt-btn_text = 'FullSeats!'.  "좌석이 풀이 되면

      gs_styl-fieldname = 'BTN_TEXT'.
      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
      APPEND gs_styl TO gs_flt-it_styl.

    ENDIF.
      MODIFY gt_flt FROM gs_flt.

    ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_variant .
  gv_variant-report = sy-cprog.
  gv_variant-variant = pa_lv.
  gv_save = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout .
  gs_layout-zebra = 'X'.
  gs_layout-cwidth_opt = 'X'.
  gs_layout-sel_mode = 'D'.   "A B C D Space

  gs_layout-excp_fname = 'LIGHT'.    "exception handling field 설정
  gs_layout-excp_led = 'X'.   "하나짜리 신호등

  gs_layout-info_fname = 'ROW_COLOR'.
  gs_layout-ctab_fname = 'IT_COLOR'.

  gs_layout-stylefname = 'IT_STYL'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort .

  CLEAR gs_sort.
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.  "down = descending
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .

*  CLEAR gs_fcat.
*  gs_fcat-fieldname = 'CARRID'.
*  gs_fcat-hotspot = 'X'.
*  APPEND gs_fcat TO gt_fcat.


  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.  "coltedxt = colloum text
  APPEND gs_fcat TO gt_fcat.


  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PRICE'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-no_out = 'X'.
  gs_fcat-edit = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'CHANGES_POSSIBLE'.
  gs_fcat-coltext = 'Chang.Poss'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 5.
*  gs_fcat-icon = 'X'.
  APPEND gs_fcat TO gt_fcat.


 "버튼생성 후 뿌려주기 위해서 카탈로그에 추가
  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'BTN_TEXT'.
  gs_fcat-coltext = 'Status'.
  gs_fcat-col_pos = 12.
  APPEND gs_fcat TO gt_fcat.


ENDFORM.
