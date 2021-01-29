@AbapCatalog.sqlViewName: 'Z03I_TRAVEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Interface View'

@VDM.viewType: #BASIC

define view Z03_I_TRAVEL
  as select from z03_travel
  association[1] to D435_I_Customer as _Customer
  on $projection.Customer = _Customer.Customer 
{
  key agencynum as TravelAgency,
  key travelid  as TravelNumber,
      trdesc    as TravelDescription,
      customid  as Customer,
      stdat     as StartDate,
      enddat    as EndDate,
      status    as Status,
      changedat as ChangedAt,
      changedby as ChangedBy,
       _Customer
}
