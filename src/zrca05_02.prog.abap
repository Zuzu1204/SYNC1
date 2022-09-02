*&---------------------------------------------------------------------*
*& Report ZRCA05_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca05_02.
*문제)
*1단계
*	이전 프로그램의 IF문을 CASE 문으로, CASE 문을 IF 문으로 변경
*
*2단계
*	구구단 (반드시 1~3 순서대로 진행)
*	Program: ZRCA##_BC100
*
*	1. 구구단(Times Table) 출력하시오. 9단까지
*   1단  1  2  3  4 ….. 9
*   2단  2  4  6  8 ….. 18
*   3단  3  6  9  12 ……. 27
*   …..
*	2. 단계를 입력하면 해당 단계까지만 출력
*	 예) 5을 입력하면, 5단까지만 출력
*	3. 단게와 학년을 입력
*   1) 1학년은 최대 3단까지만 출력
*   2) 2학년은 최대 5단까지만 출력
*   3) 3학년은 최대 7단까지만 출력
*   4) 4학년 이상은 최대 9단까지 출력
*   5) 6학년은 입력한 단계에 상관없이 9까지 모두 출력




DATA gv_step TYPE i.
DATA gv_cal TYPE i.
DATA gv_count TYPE i.
PARAMETERS pa_table TYPE i.
PARAMETERS pa_syear(1) TYPE c.
DATA gv_new_lev LIKE gv_count.

CASE pa_syear.
  WHEN '1' OR '2' OR '3' OR '4' OR '5' OR '6'.

    IF pa_table >= 3.
     gv_new_lev = 3.
    ELSE.
     gv_new_lev = pa_table.
     ENDIF.
ENDCASE.



DO gv_new_lev TIMES.
      gv_count = gv_count + 1.

  DO 9 TIMES.
    gv_step = gv_step + 1.
    CLEAR gv_cal.
     gv_cal = gv_count * gv_step.
     WRITE: gv_count, ' * ', gv_step, ' = ', gv_cal.
     NEW-LINE.

ENDDO.
CLEAR gv_step.
WRITE '=============================================================='.
NEW-LINE.


  ENDDO.
