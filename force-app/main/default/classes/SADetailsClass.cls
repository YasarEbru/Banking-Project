public with sharing class SADetailsClass {
    @AuraEnabled(cacheable=true)
    public static List<SA_Details__c> getDetails() {   

               List <SA_Details__c> SaList=[SELECT Id ,Name__c, Date_of_Joining__c, Customer_Handled__c, Experience__c FROM  SA_Details__c ];
               return SaList;
           } 
   
            @AuraEnabled(cacheable=true)
     public static List <SA_Details__c>getNames(string filter){//burda JS te belirledigimiz filter kelimesini parametre olarak yazdik
        String keyName ='%'+ filter +'%';
        List <SA_Details__c> nameList=[SELECT Id ,Name__c FROM  SA_Details__c WHERE Name LIKE :keyName];
        return nameList;
    } 
       
}