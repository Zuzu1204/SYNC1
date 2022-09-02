class ZCLC105_0001 definition
  public
  final
  create public .

public section.

  methods GET_AIRLINE_INFO
    importing
      !PI_CARRID type SCARR-CARRID
    exporting
      !PE_CODE type CHAR1
      !PE_MSG type CHAR100
    changing
      !ET_AIRLINE type ZC1TT05001 .
protected section.
private section.
ENDCLASS.



CLASS ZCLC105_0001 IMPLEMENTATION.


  method GET_AIRLINE_INFO.

    IF pi_carrid is INITIAL.
      pe_code = 'E'.
      pe_msg  = Text-e01.
      EXIT.
    ENDIF.

    select carrid carrname currcode url
      from scarr
      into CORRESPONDING FIELDS OF table et_airline
     where carrid = pi_carrid.

    IF sy-subrc ne 0.
      pe_code = 'E'.
      pe_msg  = Text-e02.
      EXIT.
    Else.
      pe_code = 'S'.
    ENDIF.

  endmethod.
ENDCLASS.
