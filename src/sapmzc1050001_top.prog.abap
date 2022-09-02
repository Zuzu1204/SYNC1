*&---------------------------------------------------------------------*
*& Include SAPMZC1050001_TOP                        - Module Pool      SAPMZC1050001
*&---------------------------------------------------------------------*
PROGRAM sapmzc1050001 MESSAGE-ID zmcsa05.

DATA : BEGIN OF gs_data,
         matnr TYPE ztsa0510-matnr,  "Mateiral
         werks TYPE ztsa0510-werks,  "Plant
         mtart TYPE ztsa0510-mtart,  "Mat. Type
         matkl TYPE ztsa0510-matkl,  "Mat. Group
         menge TYPE ztsa0510-menge,  "Quantity
         meins TYPE ztsa0510-meins,  "Unit
         dmbtr TYPE ztsa0510-dmbtr,  "Price
         waers TYPE ztsa0510-waers,  "Currency
       END OF gs_data,

       gv_okcode TYPE sy-ucomm,
       gt_data   LIKE TABLE OF gs_data.

*ALV 관련
DATA : gcl_container TYPE REF TO cl_gui_custom_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant.
