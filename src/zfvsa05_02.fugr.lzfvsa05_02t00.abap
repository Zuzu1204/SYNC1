*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZSAPLANE_A05....................................*
DATA:  BEGIN OF STATUS_ZSAPLANE_A05                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSAPLANE_A05                  .
CONTROLS: TCTRL_ZSAPLANE_A05
            TYPE TABLEVIEW USING SCREEN '0040'.
*...processing: ZSCARR_A05......................................*
DATA:  BEGIN OF STATUS_ZSCARR_A05                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSCARR_A05                    .
CONTROLS: TCTRL_ZSCARR_A05
            TYPE TABLEVIEW USING SCREEN '0010'.
*...processing: ZSFLIGHT_A05....................................*
DATA:  BEGIN OF STATUS_ZSFLIGHT_A05                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSFLIGHT_A05                  .
CONTROLS: TCTRL_ZSFLIGHT_A05
            TYPE TABLEVIEW USING SCREEN '0020'.
*...processing: ZSPFLI_A05......................................*
DATA:  BEGIN OF STATUS_ZSPFLI_A05                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSPFLI_A05                    .
CONTROLS: TCTRL_ZSPFLI_A05
            TYPE TABLEVIEW USING SCREEN '0030'.
*.........table declarations:.................................*
TABLES: *ZSAPLANE_A05                  .
TABLES: *ZSCARR_A05                    .
TABLES: *ZSFLIGHT_A05                  .
TABLES: *ZSPFLI_A05                    .
TABLES: ZSAPLANE_A05                   .
TABLES: ZSCARR_A05                     .
TABLES: ZSFLIGHT_A05                   .
TABLES: ZSPFLI_A05                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
