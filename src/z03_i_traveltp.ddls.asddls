@AbapCatalog.sqlViewName: 'Z03I_TRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Transactional View'

@VDM.viewType: #TRANSACTIONAL

@ObjectModel: {
    modelCategory: #BUSINESS_OBJECT,
    compositionRoot: true,
    
    representativeKey: 'TravelNumber',
    semanticKey: ['TravelAGency', 'TravelNumber'],
    
    createEnabled: true,
    
    transactionalProcessingEnabled: true,
    updateEnabled: true,
   // writeActicePersistence: 'D435B_TRAVEL', 
    writeActivePersistence: 'Z03_V_TRAVEL'}
   
   

define view Z03_I_TRAVELTP
  as select from Z03_I_TRAVEL

{
    @ObjectModel.readOnly: true
  key TravelAgency,
    @ObjectModel.readOnly: true
  key TravelNumber,
      TravelDescription,
      
        @ObjectModel.mandatory: true
        @ObjectModel.foreignKey.association: '_Customer'
      Customer,
      
        @ObjectModel.mandatory: true
      StartDate,
      
        @ObjectModel.mandatory: true
      EndDate,
      
        @ObjectModel.readOnly: true
      Status,
      ChangedAt,
      ChangedBy,
      
      _Customer
}
