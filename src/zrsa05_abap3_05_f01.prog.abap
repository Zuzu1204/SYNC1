*&---------------------------------------------------------------------*
*& Include          ZRSA05_ABAP3_05_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  CLEAR gt_data.

  SELECT a~matnr a~stlan a~stlnr a~stlal
         b~mtart b~matkl
         c~maktx
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM mast AS a
   INNER JOIN mara AS b
      ON a~matnr = b~matnr
    LEFT OUTER JOIN makt AS c
      ON a~matnr = c~matnr
     AND c~spras = sy-langu
   WHERE werks = pa_wer
     AND a~matnr IN so_mat.

*  SELECT maktx
*    FROM makt
*    INTO gt_data
*   WHERE matnr IN so_mat
*     AND spras = sy-langu.

ENDFORM.
