*&---------------------------------------------------------------------*
*& Report ZSSA05_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zssa05_34.

"Dep Info
DATA gs_dep TYPE zssa0511.
DATA gt_dep LIKE TABLE OF gs_dep.

"Emp info (structure Variable).
DATA gs_emp LIKE LINE OF gs_dep-emp_list.

PARAMETERS pa_dep TYPE ztsa0502-depcd.

START-OF-SELECTION.
SELECT SINGLE *
  FROM ztsa0501
  INTO CORRESPONDING FIELDS OF gs_dep
 WHERE depcd = pa_dep.
