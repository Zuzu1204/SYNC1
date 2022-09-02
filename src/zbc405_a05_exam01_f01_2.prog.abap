*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_EXAM01_F01
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
    FROM ztspfli_A05
    INTO CORRESPONDING FIELDS OF TABLE gt_flt
   WHERE carrid IN so_car
     AND connid IN so_con.

  SELECT *
    FROM sairport
    INTO TABLE gt_sairp.



    LOOP AT gt_flt INTO gs_flt.
*      I&D
      IF gs_flt-countryfr = gs_flt-countryto.
        gs_flt-iandd = 'D'.
      ELSE.
        gs_flt-iandd = 'I'.
      ENDIF.

      " fltype icon
      IF gs_flt-fltype = 'X'.
        gs_flt-fltype_icon = icon_ws_plane.
      ELSE.
        gs_flt-fltype_icon = icon_space.
      ENDIF.

*      time zone
      CLEAR gs_sairp.
      READ TABLE gt_sairp INTO gs_sairp WITH KEY id = gs_flt-airpfrom.
      gs_flt-frtzone = gs_sairp-time_zone.
      CLEAR gs_sairp.
      READ TABLE gt_sairp INTO gs_sairp WITH KEY id = gs_flt-airpto.
      gs_flt-totzone = gs_sairp-time_zone.

*      i&d IT_COLOR
      CLEAR gs_color.
      IF gs_flt-iandd = 'D'.
        gs_color-fname = 'IANDD'.
        gs_color-color-col = col_total.
        gs_color-color-int = '1'.
        gs_color-color-inv = '0'.
        APPEND gs_color TO gs_flt-it_color.
      CLEAR gs_color.
      ELSEIF gs_flt-iandd = 'I'.
        gs_color-fname = 'IANDD'.
        gs_color-color-col = col_positive.
        gs_color-color-int = '1'.
        gs_color-color-inv = '0'.
        APPEND gs_color TO gs_flt-it_color.
      ENDIF.

*      exception handling 신호등
      IF gs_flt-PERIOD ge 2.
        gs_flt-light = 1.  "red
      elseif gs_flt-period eq 1.
        gs_flt-light = 2.  "yellow
      elseif gs_flt-period eq 0.
        gs_flt-light = 3.  "green
      ENDIF.



    MODIFY gt_flt FROM gs_flt.

    ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'IANDD'.
  gs_fcat-coltext = 'I&D'.
  gs_fcat-col_pos = 5.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTYPE_ICON'.
  gs_fcat-coltext = 'Flight'.
  gs_fcat-col_pos = 9.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTYPE'.
  gs_fcat-no_out = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FRTZONE'.
  gs_fcat-coltext = 'From TZ'.
  gs_fcat-col_pos = 17.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TOTZONE'.
  gs_fcat-coltext = 'To TZ'.
  gs_fcat-col_pos = 18.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'ARRTIME'.
  gs_fcat-emphasize = 'C710'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.
  gs_fcat-emphasize = 'C710'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTIME'.
  gs_fcat-edit      = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'DEPTIME'.
  gs_fcat-edit      = pa_edit.
  APPEND gs_fcat TO gt_fcat.

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
  gs_layout-ctab_fname = 'IT_COLOR'.
  gs_layout-zebra = 'X'.
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.
ENDFORM.
