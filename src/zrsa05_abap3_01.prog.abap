*&---------------------------------------------------------------------*
*& Report ZBC405_A05_0824
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_abap3_01 MESSAGE-ID zmcsa05.

*실습1
*첫번째 문제
DATA : gs_emp TYPE ztsa0501,
       gt_emp LIKE TABLE OF gs_emp.

*----------------------------------------------------------

*두번째 문제
*DATA : BEGIN OF gs_mara,
*         matnr TYPE mara-matnr,
*         werks TYPE marc-werks,
*         mtart TYPE mara-mtart,
*         matkl TYPE mara-matkl,
*         ekgrp TYPE marc-ekgrp,
*         pstat TYPE marc-pstat,
*       END OF gs_mara.
*
*DATA gt_mara LIKE TABLE OF gs_mara.
*
**include STRUCTURE
*DATA : gs_data TYPE ztsa0501,
*       gt_data TYPE TABLE OF ztsa0501.  "ztsa0501은 global 빈수이기 때문에 type을 쓸 수 있다.
*
*DATA : BEGIN OF gs_data2.
*         INCLUDE STRUCTURE ztsa0501.
*DATA : END OF gs_data2,
*
*gt_data2 LIKE TABLE OF gs_data2.

*----------------------------------------------------------

*실습2
DATA : gs_sbook TYPE sbook,
       gt_sbook LIKE TABLE OF gs_sbook,
       lv_tabix TYPE sy-tabix.

CLEAR   gs_sbook.
REFRESH gt_sbook.

SELECT carrid connid fldate bookid customid custtype invoice class smoker
  FROM sbook
  INTO CORRESPONDING FIELDS OF TABLE gt_sbook
 WHERE carrid     = 'DL'
   AND custtype   = 'P'
   AND order_date = '20201227'.

IF sy-subrc NE 0.
  MESSAGE s001 DISPLAY LIKE 'E'.
  LEAVE LIST-PROCESSING.
ENDIF.

CLEAR gs_sbook.

LOOP AT gt_sbook INTO gs_sbook.
  lv_tabix = sy-tabix.

  CASE gs_sbook-smoker.
    WHEN 'X'.

      CASE gs_sbook-invoice.
        WHEN 'X'.
          gs_sbook-class = 'F'.

          MODIFY gt_sbook FROM gs_sbook INDEX lv_tabix
          TRANSPORTING class.
      ENDCASE.

  ENDCASE.

ENDLOOP.

CLEAR lv_tabix.

*----------------------------------------------------------

*실습3
DATA : BEGIN OF gs_sflight,
         carrid     TYPE sflight-carrid,
         connid     TYPE sflight-connid,
         fldate     TYPE sflight-fldate,
         currency   TYPE sflight-currency,
         planetype  TYPE sflight-planetype,
         seatsocc_b TYPE sflight-seatsocc_b,
       END OF gs_sflight.

DATA gt_sflight LIKE TABLE OF gs_sflight.

SELECT carrid connid fldate currency planetype seatsocc_b
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_sflight
 WHERE currency = 'USD'
   AND planetype = '747-400'.

LOOP AT gt_sflight INTO gs_sflight.
  lv_tabix = sy-tabix.

  CASE gs_sflight-carrid.
    WHEN 'UA'.
      gs_sflight-seatsocc_B = gs_sflight-seatsocc_B + 5.
  ENDCASE.

  MODIFY gt_sflight FROM gs_sflight INDEX lv_tabix
  TRANSPORTING seatsocc_b.

ENDLOOP.

CLEAR lv_tabix.

*----------------------------------------------------------

*실습4
DATA : BEGIN OF gs_mara,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF gs_mara,
       gt_mara LIKE TABLE OF gs_mara,

       BEGIN OF gs_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF gs_makt,
       gt_makt LIKE TABLE OF gs_makt.

CLEAR : gt_mara, gt_makt.
SELECT matnr mtart matkl
  FROM mara
  INTO CORRESPONDING FIELDS OF TABLE gt_mara.

SELECT maktx matnr
  FROM makt
  INTO CORRESPONDING FIELDS OF TABLE gt_makt
 WHERE spras = sy-langu.

CLEAR gs_mara.
LOOP AT gt_mara INTO gs_mara.
  lv_tabix = sy-tabix.

  READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_mara-matnr.

  IF sy-subrc = 0.
    gs_mara-maktx = gs_makt-maktx.

    MODIFY gt_mara FROM gs_mara INDEX lv_tabix
    TRANSPORTING maktx.
  ENDIF.
  CLEAR gs_mara.
ENDLOOP.

CLEAR lv_tabix.


*----------------------------------------------------------

*실습5
DATA : BEGIN OF gs_spfli,
         carrid   TYPE spfli-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
         connid   TYPE spfli-connid,
         airpfrom TYPE spfli-airpfrom,
         airpto   TYPE spfli-airpto,
         deptime  TYPE spfli-deptime,
         arrtime  TYPE spfli-arrtime,
       END OF gs_spfli,
       gt_spfli LIKE TABLE OF gs_spfli,

       BEGIN OF gs_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
       END OF gs_scarr,
       gt_scarr LIKE TABLE OF gs_scarr.

CLEAR : gt_spfli, gt_scarr.
SELECT carrid connid airpfrom airpto deptime arrtime
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_spfli.

SELECT carrname url carrid
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

CLEAR gs_spfli.
LOOP AT gt_spfli INTO gs_spfli.

  lv_tabix = sy-tabix.

  CLEAR gs_scarr.

  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gs_spfli-carrid.

  IF sy-subrc = 0.
    gs_spfli-carrname = gs_scarr-carrname.
    gs_spfli-url      = gs_scarr-url.

    MODIFY gt_spfli FROM gs_spfli INDEX lv_tabix
    TRANSPORTING carrname url.
  ENDIF.

  CLEAR gs_scarr.

ENDLOOP.

CLEAR lv_tabix.

*----------------------------------------------------------

*실습6
*DATA : BEGIN OF gs_data,
*         matnr TYPE mara-matnr,
*         maktx TYPE makt-maktx,
*         mtart TYPE mara-mtart,
*         mtbez TYPE t134t-mtbez,
*         mbrsh TYPE mara-mbrsh,
*         mbbez TYPE t137t-mbbez,
*         tragr TYPE mara-tragr,
*         vtext TYPE ttgrt-vtext,
*       END OF gs_data,
*
*       gt_data LIKE TABLE OF gs_data,
*
*       BEGIN OF gs_t134t,
*         mtbez TYPE t134t-mtbez,
*         mtart TYPE t134t-mtart,
*       END OF gs_t134t,
*       gt_t134t LIKE TABLE OF gs_t134t,
*
*       BEGIN OF gs_t137t,
*         mbbez TYPE t137t-mbbez,
*         mbrsh TYPE t137t-mbrsh,
*       END OF gs_t137t,
*       gt_t137t LIKE TABLE OF gs_t137t,
*
*       BEGIN OF gs_ttgrt,
*         vtext TYPE ttgrt-vtext,
*         tragr TYPE ttgrt-tragr,
*       END OF gs_ttgrt,
*       gt_ttgrt LIKE TABLE OF gs_ttgrt.
*
*CLEAR : gt_data, gt_t134t, gt_t137t, gt_ttgrt.
*SELECT mara~matnr mtart mbrsh tragr maktx
*  FROM mara INNER JOIN makt
*    ON mara~matnr = makt~matnr
*  INTO CORRESPONDING FIELDS OF TABLE gt_data.
*
*SELECT mtbez mtart
*  FROM t134t
*  INTO CORRESPONDING FIELDS OF TABLE gt_t134t
* WHERE spras = sy-langu.
*
*SELECT mbbez mbrsh
*FROM t137t
*INTO CORRESPONDING FIELDS OF TABLE gt_t137t
*WHERE spras = sy-langu.
*
*SELECT vtext tragr
*  FROM ttgrt
*  INTO CORRESPONDING FIELDS OF TABLE gt_ttgrt
* WHERE spras = sy-langu.
*
*LOOP AT gt_data INTO gs_data.
*
*  lv_tabix = sy-tabix.
*
*  READ TABLE gt_t134t INTO gs_t134t WITH KEY mtart = gs_data-mtart.
*  READ TABLE gt_t137t INTO gs_t137t WITH KEY mbrsh = gs_data-mbrsh.
*  READ TABLE gt_ttgrt INTO gs_ttgrt WITH KEY tragr = gs_data-tragr.
*
*  gs_data-mtbez = gs_t134t-mtbez.
*  gs_data-mbbez = gs_t137t-mbbez.
*  gs_data-vtext = gs_ttgrt-vtext.
*
*  MODIFY gt_data FROM gs_data INDEX lv_tabix
*  TRANSPORTING mtbez mbbez vtext.
*
*  CLEAR : gs_t134t, gs_t137t, gs_ttgrt.
*
*ENDLOOP.
*
*CLEAR lv_tabix.

*----------------------------------------------------------

*숙제

DATA : BEGIN OF gs_data,
         ktopl TYPE ska1-ktopl,
         ktplt TYPE t004t-ktplt,
         saknr TYPE ska1-saknr,
         txt20 TYPE skat-txt20,
         ktoks TYPE ska1-ktoks,
         txt30 TYPE t077z-txt30,
       END OF gs_data,
       gt_data  LIKE TABLE OF gs_data,

       gs_t004t TYPE t004t,
       gt_t004t LIKE TABLE OF gs_t004t,

       gs_skat  TYPE skat,
       gt_skat  LIKE TABLE OF gs_skat,

       gs_t077z TYPE t077z,
       gt_t077z LIKE TABLE OF gs_t077z.

*CLEAR : gt_ska1, gt_t004t, gt_skat, gt_t077z.

SELECT ktopl saknr ktoks
  FROM ska1
  INTO CORRESPONDING FIELDS OF TABLE gt_data
 WHERE ktopl = 'WEG'.

SELECT ktopl ktplt
  FROM t004t
  INTO CORRESPONDING FIELDS OF TABLE gt_t004t
 WHERE spras = sy-langu.

SELECT saknr txt20
  FROM skat
  INTO CORRESPONDING FIELDS OF TABLE gt_skat
 WHERE spras = sy-langu.

SELECT ktoks txt30
  FROM t077z
  INTO CORRESPONDING FIELDS OF TABLE gt_t077z
 WHERE spras = sy-langu.

LOOP AT gt_data INTO gs_data.

  lv_tabix = sy-tabix.

  READ TABLE gt_t004t INTO gs_t004t WITH KEY ktopl = gs_data-ktopl.
  IF sy-subrc = 0.
    gs_data-ktplt = gs_t004t-ktplt.
  ENDIF.

  READ TABLE gt_skat INTO gs_skat WITH KEY saknr = gs_data-saknr.
  IF sy-subrc = 0.
    gs_data-txt20 = gs_skat-txt20.
  ENDIF.

  READ TABLE gt_t077z INTO gs_t077z WITH KEY ktoks = gs_data-ktoks.
  IF sy-subrc = 0.
    gs_data-txt30 = gs_t077z-txt30.
  ENDIF.

  MODIFY gt_data FROM gs_data INDEX lv_tabix
  TRANSPORTING ktplt txt20 txt30.

  CLEAR gs_data.

ENDLOOP.


cl_demo_output=>DISPLAY_data( gt_data ).
