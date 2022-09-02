*&---------------------------------------------------------------------*
*& Report ZRSA05_ABAP3_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_abap3_02 MESSAGE-ID zmcsa05.

*selection screen 실습 1

*TABLES sbuspart.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
*  PARAMETERS     pa_num TYPE sbuspart-buspartnum OBLIGATORY.
*  SELECT-OPTIONS so_cont FOR sbuspart-contact NO INTERVALS.
*
**  SELECTION-SCREEN SKIP 1.
*  SELECTION-SCREEN ULINE.
*
*  PARAMETERS : pa_ta RADIOBUTTON GROUP rd1 DEFAULT 'X',
*               pa_fc RADIOBUTTON GROUP rd1.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*DATA : gs_data TYPE sbuspart,
*       gt_data LIKE TABLE OF gs_sbuspart.
*
*refresh gt_data.
*
*IF pa_ta = 'X'.
*  SELECT buspartnum contact contphono buspatyp
*  FROM sbuspart
*  INTO CORRESPONDING FIELDS OF TABLE gt_sbuspart
* WHERE buspartnum = pa_num
*   and contact    in so_cont.
*ENDIF.


*--------------------------------------------------------------------

*selection screen 실습 2

*TABLES sbook.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.
*  PARAMETERS       pa_car  TYPE sbook-carrid   OBLIGATORY
*                           DEFAULT 'AA'        VALUE CHECK.
*  SELECT-OPTIONS   so_con  FOR sbook-connid    OBLIGATORY.
*  PARAMETERS       pa_cust TYPE sbook-custtype OBLIGATORY AS LISTBOX VISIBLE LENGTH 20.
*  SELECT-OPTIONS : so_fld  FOR sbook-fldate    DEFAULT sy-datum,
*                   so_bid  FOR sbook-bookid,
*                   so_cust FOR sbook-customid  NO INTERVALS NO-EXTENSION.
*SELECTION-SCREEN END OF BLOCK b2.
*
*DATA : begin of gs_sbook,
*         carrid   type sbook-carrid,
*         connid   type sbook-connid,
*         fldate   type sbook-fldate,
*         bookid   type sbook-bookid,
*         customid type sbook-customid,
*         custtype type sbook-custtype,
*         invoice  type sbook-invoice,
*         class    type sbook-class,
*       end of gs_sbook,
*       gt_sbook   LIKE TABLE OF gs_sbook,
*       lv_tabix   TYPE sy-tabix.
*
*refresh gt_sbook.
*
*SELECT carrid connid fldate bookid customid custtype invoice class
*  FROM sbook
*  INTO CORRESPONDING FIELDS OF TABLE gt_sbook
* WHERE carrid   = pa_car
*   AND connid   IN so_con
*   AND custtype = pa_cust
*   AND fldate   IN so_fld
*   AND bookid   IN so_bid
*   AND customid IN so_cust.
*
**사용자에게 알려줄 메세지
*IF sy-subrc NE 0.
*  MESSAGE s001 DISPLAY LIKE 'E'.
*  LEAVE LIST-PROCESSING.
*ENDIF.
*
*LOOP AT gt_sbook INTO gs_sbook.
*  lv_tabix = sy-tabix.
*
*  CASE gs_sbook-invoice.
*    WHEN 'X'.
*      gs_sbook-class = 'F'.
*
*      MODIFY gt_sbook FROM gs_sbook INDEX lv_tabix
*      TRANSPORTING class.
*
*  ENDCASE.
*
*  CLEAR gs_sbook.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_sbook ).


*--------------------------------------------------------------------


*selection screen 실습 3

TABLES : sflight, sbook.

SELECTION-SCREEN BEGIN OF BLOCK bl3 WITH FRAME TITLE TEXT-t03.
  PARAMETERS     pa_car  TYPE sflight-carrid     OBLIGATORY.
  SELECT-OPTIONS so_con  FOR  sflight-connid     OBLIGATORY.
  PARAMETERS     pa_plt  TYPE sflight-planetype  AS LISTBOX VISIBLE LENGTH 20.
  SELECT-OPTIONS so_bid   FOR  sbook-bookid.
SELECTION-SCREEN END OF BLOCK bl3.

*itab 1
DATA : BEGIN OF gs_itab1,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         currency  TYPE sflight-currency,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         class     TYPE sbook-class,
         agencynum TYPE sbook-agencynum,
       END OF gs_itab1,

       gt_itab1 LIKE TABLE OF gs_itab1,

*itab 2
       BEGIN OF gs_itab2,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         agencynum TYPE sbook-agencynum,
       END OF gs_itab2,

       gt_itab2 LIKE TABLE OF gs_itab2.

REFRESH : gt_itab1, gt_itab2.

SELECT a~carrid a~connid a~fldate a~planetype a~currency
       b~bookid b~customid b~custtype b~class b~agencynum
  FROM sflight AS a INNER JOIN sbook AS b
    ON a~carrid = b~carrid
   AND a~connid = b~connid
   AND a~fldate = b~fldate
  INTO CORRESPONDING FIELDS OF TABLE gt_itab1
 WHERE a~carrid  = pa_car
   AND a~connid  IN so_con
   AND planetype = pa_plt
   AND bookid    IN so_bid.

IF sy-subrc NE 0.
  MESSAGE s001.
  LEAVE LIST-PROCESSING.
ENDIF.

LOOP AT gt_itab1 INTO gs_itab1.

  CASE gs_itab1-custtype.
    WHEN 'B'.
*      gs_itab2 = gs_itab1.
      MOVE-CORRESPONDING gs_itab1 TO gs_itab2.

      APPEND gs_itab2 TO gt_itab2.
      CLEAR gs_itab2.
  ENDCASE.

ENDLOOP.

SORT gt_itab2 BY carrid connid fldate.
DELETE ADJACENT DUPLICATES FROM gt_itab2 COMPARING carrid connid fldate.
*
*
*cl_demo_output=>display_data( gt_itab2 ).



*--------------------------------------------------------------------


*F4설명

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_car.
  PERFORM f4_carrid.

*&---------------------------------------------------------------------*
*& Form f4_carrid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f4_carrid .
  DATA : BEGIN OF ls_carrid,
           carrid   TYPE scarr-carrid,
           carrname TYPE scarr-carrname,
           currcode TYPE scarr-currcode,
           url      TYPE scarr-url,
         END OF ls_carrid,

         lt_carrid LIKE TABLE OF ls_carrid.

  REFRESH lt_carrid.

  SELECT carrid carrname currcode url
    FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE lt_carrid.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield     = 'CARRID'
      dynpprog     = sy-repid
      dynpnr       = sy-dynnr
      dynprofield  = 'pa_CARR'
      window_title = TEXT-t02
      value_org    = 'S'
      display      = ''
    TABLES
      value_tab    = lt_carrid.
ENDFORM.
