*&---------------------------------------------------------------------*
*& Include          ZET_0810_ALV_A00_TOP
*&---------------------------------------------------------------------*


DATA : gt_book TYPE TABLE OF sbook.
DATA : gs_book TYPE sbook.
DATA : ok_code LIKE sy-ucomm.

* --- ALV DATA DECLARATION ---- *
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv_grid  TYPE REF TO cl_gui_alv_grid.

DATA : gs_layout    TYPE lvc_s_layo,  " layout
       gt_fcat      TYPE lvc_t_fcat,  " field Catalog
       gs_fcat      TYPE lvc_s_fcat.



* --- SELECTION SCREEN ---- *
SELECT-OPTIONS : so_car FOR gs_book-carrid MEMORY ID car,
                 so_con FOR gs_book-connid MEMORY ID con,
                 so_dat FOR gs_book-fldate,
                 so_bid FOR gs_book-bookid.
