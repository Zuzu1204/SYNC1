*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA0503........................................*
TABLES: ZVSA0503, *ZVSA0503. "view work areas
CONTROLS: TCTRL_ZVSA0503
TYPE TABLEVIEW USING SCREEN '0010'.
DATA: BEGIN OF STATUS_ZVSA0503. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA0503.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA0503_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA0503.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0503_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA0503_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA0503.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0503_TOTAL.

*...processing: ZVSA0504........................................*
TABLES: ZVSA0504, *ZVSA0504. "view work areas
CONTROLS: TCTRL_ZVSA0504
TYPE TABLEVIEW USING SCREEN '0020'.
DATA: BEGIN OF STATUS_ZVSA0504. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA0504.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA0504_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA0504.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0504_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA0504_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA0504.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA0504_TOTAL.

*...processing: ZVSA05PRO.......................................*
TABLES: ZVSA05PRO, *ZVSA05PRO. "view work areas
CONTROLS: TCTRL_ZVSA05PRO
TYPE TABLEVIEW USING SCREEN '0030'.
DATA: BEGIN OF STATUS_ZVSA05PRO. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA05PRO.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA05PRO_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA05PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA05PRO_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA05PRO_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA05PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA05PRO_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA0501                       .
TABLES: ZTSA0502                       .
TABLES: ZTSA0502_T                     .
TABLES: ZTSA05PRO                      .
TABLES: ZTSA05PRO_T                    .
