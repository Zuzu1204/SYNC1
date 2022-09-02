*&---------------------------------------------------------------------*
*& Include          MZSA0503_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'SEARCH'.
      PERFORM get_airline_name USING gv_carrid
                               CHANGING gv_carrname.
      CALL SCREEN 200.
      message i000(zmcsa00) with 'CALL'.
      LEAVE SCREEN.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
*      SET SCREEN 100.
*      message i000(zmcsa00) with 'BACK'.
*      leave screen.

*       MESSAGE i000(zmcsa00) WITH 'BACK'.
*       CALL SCREEN 100.
        LEAVE TO SCREEN 0.


  ENDCASE.
ENDMODULE.
