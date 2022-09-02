*&---------------------------------------------------------------------*
*& Include          MZSA0550_I01
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
    WHEN 'ENTER'.
    WHEN 'SEARCH'.

      CLEAR: zssa0551, zssa0552.

      "Inflight Info
      PERFORM get_inflight_info USING zssa0550-carrid
                                CHANGING zssa0551.


      "Vendor Info
      SELECT SINGLE *
        FROM ztsa05ven
        INTO CORRESPONDING FIELDS OF zssa0552
       WHERE lifnr = zssa0551-lifnr.

       SELECT SINGLE landx
         FROM t005t
         INTO zssa0552-landx
        WHERE land1 = zssa0552-land1
          AND spras = sy-langu.  "현재 시스템에 언어
"조건은  52번 structure 안에 있는 land1과 t005t 테이블에 있는 land1이 같은 아이면서
"spras가 현재 로그인된 언어인 애를 보여줘

       IF zssa0551-mtext IS INITIAL.
         MESSAGE i016(pn) WITH 'Data is not found'.
         CLEAR zssa0551.
*
       ENDIF.

       "Vendor Category domain
       DATA: lt_domain TYPE TABLE OF dd07v,
             ls_domain LIKE LINE OF lt_domain.

       CALL FUNCTION 'GET_DOMAIN_VALUES'
         EXPORTING
           domname               = 'ZDVENCA_A05'
*          TEXT                  = 'X'
*          FILL_DD07L_TAB        = ' '
        TABLES
          values_tab            = lt_domain
*          VALUES_DD07L          =
        EXCEPTIONS
          no_values_found       = 1
          OTHERS                = 2.
       IF sy-subrc <> 0.
* Implement suitable error handling here
       ENDIF.
      READ TABLE lt_domain WITH KEY domvalue_l = zssa0552-venca
      INTO ls_domain.
      zssa0552-vtext = ls_domain-ddtext.

       "Type of dish domain
       DATA: lt_domain2 TYPE TABLE OF dd07v,
             ls_domain2 LIKE LINE OF lt_domain2.

      CALL FUNCTION 'GET_DOMAIN_VALUES'
        EXPORTING
          domname               = 'S_MEALTYPE'
*         TEXT                  = 'X'
*         FILL_DD07L_TAB        = ' '
       TABLES
         values_tab            = lt_domain2
*         VALUES_DD07L          =
       EXCEPTIONS
         no_values_found       = 1
         OTHERS                = 2.
      IF sy-subrc <> 0.
*       Implement suitable error handling here
      ENDIF.
      READ TABLE lt_domain2 WITH KEY domvalue_l = zssa0551-mealtype
      INTO ls_domain2.
      zssa0551-mealtypet = ls_domain2-ddtext.

      CLEAR: ls_domain, ls_domain2.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
