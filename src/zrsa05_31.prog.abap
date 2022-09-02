*&---------------------------------------------------------------------*
*& Report ZRSA05_31
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_31_top                           .    " Global Data

* INCLUDE ZRSA05_31_O01                           .  " PBO-Modules
* INCLUDE ZRSA05_31_I01                           .  " PAI-Modules
 INCLUDE zrsa05_31_f01                           .  " FORM-Routines

 INITIALIZATION.
  PERFORM set_default.

START-OF-SELECTION.
  SELECT *
    FROM ztsa0501
    INTO CORRESPONDING FIELDS OF TABLE gt_emp
   WHERE entdt BETWEEN pa_ent_b AND pa_ent_e.

  IF sy-subrc IS NOT INITIAL."0이 아니다.
    RETURN.
  ENDIF.

  cl_demo_output=>display_data( gt_emp ).
