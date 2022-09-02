*&---------------------------------------------------------------------*
*& Report ZRSA05_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa05_22.

TYPES: BEGIN OF gs_info,
        carrid TYPE spfli-carrid,
        carrname TYPE scarr-carrname,
        connid TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto TYPE spfli-cityto,
       END OF gs_info.

*DATA gt_info TYPE TABLE OF gs_info.
*
*PARAMETERS: code_st TYPE c LENGTH 3,
*            code_fin TYPE c LENGTH 3.
*
*SELECT carrid connid cityfrom cityto
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF gt_info
*  WHERE carrid BETWEEN code_st AND code_fin.
*
*select single carrname
*  from scarr
*  into gs_info-carrname
*  where carrid = gt_info-carrid.
