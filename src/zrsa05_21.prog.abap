*&---------------------------------------------------------------------*
*& Report ZRSA05_21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_21.

TYPES: BEGIN OF ts_info,
        carrid TYPE c LENGTH 3,
        carrname TYPE scarr-carrname,  "위아래 관련 있게 구성해야함
        connid TYPE spfli-connid,
        countryfr TYPE spfli-countryfr,
        countryto TYPE spfli-countryto,
        atype, "TYPE c LENGTH 1
        "atype_t TYPE c LENGTH 10, "atype은 코드성이기 때문에 사용자는 D,I의미를 모른다 .그래서 text를 넣어주기 위함
       END OF ts_info.
* Connection Internal Table

DATA gt_info TYPE TABLE OF ts_info. "structure type
*Structure Vawriable

DATA gs_info LIKE LINE OF gt_info.
*DATA gs_info TYPE ts_info.

*DATA: gs_info TYPE ts_info,
*      gt_info LIKE TABLE OF gs_info.
PARAMETERS pa_car TYPE spfli-carrid.

CLEAR gs_info.

*PERFORM add_info USING 'AA'
*                       '0017'
*                       'US'
*                       'US'.


SELECT carrid connid countryfr countryto "직접 써주는게 좋다.
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
 WHERE carrid = pa_car.

LOOP AT gt_info INTO gs_info.
  "Get Atype(D, I)
  IF gs_info-countryfr = gs_info-countryto.
    gs_info-atype = 'D'.
  ELSE.
    gs_info-atype = 'I'.
  ENDIF.


  "Get Airline Name
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
    WHERE carrid = gs_info-carrid.
  MODIFY gt_info FROM gs_info
                 TRANSPORTING carrname atype. "gs_info에 있는 carrname, atype 값만 바꿀거야
  CLEAR gs_info.
ENDLOOP.

cl_demo_output=>display_data( gt_info ).

*&---------------------------------------------------------------------*
*& Form get_airline
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM add_info USING VALUE(p_carrid)
*                    VALUE(p_connid)
*                    VALUE(p_fr)
*                    VALUE(p_to).
*  DATA ls_info LIKE LINE OF gt_info.
*
*
*  CLEAR gs_info.
*  ls_info-carrid = p_carrid.
*  ls_info-connid = p_connid.
*  ls_info-countryfr = p_fr.
*  ls_info-countryto = p_to.
*  APPEND ls_info TO gt_info.
*  CLEAR ls_info.
*
*ENDFORM.
