*&---------------------------------------------------------------------*
*& Report ZBC405_OM_A05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_om_a05.
TABLES : spfli.

SELECT-OPTIONS : so_car FOR spfli-carrid MEMORY ID car,
                 so_con FOR spfli-connid MEMORY ID con.

DATA: gt_spfli TYPE TABLE OF spfli,
      gs_spfli TYPE spfli.

DATA : go_alv TYPE REF TO cl_salv_table,  "cl_salv_table : 이게 메인
       go_func TYPE REF TO cl_salv_functions_list.

START-OF-SELECTION.

  SELECT *
    INTO TABLE gt_spfli "이 gt_spfli이 cl_salv_table에 얹어지는것
    FROM spfli
   WHERE carrid IN so_car
     AND connid IN so_con.

  TRY.  "클래스를 쓸 때 자동으로 딸려오는데 풀어서 사용하는게 좋다 => 의도치 않은 덤프 방지용
  CALL METHOD cl_salv_table=>factory
    EXPORTING  "화면을 어떻게 보이는지 모양
      list_display   = ' '
*      r_container    =
*      container_name =
    IMPORTING
      r_salv_table   = go_alv
    CHANGING
      t_table        = gt_spfli.
      .
    CATCH cx_salv_msg.
  ENDTRY.



*현재 상태의 이름을 내뱉어 주는게 전부class다. 현재버튼의 상태를 알려주는거 get functions
"get_functions을 통해 아무것도 없는 상태에서 이제 go_func에 하나씩 얹어주자
CALL METHOD go_alv->get_functions
  RECEIVING
    value  = go_func.
*
*CALL METHOD xxxxxxxx->set_filter
**  EXPORTING
**    value  = IF_SALV_C_BOOL_SAP=>TRUE
*    .

CALL METHOD go_func->set_sort_asc
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .

CALL METHOD go_func->set_sort_desc
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .

*all button을 넣고 싶을 때
CALL METHOD go_func->set_all.

CALL METHOD go_alv->display.  "내가 만든 instance를 넣는다.
