*&---------------------------------------------------------------------*
*& Include ZBC405_A05_M02_TOP                       - Report ZBC405_A05_M02
*&---------------------------------------------------------------------*
REPORT zbc405_a05_m02.

*ZTSA2001

TYPES : BEGIN OF ts_emp,
          pernr TYPE ztsa2001-pernr,
          ename TYPE ztsa2001-ename,
          depid TYPE ztsa2001-depid,
          gender TYPE ztsa2001-gender,
          gender_t type c LENGTH 10,
          phone type ztsa2002-phone,
        END OF ts_emp.

DATA : gs_emp TYPE ts_emp,
       gt_emp LIKE TABLE OF gs_emp,
       gs_dep type ztsa2002,
       gt_dep like table of gs_dep.
