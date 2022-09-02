*&---------------------------------------------------------------------*
*& Report ZBC401_T03_CL_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a05_cl_02.

INTERFACE intf.
  DATA : ch1 TYPE i,
         ch2 TYPE i.

  METHODS : met1.      "선언만 interface안에.. 구현은 class implementaion안에.
ENDINTERFACE.

CLASS cl1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.     "항상 public 에 선언.    "선은을 하면 class처럼 별도로 선언한 것이 됨
ENDCLASS.

CLASS cl1 IMPLEMENTATION.
  METHOD intf~met1.

    DATA : rel TYPE i.
    rel = intf~ch1 + intf~ch2.

    WRITE : / 'reuslt + :', rel.  "cㅣ1은 두개의 합의 결과를 보여준다.
  ENDMETHOD.
ENDCLASS.

CLASS cl2 DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.     "항상 public 에 선언.

    ALIASES multi_intf
        FOR intf~met1.

    ALIASES int_char1 FOR intf~ch1.
    ALIASES int_char2 FOR intf~ch2.
ENDCLASS.


CLASS cl2 IMPLEMENTATION.
  METHOD intf~met1.
    DATA : rel TYPE i.
*    rel = intf~ch1 * intf~ch2.
    rel = int_char1 * int_char2.

    WRITE : / 'reuslt * :', rel.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA : clobj TYPE REF TO cl1.

  CREATE OBJECT clobj.

  clobj->intf~ch1 = 10.
  clobj->intf~ch2 = 20.

  CALL METHOD clobj->intf~met1.


  DATA : clobj1 TYPE REF TO cl2.

  CREATE OBJECT clobj1.


  clobj1->intf~ch1 = 10.
  clobj1->intf~ch2 = 20.

*  CALL METHOD clobj1->intf~met1.
  CALL METHOD clobj1->multi_intf. "use Aliases
