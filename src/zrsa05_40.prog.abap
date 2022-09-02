*&---------------------------------------------------------------------*
*& Report ZRSA05_40
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_40_top                           .    " Global Data

* INCLUDE ZRSA05_40_O01                           .  " PBO-Modules
* INCLUDE ZRSA05_40_I01                           .  " PAI-Modules
 INCLUDE zrsa05_40_f01                           .  " FORM-Routines


INITIALIZATION.
START-OF-SELECTION.

SELECT *
  FROM zvsa0510
  INTO CORRESPONDING FIELDS OF TABLE gt_list
 WHERE pernr = pa_pernr.

*LOOP AT gt_list.
*
*clEAR
*ENDLOOP.

  cl_demo_output=>display_data( gt_list ).
