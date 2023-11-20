public with sharing class Story27 {
    @AuraEnabled(cacheable=true)
    public static List<SA_Details__c> getSADetails(){

      List<SA_Details__c> saList =[SELECT Id,Name__c,Customer_Handled__c,Date_of_Joining__c,Experience__c FROM SA_Details__c ];
     return saList;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<SA_Details__c> getNames(String filter){ 

      String keyName = '%' + filter + '%'; 
      List<SA_Details__c> nameList = [SELECT Id, Name__c FROM SA_Details__c WHERE Name__c LIKE :keyName];
      return nameList;
    }
}