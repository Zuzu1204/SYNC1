*&---------------------------------------------------------------------*
*& Include          YCL105_001_CLS
*&---------------------------------------------------------------------*

*ALV
*1. LIST
*    ㄴ WRITE
*2. Functional ALV
*    ㄴ reuse
*3. Class ALV
*    ㄴ Simple ALV ( 단점 : 편집불가 , 그래서 실무에서는 쓰지 않음 )
*    ㄴ Grid ALV (실무에서 대다수 사용)
*    ㄴ ALV with IDA ( 최신, 가장어려움 )

*Container
*1. Custom Container
*2. Docking Container
*    ㄴ스크린에 그리지 않아도 언제든지 추가가능, 언제든지 내가 화면에 이벤트 추가가능
*3. Splitter Container
*    ㄴ 독자적으로 생성불가, 이미 있는 container를 쪼개줌

DATA : gr_con     TYPE REF TO cl_gui_docking_container,
       gr_split   TYPE REF TO cl_gui_splitter_container,
       gr_con_top TYPE REF TO cl_gui_container,
       gr_con_alv TYPE REF TO cl_gui_container.

DATA : gr_alv     TYPE REF TO cl_gui_alv_grid,
       gs_layout  TYPE lvc_s_layo,
       gt_fcat    TYPE lvc_t_fcat,
       gs_fcat    TYPE lvc_s_fcat,
       gs_variant TYPE disvariant,
       gv_save    TYPE c.
