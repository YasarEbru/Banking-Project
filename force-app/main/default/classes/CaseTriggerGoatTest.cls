@isTest
public class CaseTriggerGoatTest {
  @isTest
    static void testCaseTrigger() {
        // Test verilerini oluşturalım
        Case testCase = new Case(
            Subject = 'Test Case',
            Description = 'Bu bir test case\'dir.'
        );
        // Tetikleyiciyi çağıralım
        Test.startTest();
        insert testCase;
        Test.stopTest();
        // Tetikleyici tarafından yapılan işlem sonuçlarını kontrol edelim
        // Örneğin, bir sorgu kullanarak ilgili kaydın güncellendiğini veya beklenen sonuçların gerçekleştiğini doğrulayabilirsiniz.
        Case updatedCase = [SELECT Id, ParentId FROM Case WHERE Id = :testCase.Id];
    }
}