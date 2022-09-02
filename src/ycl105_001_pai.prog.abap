*&---------------------------------------------------------------------*
*& Include          YCL105_001_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_0100 INPUT.

  save_ok = ok_code.
  CLEAR ok_code.

  CASE SAVE_OK.
    WHEN 'EXIT'.
      leave program.
    WHEN 'CANC'.
      leave to screen 0.
    WHEN OTHERS.
      ok_code = SAVE_OK.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  save_ok = ok_code.
  CLEAR ok_code.

  CASE SAVE_OK.
    WHEN 'BACK'.
      leave to screen 0.
    WHEN OTHERS.
      ok_code = SAVE_OK.
  ENDCASE.

ENDMODULE.
