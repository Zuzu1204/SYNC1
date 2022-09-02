*&---------------------------------------------------------------------*
*& Include          ZRSA05_23_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_info .
  CLEAR gt_info.
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_car
    AND connid = pa_con.

CLEAR gs_info.
LOOP AT gt_info INTO gs_info.
  "Get Airline Name
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
   WHERE carrid = gs_info-carrid.

"Get Connection Info
 SELECT SINGLE cityfrom cityto
   FROM spfli
*   into CORRESPONDING FIELDS OF gs_info
   INTO ( gs_info-cityfrom, gs_info-cityto ) "순서가 중요
  WHERE carrid = gs_info-carrid
    AND connid = gs_info-connid.

   "현재는 gs_info에만 저장된 상태, gt_info에 저장하기 위해 modify 사용
  MODIFY gt_info FROM gs_info. " index sy-tabix.
  CLEAR gs_info.
ENDLOOP.
ENDFORM.
