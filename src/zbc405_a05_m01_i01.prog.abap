*&---------------------------------------------------------------------*
*& Include          ZBC405_A05_M01_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.
      "= LEAVE TO SCREEN 0.

    WHEN 'EXit'.
      LEAVE PROGRAM.

    WHEN 'ENTER'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
