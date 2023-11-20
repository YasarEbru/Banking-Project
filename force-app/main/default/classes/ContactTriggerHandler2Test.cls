@isTest
public class ContactTriggerHandler2Test {
    @isTest
    static void testUpdateNumberOfContacts() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Doe', Active__c = true, AccountId = testAccount.Id);
        insert testContact;
        List<Contact> contactsToUpdate = new List<Contact>{testContact};
        ContactTriggerHandler2.updateNumberOfContacts(contactsToUpdate);
        Account updatedAccount = [SELECT Active_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1, updatedAccount.Active_Contacts__c);
    }
    @isTest
    static void testDeleteContact() {
        // Test senaryosunu burada tanımlayın
        // Test verilerini hazırlayın (örneğin, bir Contact kaydı ve ilgili Account kaydı oluşturun)
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'Jane', LastName = 'Smith', Active__c = true, AccountId = testAccount.Id);
        insert testContact;
        // ContactFieldUpdateTrigger tetikleyicisini manuel olarak başlatın (örneğin, bir Contact kaydını silin)
        Test.startTest();
        delete testContact;
        Test.stopTest();
        // Sonuçları doğrulayın (Account veya Contact kayıtlarının güncellendiğini kontrol edin)
        // Örneğin, güncellenen bir Account veya Contact kaydını sorgulayarak doğrulama yapabilirsiniz
        Account updatedAccount = [SELECT Active_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(0, updatedAccount.Active_Contacts__c);
    }
}