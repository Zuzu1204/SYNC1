*----------------------------------------------------------------------*
**
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
   CASE OK_CODE.
    WHEN 'CANCEL'.
      PERFORM free_control_resource.
      CLEAR OK_CODE.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      PERFORM free_control_resource.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      PERFORM free_control_resource.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form free_control_resource
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM free_control_resource .

      CALL METHOD go_alv_grid->free.
      CALL METHOD go_container->free.
      FREE : go_alv_grid, go_container.

ENDFORM.
