class ZCL_IM_BC425IM05_V1 definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_BOOK05 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BC425IM05_V1 IMPLEMENTATION.


  method IF_EX_BADI_BOOK05~CHANGE_VLINE.

    c_pos = c_pos + 38.

  endmethod.


  METHOD if_ex_badi_book05~output.

  DATA : gv_name TYPE s_custname.

  SELECT SINGLE name
    FROM scustom
    INTO gv_name
   WHERE id = i_booking-customid.
   WRITE : gv_name.

  ENDMETHOD.
ENDCLASS.
