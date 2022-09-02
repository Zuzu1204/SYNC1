@AbapCatalog.sqlViewAppendName: 'ZC105EXT0003_V'
@EndUserText.label: '[C1] Fake Standard table Extend'
extend view ZC105CDS0003 with ZC105EXT0003 
{
   ztsa0511.zzsaknr,
   ztsa0511.zzkostl,
   ztsa0511.zzshkzg,
   ztsa0511.zzlgort
}
