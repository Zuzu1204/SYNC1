@AbapCatalog.sqlViewName: 'ZC105CDS0003_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[C1] Fake Standard table'
define view ZC105CDS0003 as select from ztsa0511
{
    bukrs,
    belnr,
    gjahr,
    buzei,
    bschl
}
