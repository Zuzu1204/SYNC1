*&---------------------------------------------------------------------*
*& Include ZBC405_A05_2TOP                          - Module Pool      ZBC405_A05_2
*&---------------------------------------------------------------------*
REPORT zbc405_a05_2.

TABLES dv_flights.

DATA: gs_flt TYPE dv_flights,
      gt_flt LIKE TABLE OF gs_flt.



SELECT-OPTIONS: so_car FOR gs_flt-carrid MEMORY ID car,
                so_con FOR gs_flt-connid,
                so_date FOR gs_flt-fldate NO-EXTENSION.


PARAMETERS: p_rad1 RADIOBUTTON GROUP rd1,
            p_rad2 RADIOBUTTON GROUP rd1,
            p_rad3 RADIOBUTTON GROUP rd1.
