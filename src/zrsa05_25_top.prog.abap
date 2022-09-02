*&---------------------------------------------------------------------*
*& Include ZRSA05_25_TOP                            - Report ZRSA05_25
*&---------------------------------------------------------------------*
REPORT zrsa05_25. "이 프로그램에서 사용한 global 변수를 여기서 지정

* Type 선언
*TYPES: BEGIN OF ts_info,"structure type일 때는 ts
*          carrid TYPE sflight-carrid,  "필드명은 똑같이 써주는게 좋음
*          connid TYPE sflight-connid,
*          cityfrom TYPE spfli-cityfrom,
*          cityto TYPE spfli-cityto,
*          fldate TYPE sflight-fldate,
*       END OF ts_info,
*       tt_info TYPE TABLE OF ts_info. "ts_info(table type)을

* data Object
DATA: gt_info TYPE TABLE OF zssa0502,
      gs_info LIKE LINE OF gt_info.

* Selection Screen
PARAMETERS: pa_car TYPE sflight-carrid,
            pa_con1 TYPE sflight-connid,
            pa_con2 TYPE sflight-connid.  "변수명이 다르기 때문에 같은 type써도 상관없음
