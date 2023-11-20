public with sharing class SAManager {
    @AuraEnabled(cacheable=true scope='global')
    public static List<SA_Details__c> getSA() {
        return [SELECT Id,Name,Name__c,Experience__c,Customer_handled__c,Date_of_Joining__c,Specialization__c,Gender__c FROM SA_Details__c];

    }
    @AuraEnabled(cacheable=true scope='global')
    public static SA_Details__c[] searchSas(String searchTerm){
        searchTerm=searchTerm.trim();
        if(searchTerm=='') {
            return getSA();
        }
        searchTerm= '%' + searchTerm  +'%';
        
        return [SELECT 
        Id,
        Name,
        Name__c,
        Experience__c,
        Customer_handled__c,
        Date_of_Joining__c,
        Specialization__c,
        Location__Longitude__s,
        Location__Latitude__s
        FROM SA_Details__c
        WHERE Name__c LIKE :searchTerm
        WITH SECURITY_ENFORCED 
        ORDER BY Name__c 
        LIMIT 50
        ];

    }
}