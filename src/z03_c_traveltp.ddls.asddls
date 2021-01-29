@AbapCatalog.sqlViewName: 'Z03C_TRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Consumption View'

@VDM.viewType: #CONSUMPTION
//@OData.publish: true

@Search.searchable: true

@ObjectModel: { 
    transactionalProcessingDelegated: true,
    semanticKey: ['TravelAgency', 'TravelNumber'],
    updateEnabled: true
}

@Metadata.allowExtensions: true
@OData.publish: true

define view Z03_C_TRAVELTP
  as select from Z03_I_TRAVELTP
  
{
  key TravelAgency,
  key TravelNumber,

      @Search: { defaultSearchElement: true,
                 fuzzinessThreshold: 0.8
               }

      TravelDescription,
      Customer,
      StartDate,
      EndDate,
      Status,
      ChangedAt,
      ChangedBy,
      _Customer   
}
