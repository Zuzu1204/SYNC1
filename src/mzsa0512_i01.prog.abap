*&---------------------------------------------------------------------*
*& Include          MZSA0510_I01
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
    WHEN 'SEARCH'.
      "Get Airline info

      "Get Connection Info
      PERFORM get_conn_info USING zssa0580-carrid
                                  zssa0580-connid
                            CHANGING zssa0582.

*      IF zssa0582 IS NOT INITIAL.
*         PERFORM get_airline_info.
*
*      ELSE.
*        MESSAGE i016(pn) WITH 'No Data'.
*        CLEAR zssa0581.
*      ENDIF.

    WHEN 'ENTER'.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN  'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
