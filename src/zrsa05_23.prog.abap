*&---------------------------------------------------------------------*
*& Report ZRSA05_23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_23_top                           .    " Global Data

* INCLUDE ZRSA05_23_O01                           .  " PBO-Modules
* INCLUDE ZRSA05_23_I01                           .  " PAI-Modules
 INCLUDE zrsa05_23_f01                           .  " FORM-Routines

* Event (다른 event를 만나면 끝난다.)
INITIALIZATION. "Runtime에 딱 한번 실행
  IF sy-uname = 'KD-T-06'.
    pa_car = 'AA'.
    pa_con = '0017'.
  ENDIF.


AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN. "PAI
  IF pa_con IS INITIAL.
    message s016(pn) with 'check'.
  ENDIF.

START-OF-SELECTION.
 write 'Test'.

PERFORM get_info.


IF gt_info IS INITIAL.
  "S, I, E, W, A, X
  MESSAGE i016(pn) WITH 'Data is not found'.  "pn에 있는 16번으로 message를 꾸려줘.
ENDIF.
cl_demo_output=>display_data( gt_info ).

*"값이 비어있지 않으면 출력해라
*if gt_info is not initial.
*    cl_demo_output=>display_data( gt_info ).
*else.
*endif.
