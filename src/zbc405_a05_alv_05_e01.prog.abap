*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_ALV_05_E01
*&---------------------------------------------------------------------*

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  SELECT *
    FROM ztspfli_t03
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN pa_car
      AND connid IN pa_con.


CALL SCREEN 100.
