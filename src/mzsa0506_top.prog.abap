*&---------------------------------------------------------------------*
*& Include MZSA0514_TOP                             - Module Pool      SAPMZSA0514
*&---------------------------------------------------------------------*
PROGRAM sapmzsa0514.

"Condition
TABLES zssa0073.
DATA gs_cond TYPE zssa0073.

"employee Info
TABLES zssa0070.
DATA gs_emp TYPE zssa0071.

"dep info
TABLES zssa0071.
DATA gs_dep TYPE zssa0071.

"Radio Button
DATA: gv_r1      TYPE c LENGTH 1,
      gv_r2(1),
      gv_r3.
