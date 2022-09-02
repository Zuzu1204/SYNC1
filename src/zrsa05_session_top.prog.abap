*&---------------------------------------------------------------------*
*& Include ZRSA05_SESSION_TOP                       - Report ZRSA05_SESSION_01
*&---------------------------------------------------------------------*
REPORT zrsa05_session_01.

DATA: ls_data     TYPE zssa05_s01,
      lt_data     LIKE TABLE OF ls_data,
      ls_data_tmp LIKE ls_data,

      lv_loekz    TYPE eloek,
      lv_statu    TYPE astat,

      lv_bpumz    TYPE ekpo-bpumz,
      lv_bpumn    TYPE ekpo-bpumn,

      lv_loekz2   LIKE lv_loekz,
      lv_statu2   LIKE lv_statu,
      lv_bpumz2   LIKE lv_bpumz,
      lv_bpumn2   LIKE lv_bpumn.

ls_data-bukrs = 'c001'.
ls_data-belnr = 'a001'.
APPEND ls_data TO lt_data.
CLEAR ls_data.

ls_data-bukrs = 'c002'.
ls_data-belnr = 'a002'.
APPEND ls_data TO lt_data.
CLEAR ls_data.

ls_data-bukrs = 'c003'.
ls_data-belnr = 'a003'.
APPEND ls_data TO lt_data.
CLEAR ls_data.

*DATA : ls_data2 TYPE zssa05_s01,
*       lt_data2 LIKE TABLE OF ls_data2 WITH HEADER LINE.

DATA lt_data2 LIKE lt_data WITH HEADER LINE.

lt_data2-bukrs = 'c010'.
lt_data2-belnr = 'a010'.
APPEND lt_data2.
CLEAR lt_data2.

lt_data2-bukrs = 'c011'.
lt_data2-belnr = 'a011'.
APPEND lt_data2.
CLEAR lt_data2.

cl_demo_output=>display_data( lt_data2[] ).
