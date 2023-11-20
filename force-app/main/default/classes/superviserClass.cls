public with sharing class superviserClass {
    @AuraEnabled(cacheable=true)
    public static List<Contact>getsupervisers() {
      
       List<Contact> contList=[SELECT Id, Name ,Title ,AccountId ,Phone ,Email , MobilePhone , OwnerId,(SELECT Id ,Supervisor__c FROM SA_Details__r  ) FROM Contact ];
                return contList;


    }
}