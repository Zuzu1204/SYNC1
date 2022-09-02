*&---------------------------------------------------------------------*
*& Include          MZSA0550_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_inflight_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_inflight_info USING VALUE(p_cond)
                       CHANGING p_inf TYPE zssa0551.
  SELECT SINGLE *
        FROM smeal
        INTO CORRESPONDING FIELDS OF p_inf
       WHERE carrid = p_cond
         AND mealnumber = zssa0550-mealnumber.

      SELECT SINGLE *
        FROM scarr
        INTO CORRESPONDING FIELDS OF p_inf
       WHERE carrid = p_cond.

      SELECT SINGLE price waers lifnr
        FROM ztsa05ven
        INTO CORRESPONDING FIELDS OF p_inf
       WHERE carrid = p_cond
        AND mealno = zssa0550-mealnumber.

      SELECT SINGLE text
        FROM smealt
        INTO p_inf-mtext
       WHERE carrid = p_cond
         AND mealnumber = zssa0550-mealnumber.


ENDFORM.
