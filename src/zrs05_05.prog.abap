*&---------------------------------------------------------------------*
*& Report ZRS05_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrs05_05.

WRITE 'First Name'(t02).

WRITE 'Name'(t02).


*CONSTANTS gc_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
*
*WRITE gc_ecode.
*gc_ecode = 'Test'.



*TYPES t_name TYPE c LENGTH 20.
*
*DATA gv_name TYPE t_name.
*DATA gv_cname TYPE t_name.

*DATA: gv_name TYPE c LENGTH 20,
*      gv_cname LIKE gv_name.

*DATA: gv_n1 TYPE n,
*      gv_n2 TYPE n LENGTH 2,
*      gv_i TYPE i.
*
*WRITE: gv_n1, gv_n2, gv_i.


*DATA: gv_c1 TYPE c LENGTH 1,
*      gv_c2(1) TYPE c,
*      gv_c3 TYPE c,
*      gv_c4.


*DATA gv_d1 TYPE d.
*DATA gv_d2 TYPE sy-datum.
*
*WRITE: gv_d1, gv_d2.
