@isTest
public class testCreateOppForAccountTest {
    @isTest
    static void testCreateOppForAccount() {
        // Create a test Account without any Opportunities
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        // Create a map with the test Account
        Map<Id, Account> accNewMap = new Map<Id, Account>();
        accNewMap.put(testAccount.Id, testAccount);
        // Call the createOppForAccount method
        Test.startTest();
        AccountTrigger23V2Handler.createOppForAccount(accNewMap);
        Test.stopTest();
        // Query Opportunities to check if a new Opportunity was created for the testAccount
        List<Opportunity> opportunitiesForAccount = [SELECT Id FROM Opportunity WHERE AccountId = :testAccount.Id];
        // Assert that only one Opportunity was created for the testAccount
        System.assertEquals(1, opportunitiesForAccount.size());
    }
}