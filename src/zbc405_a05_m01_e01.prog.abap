*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_M01_E01
*&---------------------------------------------------------------------*

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN. "PAI

START-OF-SELECTION. "at selection-screen까지가 실행되고 사라진 후에 start of selection이 시작

 SELECT *
   FROM ztsbook_A05
   INTO CORRESPONDING FIELDS OF TABLE gt_sbook
  WHERE carrid IN pa_car
    AND connid IN pa_con.
   "앞에는 database의 필드명

LOOP AT gt_sbook INTO gs_sbook.
  "gsbook을 바꾸는 로직

  "LOWCOLOR
  "~~일때는 CASE문
  CASE gs_sbook-invoice.
    WHEN 'X'.  "when을 등호라고 생각
      gs_sbook-ROWCOL = 'C510'.
      gs_sbook-ROWCOL2 = 'C510'.
  ENDCASE.

  "EXCEPTION 신호등
  "범위지정은 IF문!
  IF gs_sbook-luggweight >= 25.
    gs_sbook-light = 1.
    gs_sbook-rowcol = 'C610'.
  ELSEIF gs_sbook-luggweight >= 15.
    gs_sbook-light = 2.
  ELSE.
    gs_sbook-light = 3.
  ENDIF.

MODIFY gt_sbook FROM gs_sbook.
CLEAR gs_sbook.
ENDLOOP.
  CALL SCREEN 100.
