*&---------------------------------------------------------------------*
*& Report ZBC401_T03_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a05_demo_v2.

CLASS lcl_vehicle DEFINITION.

  PUBLIC SECTION.
    METHODS :
      set_attributes
        IMPORTING iv_make  TYPE s_make
                  iv_model TYPE s_model,
      display_attributes.

    METHODS :
      constructor IMPORTING  iv_make  TYPE s_make
                             iv_model TYPE s_model
                  EXCEPTIONS wrong_type.

    CLASS-METHODS :
      display_n_o_vehicles,
      class_constructor.

    CLASS-METHODS :
      get_n_o_vehicles RETURNING VALUE(rv_count) TYPE i.  "direct 계산 가능

  PRIVATE SECTION.

    DATA  : mv_make  TYPE s_make,
            mv_model TYPE s_model.

    DATA : mv_tankcap TYPE svehicle-tankcap,
           mv_consum  TYPE svehicle-consum,
           mv_speed   TYPE svehicle-speed.

    TYPES : ty_veh_types TYPE STANDARD TABLE OF svehicle
                    WITH NON-UNIQUE KEY make model.

    CLASS-DATA : gt_veh_types TYPE ty_veh_types.

    CLASS-DATA : gv_n_o_vehicles TYPE i.
ENDCLASS.

CLASS lcl_vehicle IMPLEMENTATION.
  METHOD class_constructor.  "맨처음 실행하면
    SELECT * INTO TABLE gt_veh_types FROM svehicle.
  ENDMETHOD.

  METHOD constructor.

    DATA : ls_vehicle TYPE svehicle.

    SELECT SINGLE * INTO ls_vehicle FROM svehicle
             WHERE make = iv_make AND
                   model = iv_model.

    IF sy-subrc EQ 0.
      mv_make = ls_vehicle-make.
      mv_model = ls_vehicle-model.
      mv_tankcap = ls_vehicle-tankcap.
      mv_consum  = ls_vehicle-consum.
      mv_speed   = ls_vehicle-speed.
      gv_n_o_vehicles = gv_n_o_vehicles   + 1.
    ELSE.
      RAISE wrong_type.
    ENDIF.
  ENDMETHOD.

  METHOD get_n_o_vehicles.
    rv_count = gv_n_o_vehicles.
  ENDMETHOD.

  METHOD set_attributes.

    mv_make = iv_make.
    mv_model = iv_model.

    gv_n_o_vehicles = gv_n_o_vehicles + 1.
  ENDMETHOD.

  METHOD display_attributes.
    WRITE : / 'Make', mv_make,
            / 'Model', mv_model.
  ENDMETHOD.

  METHOD display_n_o_vehicles.
    WRITE : / 'Number of vehicles : ', gv_n_o_vehicles.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.
    METHODS : display_attributes REDEFINITION,
      constructor IMPORTING iv_make  TYPE s_make
                            iv_model TYPE s_model
                            iv_cargo TYPE s_plan_car.


  PRIVATE SECTION.
    DATA : mv_cargo TYPE s_plan_car.
ENDCLASS.

CLASS lcl_truck IMPLEMENTATION.
  METHOD constructor.

    super->constructor( exporting iv_make = iv_make
                                   iv_model = iv_model
                         exceptions
                                   wrong_type = 1 ).


    mv_cargo = iv_cargo.

  ENDMETHOD.

  METHOD display_attributes.
    super->display_attributes( ).
    WRITE : / 'Max.Cargo:', mv_cargo.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.
    METHODS :  constructor  IMPORTING  iv_make  TYPE s_make
                                       iv_model TYPE s_model
                                       iv_seats TYPE s_seatsmax
                            EXCEPTIONS
                                       wrong_type,
      display_attributes REDEFINITION.

  PRIVATE SECTION.
    DATA  : mv_seats TYPE s_seatsmax.

ENDCLASS.

class lcl_bus IMPLEMENTATION.
   method constructor.
       super->constructor(
           EXPORTing iv_make = iv_make
                     iv_model = iv_model
           exceptions
               wrong_type = 1  ).
       if sy-subrc ne 0.
           raise wrong_type.
        endif.
        mv_seats = iv_seats.
   ENDMETHOD.

   method display_attributes.
      super->display_attributes( ).
      write : / 'Seats: ', mv_seats.

   ENDMETHOD.
ENDCLASS.



DATA : go_vehicle1 TYPE REF TO lcl_vehicle,
       go_vehicle2 LIKE go_vehicle1.

DATA : go_vehicle  TYPE REF TO lcl_vehicle,
       gt_vehicles TYPE TABLE OF REF TO lcl_vehicle.

DATA : gv_n_o_vehicles TYPE i.

START-OF-SELECTION.

*create OBJECT : go_vehicle1, go_vehicle2.

*create OBJECT : go_vehicle1.
*go_vehicle2 = go_vehicle1.
  lcl_vehicle=>display_n_o_vehicles( ).

  CREATE OBJECT go_vehicle
    EXPORTING
      iv_make    = 'AUDI'
      iv_model   = 'A3'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc EQ 0.
    APPEND go_vehicle TO gt_vehicles.
  ENDIF.

  CREATE OBJECT go_vehicle
    EXPORTING
      iv_make    = 'BMW'
      iv_model   = '3051'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc EQ 0.
    APPEND go_vehicle TO gt_vehicles.
  ENDIF.

  CREATE OBJECT go_vehicle
    EXPORTING
      iv_make    = 'FORSCHE'
      iv_model   = '911'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc EQ 0.
    APPEND go_vehicle TO gt_vehicles.
  ENDIF.


*  go_vehicle->set_attributes( iv_make = 'AUDI'
*                              iv_model = 'A3' ).
*
*  APPEND go_vehicle TO gt_vehicles.
*
*
*
*  CREATE OBJECT go_vehicle.
*
*  go_vehicle->set_attributes( iv_make = 'BMW'
*                             iv_model = '3051' ).
*
*
*  APPEND go_vehicle TO gt_vehicles.
*
*
*  CREATE OBJECT go_vehicle.
*
*  go_vehicle->set_attributes( iv_make = 'FORSCHE'
*                           iv_model = '911' ).
*
*  APPEND go_vehicle TO gt_vehicles.


  LOOP AT gt_vehicles INTO go_vehicle.

    go_vehicle->display_attributes( ).
  ENDLOOP.

*  lcl_vehicle=>display_n_o_vehicles( ).   version 1.

  gv_n_o_vehicles = lcl_vehicle=>get_n_o_vehicles( ).
  WRITE : / 'Number of vehicles : ', gv_n_o_vehicles.
