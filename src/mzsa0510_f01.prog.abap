*&---------------------------------------------------------------------*
*& Include          MZSA0510_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_airline_info .
       CLEAR zssa0581.
      SELECT SINGLE *
        FROM scarr
        INTO CORRESPONDING FIELDS OF zssa0581
       WHERE carrid = zssa0580-carrid.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0580_CARRID
*&      --> ZSSA0580_CONNID
*&      <-- ZSSA0582
*&---------------------------------------------------------------------*
FORM get_conn_info  USING    VALUE(p_carrid)
                             VALUE(p_connid)
                    CHANGING ps_info TYPE zssa0582.
  CLEAR ps_info.

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF ps_info
    WHERE carrid = p_carrid
      AND connid = p_connid.

  IF sy-subrc <> 0.
    MESSAGE i016(pn) WITH 'No Data'.
    CLEAR zssa0581.
  RETURN.
  ENDIF.


PERFORM get_airline_info.

ENDFORM.
