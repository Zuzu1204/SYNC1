*&---------------------------------------------------------------------*
*& Report ZRSA05_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_14.

"Transparent Table = Structure Type
DATA gs_scarr TYPE scarr.

PARAMETERS pa_carr LIKE gs_scarr-carrid.

SELECT SINGLE carrid carrname
  FROM  scarr
  INTO gs_scarr
 WHERE carrid = pa_carr.

  WRITE: gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode.


*우리집 고양이는 키키고 2살이야.
*우리집 ㅇㅇㅇ는 ㅇㅇ고 ㅇㅇ이야.
*
*DATA: gv_cat_name TYPE c LENGTH 10,
*      gv_cat_age type i.
*
*data: BEGIN of ts_cat,
*        name type c length 10,
*        age type i,
*      end of ts_cat.
*
*data gs_cat type ts_cat
