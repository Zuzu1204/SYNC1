*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA05VEN.......................................*
TABLES: ZVSA05VEN, *ZVSA05VEN. "view work areas
CONTROLS: TCTRL_ZVSA05VEN
TYPE TABLEVIEW USING SCREEN '0010'.
DATA: BEGIN OF STATUS_ZVSA05VEN. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA05VEN.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA05VEN_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA05VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA05VEN_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA05VEN_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA05VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA05VEN_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA05VEN                      .
