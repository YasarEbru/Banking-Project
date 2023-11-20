@isTest
public class CaseTriggerHandlerGoatTest {
    @isTest
    static void testUpdateParentId() {
        // Test verilerini hazırlayın (örneğin, Case kayıtları oluşturun)
        Account testAccount1 = new Account(Name = 'Test Account 1');
        insert testAccount1;
        Case newCase1 = new Case(Origin = 'Phone', AccountId = testAccount1.Id);
        insert newCase1;
        Case newCase2 = new Case(Origin = 'Phone', AccountId = testAccount1.Id);
        insert newCase2;
        // CaseTriggerHandler.UpdateParentId metodunu çağırın
        List<Case> newCaseTriggered = new List<Case>{newCase1, newCase2};
        CaseTriggerHandlerGoat.UpdateParentId(newCaseTriggered);
        // ParentId alanlarının güncellendiğini ve farklı olduğunu kontrol edin
        newCase1 = [SELECT ParentId FROM Case WHERE Id = :newCase1.Id];
        newCase2 = [SELECT ParentId FROM Case WHERE Id = :newCase2.Id];
    }
}