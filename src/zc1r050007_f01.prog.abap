*&---------------------------------------------------------------------*
*& Include          ZC1R050007_F01
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

  SELECT pernr ename entdt gender depcd carrid gtext
    FROM ztsa0501
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE pernr IN so_pern.

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
*  gs_layout-cwidth_opt = 'X'.

  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
    'X'   'PERNR'      ' '   'ZTSA0501'   'PERNR'      'X'   10,
    ' '   'ENAME'      ' '   'ZTSA0501'   'ENAME'      'X'   20,
    ' '   'ENTDT'      ' '   'ZTSA0501'   'ENTDT'      'X'   10,
    ' '   'GENDER'     ' '   'ZTSA0501'   'GENDER'     'X'   5,
    ' '   'DEPCD'      ' '   'ZTSA0501'   'DEPCD'      'X'   8,
    ' '   'CARRID'     ' '   'ZTSA0501'   'CARRID'     'X'   10,
    ' '   'CARRNAME'   ' '   'SCARR'      'CARRNAME'   ' '   20,
    ' '   'GTEXT'      ' '   'ZTSA0501'   'GTEXT'      'X'   10.
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
FORM set_fcat  USING pv_key
                     pv_fname
                     pv_text
                     pv_ref_t
                     pv_ref_f
                     pv_edit
                     pv_length.

  CLEAR gs_fcat.

  gs_fcat-key = pv_key.
  gs_fcat-fieldname = pv_fname.
  gs_fcat-coltext = pv_text.
  gs_fcat-ref_table = pv_ref_t.
  gs_fcat-ref_field = pv_ref_f.
  gs_fcat-edit = pv_edit.
  gs_fcat-outputlen = pv_length.

  APPEND gs_fcat TO gt_fcat.

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
        side      = gcl_container->dock_at_left
        extension = 3000.


    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    SET HANDLER : lcl_event_handler=>handle_data_changed FOR gcl_grid,
                  lcl_event_handler=>handle_changed_finished FOR gcl_grid.

    CALL METHOD gcl_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.


    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_Fcat.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_row .

  CLEAR gs_data.

  APPEND gs_data TO gt_data.

  PERFORM refresh_grid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid .

  gs_stable-row = 'x'.
  gs_stable-col = 'X'.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_stable
      i_soft_refresh = space.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_emp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_emp .

  DATA : lt_save  TYPE TABLE OF ztsa0501,
         lt_del   TYPE TABLE OF ztsa0501,
         lv_error.

  REFRESH lt_save.

  CALL METHOD gcl_grid->check_changed_data. "ALV의 입력된 값을 ITAB으로 반영시킴, 이때 itab으로 데이터가 들어감

  CLEAR lv_error.  "필수 입력값 입력 여부 체크
  LOOP AT gt_data INTO gs_data.

    IF gs_data-pernr IS INITIAL.
      MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
      lv_error = 'X'.   "에러발생 했을 경우 저장 플로우 수행방지 위해서 값을 세팅
      EXIT.             "현재 수행중인 루틴을 빠져나감 : 지금은 LOOP를 빠져나감
    ENDIF.

    lt_save = VALUE #( BASE lt_save  "에러 없는 데이터는 저장할 ITAB에 데이터 저장
                        (
                          pernr  = gs_data-pernr
                          ename  = gs_data-ename
                          entdt  = gs_data-entdt
                          gender = gs_data-gender
                          depcd  = gs_data-depcd
                          carrid = gs_data-carrid
                          gtext  = gs_data-gtext
                         )
                       ).

  ENDLOOP.

*  CHECK lv_error IS INITIAL.   "에러가 없었으면 아래 로직 수행
  IF lv_error IS NOT INITIAL. "에러가 있었으면 현재 루틴 빠져나감.
    EXIT.
  ENDIF.

  IF gt_data_del IS NOT INITIAL.

    LOOP AT gt_data_del INTO DATA(ls_del).

      lt_del = VALUE #( BASE lt_del
                        ( pernr = ls_del-pernr )
                       ).
    ENDLOOP.

    DELETE ztsa0501 FROM TABLE lt_del.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
    ENDIF.

  ENDIF.


  IF lt_save IS NOT INITIAL.

    MODIFY ztsa0501 FROM TABLE lt_save.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE s002.  "DATA 저장 성공 메시지
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form delete_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_row.

  REFRESH gt_rows.

  CALL METHOD gcl_grid->get_selected_rows
    IMPORTING
      et_index_rows = gt_rows.

  IF gt_rows IS INITIAL.  "행을 선택했는지 체크
    MESSAGE s000 WITH TEXT-e02 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

*  LOOP AT gt_rows into gs_row.
*
*    READ TABLE gt_data into gs_data INDEX gs_row-index.
*
*    IF sy-subrc eq 0.
*      gs_data-mark = 'X'.
*
*      modify gt_data from gs_data INDEX gs_row-index
*      TRANSPORTING mark.
*    ENDIF.
*
*  ENDLOOP.

*  delete gt_data where mark = 'X'.
*  delete gt_data where mark is NOT INITIAL.


  SORT gt_rows BY index DESCENDING.

  LOOP AT gt_rows INTO gs_row.
*ITAB에서 삭제 하기 전에 DB Table에서도 삭제해야 하므로
*삭제 대상을 따로 보관
    READ TABLE gt_data INTO gs_data INDEX gs_row-index.

    IF sy-subrc EQ 0.

      APPEND gs_data TO gt_data_del. "삭제대상을 삭제 ITAB에 보관

    ENDIF.

    DELETE gt_data INDEX gs_row-index.   "사용자가 선택한 행을 직접 삭제

  ENDLOOP.

  PERFORM refresh_grid.   "변경된 itab을 alv에 반영

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_style
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_style .

  DATA : lv_tabix TYPE sy-tabix,
         ls_style TYPE lvc_s_styl,
         lt_style TYPE lvc_t_styl.

*  ls_style-fieldname = 'PERNR'. "구문법
*  ls_style-style     = cl_gui_alv_grid=>mc_style_disabled.
*  APPEND ls_style TO lt_style.

*  ls_style = VALUE #( fieldname = 'PERNR'  "신문법 : 스트럭쳐 사용시
*                      style     = cl_gui_alv_grid=>mc_style_disabled ).

*  APPEND ls_style TO lt_style.

*  신문법 : 인터널 테이블만 사용시
  lt_style = VALUE #(
                      (
                        fieldname = 'PERNR'
                        style     = cl_gui_alv_grid=>mc_style_disabled
                      )
                    ).

* Table에서 가지고 온 데이터의 PK는 변경 방지 위해서 편집금지모드로
  LOOP AT gt_data INTO gs_data.
    lv_tabix = sy-tabix.

    REFRESH gs_data-style.

    APPEND LINES OF lt_style TO gs_data-style.
*    gs_data-style = lt_style.
*    MOVE-CORRESPONDING lt_style TO gs_data-style.

    MODIFY gt_data FROM gs_data INDEX lv_tabix
    TRANSPORTING style.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_data_changed
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM handle_data_changed USING pcl_data_changed TYPE REF TO
                               cl_alv_changed_data_protocol.

  LOOP AT pcl_data_changed->mt_mod_cells INTO DATA(ls_modi).

    read table gt_data into gs_data INDEX ls_modi-row_id.

    IF sy-subrc ne 0.
      CONTINUE.
    ENDIF.

    SELECT single carrname
      from scarr
      into gs_data-carrname
     where carrid = ls_modi-value.  "New Value

    IF sy-subrc eq 0.
      MODIFY gt_data from gs_data index ls_modi-row_id
      TRANSPORTING carrname.
    ENDIF.

  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_changed_finished
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_MODIFIED
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM handle_changed_finished  USING pv_modified
                                    pt_good_cells TYPE lvc_t_modi.
*  DATA : ls_modi TYPE lvc_s_modi.

  LOOP AT pt_good_cells INTO DATA(ls_modi).



  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data_data .

  CLEAR   gs_data.
  REFRESH gt_data.

  SELECT pernr ename entdt gender depcd carrid gtext
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztsa0501
   WHERE pernr IN so_pern.

ENDFORM.
