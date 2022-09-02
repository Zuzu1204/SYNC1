*&---------------------------------------------------------------------*
*& Include ZRSA05_50_TOP                            - Report ZRSA05_50
*&---------------------------------------------------------------------*
REPORT zrsa05_50.
TABLES: sflight. "tables뒤에는 일반적인 구조를 가지고 있는 structures type
" DATA scarr TYPE scarr.

PARAMETERS: pa_car TYPE scarr-carrid,
            pa_con TYPE spfli-connid.

SELECT-OPTIONS so_dat FOR sflight-fldate. "for만 되고, 그 뒤에는 변수만 가능
