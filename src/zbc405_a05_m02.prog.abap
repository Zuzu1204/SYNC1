*&---------------------------------------------------------------------*
*& Report ZBC405_A05_M02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a05_m02_top                      .    " Global Data

* INCLUDE ZBC405_A05_M02_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A05_M02_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A05_M02_F01                      .  " FORM-Routines

*SELECT SINGLE pernr ename depid gender
*  FROM ztsa2001
*  INTO (gs_emp-pernr, gs_emp-gender)
* WHERE pernr = '20220001'.
*
* WRITE : '사원명', gs_emp-pernr.
* NEW-LINE.
* WRITE : 'ENAME : ', gs_emp-ename.
* NEW-LINE.
* WRITE : '부서코드 : ', gs_emp-depid.
* WRITE : /'성별 : ', gs_emp-gender.

"loop문
SELECT *
  FROM ztsa2001
  INTO CORRESPONDING FIELDS OF TABLE gt_emp.


*CLEAR gs_emp.
*LOOP AT gt_emp INTO gs_emp.  "loop at 다음에는 table 타입
*  "gs_emp를 바꾸는 로직
*  CASE gs_emp-gender.
*    WHEN '1'.
*      gs_emp-gender_t = '남성'.
*    WHEN '2'.
*      gs_emp-gender_t = '여성'.
*  ENDCASE.
*
*select single phone
*  from ztsa2002
*  into CORRESPONDING FIELDS OF gs_emp
* where depid = gs_emp-depid.
*
*
*MODIFY gt_emp FROM gs_emp.
*CLEAR gs_emp.
*ENDLOOP.


"readtable
"데이터베이스를 자주 건드리면 안되기 때문에 부서 테이블 전체를
"internal table로 넣어준다.
SELECT *
  from ztsa2002
  into CORRESPONDING FIELDS OF TABLE gt_dep
 where depid BETWEEN 'D001' and 'D003'.

LOOP AT gt_emp into gs_emp.
  read table gt_dep into gs_dep with key depid = gs_emp-depid.

  gs_emp-phone = gs_dep-phone.

MODIFY gt_emp from gs_emp.
clear : gs_emp, gs_dep.
ENDLOOP.


  cl_demo_output=>display_data( gt_emp ).
