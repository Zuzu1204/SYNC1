*&---------------------------------------------------------------------*
*& Report ZRSA05_25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa05_25_top                           .    " Global Data

* INCLUDE ZRSA05_25_O01                           .  " PBO-Modules
* INCLUDE ZRSA05_25_I01                           .  " PAI-Modules
 INCLUDE zrsa05_25_f01                           .  " FORM-Routines (form을 사용할 경우 여기에 넣어라)

 START-OF-SELECTION.
    SELECT *
      FROM sflight
      INTO CORRESPONDING FIELDS OF TABLE gt_info
     WHERE carrid = pa_car
      AND connid BETWEEN pa_con1 AND pa_con2.

    cl_demo_output=>display_data( gt_info ).
