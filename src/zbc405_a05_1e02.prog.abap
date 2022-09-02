*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_1E02
*&---------------------------------------------------------------------*

CASE 'X'.
  WHEN p_rad1.

  WHEN p_rad2.
    SELECT *
      FROM dv_flights
      INTO CORRESPONDING FIELDS OF table gt_flt
     WHERE countryto = dv_flights~countryfr
       and carrid in so_car
       and connid in so_con
       and fldate in so_date.
  WHEN p_rad3.

ENDCASE.
