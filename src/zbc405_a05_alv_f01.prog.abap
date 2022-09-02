*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_ALV_F01
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
  SELECT *
    FROM zsflight_a05
    INTO CORRESPONDING FIELDS OF TABLE gt_flt
   WHERE carrid IN so_car
     AND connid IN so_con
     AND fldate IN so_dat.

    "loop
    LOOP AT gt_flt INTO gs_flt.
      IF gs_flt-price < 400.
        gs_flt-light = 1.  "red
      ELSEIF gs_flt-price < 600.
        gs_flt-light = 2.  "yellow
      ELSE.
        gs_flt-light = 3.  "green
      ENDIF.

      MODIFY gt_flt FROM gs_flt.
    ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  gs_layout-sel_mode = 'D'.
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.  "신호등 하나
ENDFORM.
