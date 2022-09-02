*&---------------------------------------------------------------------*
*& Report ZRSA05_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_15.

DATA: BEGIN OF gs_std,
        stdno TYPE n LENGTH 8,"숫자로 이루어 졌지만 코드성이 있을 때 = n
        sname TYPE c LENGTH 40,
        gender TYPE c LENGTH 1,
        gender_t TYPE c LENGTH 10,
      END OF gs_std.
DATA gt_std LIKE TABLE OF gs_std.
"structure table에 'like table of'를 사용하여 1건이 아닌 table형태로 되는것 = internal table
"internal table의 initial value는 아무것도 없는 상태이다.
gs_std-stdno = '20220001'.
gs_std-sname = 'KANG'.
gs_std-gender = 'M'.
APPEND gs_std TO gt_std.  "gs_std에 있는 값을 gt_std에 추가

CLEAR gs_std.
gs_std-stdno = '20220002'.
gs_std-sname = 'HAN'.  "- 앞은 structure 변수만 온다.
gs_std-gender = 'F'.
APPEND gs_std TO gt_std.
CLEAR gs_std.

LOOP AT gt_std INTO gs_std.
  gs_std-gender_t = 'Male'(t01).
  MODIFY gt_std FROM gs_std. " INDEX sy-tabix. "gs_std를 가지고 gt_std를 변경하세요
  CLEAR gs_std. "clear 쓰는 게 습관이 되어야함
ENDLOOP.


cl_demo_output=>display_data( gt_std ). "이러한 문법을 class라고 한다.

CLEAR gs_std.

READ TABLE gt_std WITH KEY stdno = '20200001'
INTO gs_std.


*LOOP AT gt_std INTO gs_std.
*  WRITE: sy-tabix, gs_std-stdno,
*         gs_std-sname, gs_std-gender.
*  NEW-LINE.
*  CLEAR gs_std.
*ENDLOOP.
