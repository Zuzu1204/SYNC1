*&---------------------------------------------------------------------*
*& Include          MZSA0501_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK' OR 'CANC'.
*      LEAVE TO SCREEN 0.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'SEARCH'.
      "Get Data
      perform get_data using gv_pno
                       CHANGING zssa0031.



*       MESSAGE s000(zmcsa00) WITH sy-ucomm.
   ENDCASE.
ENDMODULE.
