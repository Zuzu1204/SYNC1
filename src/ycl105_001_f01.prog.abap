*&---------------------------------------------------------------------*
*& Include          YCL105_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*

FORM select_data .

  REFRESH gt_scarr.

*  CLEAR gt_scarr. "헤더라인이 있으면 헤더라인이 지워지고 헤더라인이 없으면 internal table이 지워짐

  SELECT *
    FROM scarr
    INTO TABLE @gt_scarr
   WHERE carrid   IN @s_carrid
     AND carrname IN @s_carrnm.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_object_
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form create_object_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object_0100 .

  CREATE OBJECT gr_con
    EXPORTING
      repid                       = sy-repid                 " Report to Which This Docking Control is Linked
      dynnr                       = sy-dynnr                 " Screen to Which This Docking Control is Linked
      extension                   = 2000               " Control Extension
    EXCEPTIONS
      cntl_error                  = 1                " Invalid Parent Control
      cntl_system_error           = 2                " System Error
      create_error                = 3                " Create Error
      lifetime_error              = 4                " Lifetime Error
      lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
      OTHERS                      = 6.


  CREATE OBJECT gr_split
    EXPORTING
      parent            = gr_con              " Parent Container
      rows              = 2                   " Number of Rows to be displayed
      columns           = 1                  " Number of Columns to be Displayed
    EXCEPTIONS
      cntl_error        = 1                  " See Superclass
      cntl_system_error = 2                  " See Superclass
      OTHERS            = 3.

*  call METHOD gr_split->get_container
*    EXPORTING
*      row       =  1                " Row
*      column    =  1                " Column
*    RECEIVING
*      container = gr_con_top              " Container
*    .
*
*
*
*  gr_split->get_container(
*    EXPORTING
*      row       = 1                 " Row
*      column    = 1                " Column
**    RECEIVING
**      container =                  " Container
*  ).
  gr_con_top = GR_split->get_container( row = 1 column = 1 ).
  gr_con_alv = gr_split->get_container( row = 2 column = 1 ).

**  첫번째 방법
*  gr_alv = new cl_gui_alv_grid(
**    i_shellstyle            = 0
**    i_lifetime              =
*    i_parent                =
**    i_appl_events           = space
**    i_parentdbg             =
**    i_applogparent          =
**    i_graphicsparent        =
**    i_name                  =
**    i_fcat_complete         = space
**    o_previous_sral_handler =
*  )

*  두번째방법 : create object쓰고 ctrl space
  CREATE OBJECT gr_alv
    EXPORTING
      i_parent          = gr_con_alv                " Parent Container
    EXCEPTIONS
      error_cntl_create = 1                " Error when creating the control
      error_cntl_init   = 2                " Error While Initializing Control
      error_cntl_link   = 3                " Error While Linking Control
      error_dp_create   = 4                " Error While Creating DataProvider Control
      OTHERS            = 5.

** 세번째 방법
*  gr_alv = new cl_gui_alv_grid( i_parent = gr_con_alv ).
*  gr_alv = new #( i_parent = gr_con_alv ).
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

  gs_layout-zebra      = ABAP_on.        "조금더 상징적인 의미
  gs_layout-sel_mode   = 'D'.         " A: 행열, B: 단일행, C: 복수행, D: 셀단위
  gs_layout-cwidth_opt = abap_on.   "출력할 데이터가 많으면 안쓰는게 좋다.

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

  CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid      " Internal table declaration program
*     i_tabname              = 'GS_SCARR'    " 항상 구조체가 들어가야됨  " 내가 선언한 구조체에서 필드정보를 가져옴
      i_strucname            = 'SCARR'
      i_inclname             = sy-repid
      i_bypassing_buffer     = abap_on       " Ignore buffer while reading
      i_buffer_active        = abap_off
    CHANGING
      ct_fieldcat            = lt_fcat   " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      OTHERS                 = 2.

  IF lt_fcat[] IS INITIAL.
    MESSAGE '필드 카탈로그 구성 중 오류가 발생했습니다.' TYPE 'E'.
  ELSE.
    CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_kkblo = lt_fcat
      IMPORTING
        et_fieldcat_lvc   = gt_fcat.

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
      is_layout                     = gs_layout                 " Layout
    CHANGING
      it_outtab                     = gt_scarr[]                " Output Table
      it_fieldcatalog               = gt_fcat[]                 " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1                " Wrong Parameter
      program_error                 = 2                " Program Errors
      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
      OTHERS                        = 4.

ENDFORM.
