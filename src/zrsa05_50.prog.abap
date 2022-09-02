*&---------------------------------------------------------------------*
*& Report ZRSA05_50
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_50_top                           .    " Global Data

 INCLUDE zrsa05_50_o01                           .  " PBO-Modules
 INCLUDE zrsa05_50_i01                           .  " PAI-Modules
 INCLUDE zrsa05_50_f01                           .  " FORM-Routines

 INITIALIZATION. "여기서 시작
" initialization은 여기서 끝남
     "기본값 설정
     PERFORM set_init.

 AT SELECTION-SCREEN OUTPUT. "PBO
   message s000(zmcsa05) with 'PBO'.

 AT SELECTION-SCREEN. "PAI

  START-OF-SELECTION.

   SELECT SINGLE *
     FROM sflight
*     INTO sflight
     WHERE carrid = pa_car
     AND connid = pa_con
     AND fldate IN so_dat. "internal table 자리, []가 생략된 것.


   CALL SCREEN 100.
   message s000(zmcsa05) with 'After call screen'.
