*&---------------------------------------------------------------------*
*& Report ZRSA05_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_37.

DATA: gs_info TYPE zvsa0502, "database view: structure type
      gt_info LIKE TABLE OF gs_info.

*PARAMETERS pa_dep LIKE gs_info-depcd.

START-OF-SELECTION.
*SELECT *
*  FROM zvsa0502
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
* WHERE depcd = pa_dep.

*SELECT *
*  FROM ztsa0501 INNER JOIN ztsa0502
*    ON ztsa0501~depcd = ztsa0502~depcd
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
* WHERE ztsa0501~depcd = pa_dep.

*SELECT pernr ename a~depcd depno
*  FROM ztsa0501 AS a INNER JOIN ztsa0502 AS b
*    ON a~depcd = b~depcd
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
* WHERE a~depcd = pa_dep.








*SELECT *
*  FROM ztsa0501 AS emp INNER JOIN ztsa0502 AS dep
*    ON emp~depcd = dep~depcd
*   "and  "on 조건이 여러개일 때
*  INTO CORRESPONDING FIELDS OF TABLE gt_info.


"ztsa0501의 data는 모두 보이고 싶어
*SELECT *
*  FROM ztsa0501 AS emp LEFT OUTER JOIN ztsa0502 AS dep
*    ON emp~depcd = dep~depcd
*   "and  "on 조건이 여러개일 때
*  INTO CORRESPONDING FIELDS OF TABLE gt_info.
*

"부서는 다 나오게 하고싶어
* SELECT *
*   FROM ztsa0502 AS dep LEFT OUTER JOIN ztsa0501 AS emp
*     ON dep~depcd = emp~depcd
*   INTO CORRESPONDING FIELDS OF TABLE gt_info.

 SELECT *
   FROM ztsa0501 AS emp LEFT OUTER JOIN ztsa0502 AS dep
     ON emp~depcd = dep~depcd
   INTO CORRESPONDING FIELDS OF TABLE gt_info.

  cl_demo_output=>display_data( gt_info ).
