*&---------------------------------------------------------------------*
*& Report ZSSA05_33
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zssa05_33.

DATA gs_dep TYPE zssa0506.

"emp info
DATA: gt_emp TYPE TABLE OF zssa0505,
      gs_emp LIKE LINE OF gt_emp.

PARAMETERS pa_dep TYPE ztsa0502-depcd.

START-OF-SELECTION.
SELECT SINGLE *
  FROM ztsa0502
  INTO CORRESPONDING FIELDS OF gs_dep
  WHERE depcd = pa_dep.

  cl_demo_output=>display_data( gs_dep ).

SELECT *
  FROM ztsa0501
  INTO CORRESPONDING FIELDS OF TABLE gt_emp
  WHERE depcd = gs_dep-depcd.
cl_demo_output=>display_data( gt_emp ).
