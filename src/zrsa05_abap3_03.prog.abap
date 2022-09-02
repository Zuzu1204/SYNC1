*&---------------------------------------------------------------------*
*& Report ZRSA05_ABAP3_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_abap3_03.

*구문법
DATA : BEGIN OF ls_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
       END OF ls_scarr,
       lt_scarr LIKE TABLE OF ls_scarr.

SELECT carrid carrname url
  INTO CORRESPONDING FIELDS OF TABLE lt_scarr
  FROM scarr.

  READ TABLE lt_scarr INTO ls_scarr WITH KEY carrid = 'AA'.



*신문법 New Syntax
  SELECT carrid, carrname
    INTO TABLE @DATA(lt_scarr2)
    FROM scarr.

    READ TABLE lt_scarr2 INTO DATA(ls_scarr2) WITH KEY carrid = 'AA'.
