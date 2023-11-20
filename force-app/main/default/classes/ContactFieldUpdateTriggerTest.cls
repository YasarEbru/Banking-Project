@isTest
public class ContactFieldUpdateTriggerTest {
@isTest
    static void testContactTrigger() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = testAccount.Id
        );
        insert testContact;
        Test.startTest();
        Contact newContact = new Contact(
            FirstName = 'Jane',
            LastName = 'Smith',
            AccountId = testAccount.Id
        );
        insert newContact;
        newContact.LastName = 'Doe';
        update newContact;
        delete newContact;
        undelete newContact;
        Test.stopTest();
    }
}