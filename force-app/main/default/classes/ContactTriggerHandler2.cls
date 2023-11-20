public class ContactTriggerHandler2 {
    public static void updateNumberOfContacts(List<Contact> contactedTriggered){
        Set<Id> accIds = new Set<Id>();
        for(Contact w : contactedTriggered){
            if(w.Active__c == true || w.Active__c == false){// w.Active__c == false olmadan da calışıyor
                accIds.add(w.AccountId);
            }
        }
        if(!accIds.isEmpty()){
            List<Account> accountsToUpdate = [SELECT Id, (SELECT Id FROM Contacts WHERE Active__c = true) FROM Account WHERE Id=:accIds];//WHERE Id=:accIds bu kısım olmadan da calışıyor
        //Account un icindeki Idler ile contact'ın icindeki Idleri sorgulama yapılıyor
            for(Account acc : accountsToUpdate){
                acc.Active_Contacts__c = acc.contacts.size();
            }
            update accountsToUpdate;
        }
    }
      public static void deleteNumberOfContacts(List<Contact> contactsDelete) {
        List<Id> accIds = new List<Id>();
          //Set<Id> accIds = new Set<Id>();
        for (Contact conDelete : contactsDelete) {
            if (conDelete.Active__c == true && conDelete.AccountId != null) {
               accIds.add(conDelete.AccountId);
            }
        }
        List<Account> accList =[SELECT Id, (SELECT Id FROM Contacts WHERE Active__c = true)  FROM Account ];//WHERE Id IN :accIds olmadan calısıyor
            for (Account acc : accList) {
               acc.Active_Contacts__c = acc.contacts.size();
            }
            update accList;
      }
}