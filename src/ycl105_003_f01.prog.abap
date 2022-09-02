*&---------------------------------------------------------------------*
*& Include          YCL105_002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form refresh_grid_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid_0100 .

  CHECK gr_alv IS BOUND.

  DATA ls_stable TYPE lvc_s_stbl.
  ls_stable-row = abap_off.
  ls_stable-col = abap_on.

  CALL METHOD gr_alv->refresh_table_display
    EXPORTING
      is_stable      = ls_stable
      i_soft_refresh = space "space : 설정된 필터나 정렬정보를 초기화 / X : 설정된 필터나 정렬을 유지
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_object_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object_0100 .
  "컨테이너 객체를 연결하자

  gr_con = NEW cl_gui_custom_container(
    container_name = 'MY_CONTAINER'
    ).

  gr_alv = NEW cl_gui_alv_grid(
    i_parent = gr_con
    ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM select_data .

  REFRESH gt_scarr.

  RANGES lr_carrid   FOR scarr-carrid.
  RANGES lr_carrname FOR scarr-carrname.


  IF scarr-carrid IS INITIAL AND
     scarr-carrname IS INITIAL.
    " ID 와 이름이 둘다 공란인 경우

  ELSEIF scarr-carrid IS INITIAL.
    " 이름은 공란이 아닌 경우
    lr_carrname-sign = 'I'.
    lr_carrname-option = 'EQ'.      " eq = 같음
    lr_carrname-low = scarr-carrname.
    APPEND lr_carrname.
    CLEAR  lr_carrname.
  ELSEIF scarr-carrname IS INITIAL.
    " ID 가 공란이 아닌 경우
    lr_carrid-sign = 'I'.     " I / E : Include / Exclude : 포함 / 제외
    lr_carrid-option = 'EQ'.
    lr_carrid-low = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrid.
  ELSE.
    " ID와 이름이 둘다 공란이 아닌 경우
    " 이름은 공란이 아닌 경우
    lr_carrname-sign = 'I'.
    lr_carrname-option = 'EQ'.      " eq = 같음
    lr_carrname-low = scarr-carrname.
    APPEND lr_carrname.
    CLEAR  lr_carrname.

    " ID 가 공란이 아닌 경우
    lr_carrid-sign = 'I'.     " I / E : Include / Exclude : 포함 / 제외
    lr_carrid-option = 'EQ'.
    lr_carrid-low = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrid.
  ENDIF.

*  SELECT *
*    FROM scarr
*   WHERE carrid   IN @lr_carrid
*     AND carrname IN @lr_carrname
*    INTO TABLE @gt_scarr.

  SELECT *
    FROM scarr
   WHERE carrid   IN @s_carrid
     AND carrname IN @s_carrnm
    INTO TABLE @gt_scarr.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_layout_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_layout_0100 .

  CLEAR gs_layout.

  gs_layout-zebra = abap_on.
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = abap_on.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_fieldcat_0100 .

  DATA lt_fcat TYPE kkblo_t_fieldcat.

  REFRESH gt_fcat.

  CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid        " Internal table declaration program
*     i_tabname              =                 " Name of table to be displayed
      i_strucname            = 'SCARR'
      i_inclname             = sy-repid
      i_bypassing_buffer     = abap_on         " Ignore buffer while reading
      i_buffer_active        = abap_off
    CHANGING
      ct_fieldcat            = Lt_fcat     " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      OTHERS                 = 2.

  IF lt_fcat[] IS INITIAL.
    MESSAGE 'ALV 필드 카탈로그 구성이 실패했습니다.' TYPE 'E'.
  ELSE.
    CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_KKBLO = Lt_fcat
      IMPORTING
        et_fieldcat_LVC   = gt_fcat
      EXCEPTIONS
        it_data_missing   = 1
        OTHERS            = 2.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_0100 .

  CALL METHOD gr_alv->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout
    CHANGING
      it_outtab                     = gt_scarr[]
      it_fieldcatalog               = gt_fcat[]
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
ENDFORM.
