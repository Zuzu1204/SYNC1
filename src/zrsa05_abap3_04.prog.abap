*&---------------------------------------------------------------------*
*& Report ZRSA05_ABAP3_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_abap3_04.

TABLES : mkal, pbid, mara, marc.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS : pa_wer TYPE mkal-werks DEFAULT '1010',
               pa_bid TYPE pbid-berid DEFAULT '1010',
               pa_pnr TYPE pbid-pbdnr,
               pa_ver TYPE pbid-versb DEFAULT '00'.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-t02.
  PARAMETERS : pa_crt RADIOBUTTON GROUP rd1 DEFAULT 'X' USER-COMMAND mod,
               pa_dis RADIOBUTTON GROUP rd1.
SELECTION-SCREEN END OF BLOCK bl2.

SELECTION-SCREEN BEGIN OF BLOCK bl3 WITH FRAME TITLE TEXT-t03.
  SELECT-OPTIONS : so_matn  FOR mara-matnr MODIF ID mar,
                   so_mta   FOR mara-mtart MODIF ID mar,
                   so_matk  FOR mara-matkl MODIF ID mar,
                   so_ekg   FOR marc-ekgrp MODIF ID mac.
  PARAMETERS : pa_disp TYPE marc-dispo MODIF ID mac,
               pa_dism TYPE marc-dismm MODIF ID mac.
SELECTION-SCREEN END OF BLOCK bl3.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.
*&---------------------------------------------------------------------*
*& Form modify_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_screen .

  LOOP AT SCREEN.

    CASE screen-name.
      WHEN 'PA_PNR' OR 'PA_VER'.
        screen-input = 0.  "입력을 끄다
        MODIFY SCREEN.
    ENDCASE.

*    CASE 'x'.
*      WHEN pa_crt.
*
*        CASE screen-name.
*          WHEN 'SO_EKG-low' OR 'SO_EKG-high'OR 'PA_DISP' OR 'PA_DISM'.
*            screen-active = 0.
*            MODIFY SCREEN.
*        ENDCASE.
*
*    ENDCASE.

    CASE 'X'.
      WHEN pa_crt.

        CASE screen-group1.
          WHEN 'MAC'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.

      WHEN pa_dis.

        CASE screen-group1.
          WHEN 'MAR'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.

    ENDCASE.

  ENDLOOP.

ENDFORM.
