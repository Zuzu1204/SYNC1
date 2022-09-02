*&---------------------------------------------------------------------*
*& Report ZRSA05_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_12.

DATA gv_carrname TYPE scarr-carrname.
PARAMETERS pa_carr TYPE scarr-carrid.

"Get Airline Name
PERFORM get_airline_name USING pa_carr
                         CHANGING gv_carrname.



"Display Airline Name
WRITE gv_carrname.
*&---------------------------------------------------------------------*
*& Form cal
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_airline_name USING VALUE(p_code)
                      CHANGING p_carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_carrname
    WHERE carrid = p_code.
    WRITE 'Test GV_CARRNAME:'.
    WRITE gv_carrname.
ENDFORM.
