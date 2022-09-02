*&---------------------------------------------------------------------*
*& Include          ZET_0810_ALV_A00_E01
*&---------------------------------------------------------------------*



INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  SELECT * FROM sbook INTO TABLE gt_book
    WHERE carrid IN so_car
      AND connid IN so_con
      AND fldate IN so_dat
      AND bookid IN so_bid.

  CALL SCREEN 100.
