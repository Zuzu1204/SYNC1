*&---------------------------------------------------------------------*
*& Report YCL105_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl105_001.

INCLUDE ycl105_001_top.             " 전역변수 선언
INCLUDE ycl105_001_cls.             " ALV 관련 선언
INCLUDE ycl105_001_scr.             " 검색화면
INCLUDE ycl105_001_pbo.             " Process Before Output
INCLUDE ycl105_001_pai.             " Process After Input
INCLUDE ycl105_001_f01.             " Subroutines

INITIALIZATION.   "프로그램 실행 시 가장 처음에 1회만 수행되는 이벤트 구간
  textt01 = '검색조건'.

AT SELECTION-SCREEN OUTPUT.
  "검색화면에서 화면이 출력되기 직전에 수행되는 구간
  "주용도는 검색화면에 대한 제어( 특정필드 숨김 또는 읽기 전용 ) ex)라디오버튼 눌러서 화면 숨기기

AT SELECTION-SCREEN.
  "검색화면에서 사용자가 특정 이벤트를 발생시켰을 때 수행되는 구간
  "주로 상단의 Function key 이벤트, 특정필드의 클릭, 엔터 등의 이벤트에서
  "입력값에 대한 점검, 실행 권한 점검

START-OF-SELECTION.
  "검색화면에서 실행버튼 눌렀을 때 수행되는 구간
  "주용도는 데이터 조회 & 출력
  PERFORM select_data.

END-OF-SELECTION.
  "START-OF-SELECTION 이 끝나고 실행되는 구간
  "주용도 데이터 출력

  IF gt_scarr[] IS INITIAL.
    MESSAGE '데이터가 없습니다.' TYPE 'S' DISPLAY LIKE 'W'.
  ELSE.
    CALL SCREEN 0100.
  ENDIF.
