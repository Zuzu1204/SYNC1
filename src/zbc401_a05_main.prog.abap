*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a05_main.

TYPE-POOLS : icon.


CLASS lcl_airplane DEFINITION.


  PUBLIC SECTION.

    METHODS :
      constructor
        IMPORTING  iv_name      TYPE string
                   iv_planetype TYPE saplane-planetype
        EXCEPTIONS
                   wrong_planetype.
*--
    METHODS : set_attributes
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype,

      display_attributes.
    CLASS-METHODS : display_n_o_airplanes.
    CLASS-METHODS : get_n_o_airplanes
      RETURNING VALUE(rv_count) TYPE i.

    CLASS-METHODS class_constructor.

  PRIVATE SECTION.
    DATA : mv_name      TYPE string,
           mv_planetype TYPE saplane-planetype,
           mv_weight    TYPE saplane-weight,
           mv_tankcap   TYPE saplane-tankcap.


    TYPES : ty_planetype TYPE TABLE OF saplane.

    CLASS-DATA : gv_n_o_airplanes  TYPE i.
    CLASS-DATA : gv_planetypes TYPE ty_planetype. "아래에서 사용될 것
    CONSTANTS : c_pos_i TYPE i VALUE 30.

    CLASS-METHODS : get_technical_attributes
                      IMPORTING iv_type TYPE saplane-planetype
                      EXPORTING ev_weight TYPE saplane-weight
                                ev_tankcap TYPE saplane-tankcap
                      EXCEPTIONS wrong_planetype. "문제가 있다면 exception을 해라

ENDCLASS.

CLASS lcl_airplane IMPLEMENTATION.
  "constructor안에 있는 select구문을 따로 떼어서 다른데서도 재사용 가능하게끔
  "구조화 시킨것
  METHOD get_technical_attributes.

    DATA : ls_planetype TYPE saplane.

    READ TABLE gv_planetypes INTO ls_planetype
                WITH KEY planetype = iv_type.

    IF sy-subrc EQ 0.  "있으면

      ev_weight = ls_planetype-weight.
      ev_tankcap = ls_planetype-tankcap.
    ELSE.
      RAISE wrong_planetype.

    ENDIF.

  ENDMETHOD.

  METHOD class_constructor.
    SELECT  *
      INTO TABLE gv_planetypes
      FROM saplane.
  ENDMETHOD.

  METHOD constructor.

    DATA : ls_planetype TYPE saplane.
    mv_name = iv_name.
    mv_planetype = iv_planetype.

"요 부분을 get_technical 로 바꾼것
*    SELECT SINGLE * INTO ls_planetype
*            FROM saplane WHERE planetype = iv_planetype.
*    IF sy-subrc NE 0.
*      RAISE wrong_planetype.
**        write : / 'wrong type '.
*    ELSE.
*
*      mv_weight = ls_planetype-weight.
*      mv_tankcap = ls_planetype-tankcap.
    call method get_technical_attributes
          exporting
            iv_type = iv_planetype
          importing
            ev_weight = mv_weight
            ev_tankcap = mv_tankcap
          exceptions
            wrong_planetype = 1.

    if sy-subrc eq 0.
      gv_n_o_airplanes = gv_n_o_airplanes + 1.
    else.

      RAISE wrong_planetype.
    endif.
*    ENDIF.



  ENDMETHOD.


  METHOD get_n_o_airplanes.
    rv_count = gv_n_o_airplanes .
  ENDMETHOD.

  METHOD set_attributes.

    mv_name = iv_name.
    mv_planetype = iv_planetype.

    gv_n_o_airplanes = gv_n_o_airplanes  + 1.
  ENDMETHOD.


  METHOD display_attributes.
    WRITE : / icon_ws_plane AS ICON ,
            / 'Name of airplane', AT c_pos_i mv_name,
            / 'Type of airplane', AT c_pos_i mv_planetype,
            / 'Weight/Tank capacity'          , AT c_pos_i mv_weight,  mv_tankcap.

  ENDMETHOD.

  METHOD display_n_o_airplanes.
    WRITE : / 'Number of Airplanes', AT c_pos_i gv_n_o_airplanes.
  ENDMETHOD.

ENDCLASS.

DATA : go_airplane TYPE REF TO  lcl_airplane.
DATA : gt_airplanes TYPE TABLE OF REF TO lcl_airplane.


START-OF-SELECTION.

  CALL METHOD lcl_airplane=>display_n_o_airplanes.
*  lcl_airplane=>display_n_o_airplanes( ).


  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'LH Berlin'
      iv_planetype    = 'A321'
    EXCEPTIONS
      wrong_planetype = 1.


  IF sy-subrc EQ 0.


*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'LH Berlin'
*      iv_planetype = 'A321'.


    APPEND go_airplane TO gt_airplanes.

  ENDIF.



  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'AA New York'
      iv_planetype    = '747-400'
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc EQ 0.
    APPEND go_airplane TO gt_airplanes.
  ENDIF.


*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'AA New York'
*      iv_planetype = '747-400'.


  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'US Herculs'
      iv_planetype    = '747-200F'
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc EQ 0.
    APPEND go_airplane TO gt_airplanes.

  ENDIF.

*  CALL METHOD go_airplane->set_attributes
*    EXPORTING
*      iv_name      = 'US Herculs'
*      iv_planetype = '747-200F'.


  LOOP AT gt_airplanes INTO go_airplane.

    CALL METHOD go_airplane->display_attributes.
  ENDLOOP.

  DATA : gv_count TYPE i.

  gv_count = lcl_airplane=>get_n_o_airplanes( ).
  WRITE : / 'Number of airplane',  gv_count.
