@isTest
public class TestGoatOppTriggerHandler {
    @isTest
    static void testOppClosedWonTask() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = testAccount.Id,
            OwnerId = UserInfo.getUserId()
        );
        insert testOpportunity;
        testOpportunity.StageName = 'Closed Won';
        update testOpportunity;
        List<Task> createdTasks = [SELECT Subject, ActivityDate, WhatId, OwnerId FROM Task WHERE WhatId = :testOpportunity.Id];
        System.assertEquals(1, createdTasks.size(), 'Bir görev oluşturulmalıdır.');
        Task createdTask = createdTasks[0];
        System.assertEquals('Follow up Task', createdTask.Subject, 'Görev başlığı doğru değil.');
        System.assertEquals(testOpportunity.Id, createdTask.WhatId, 'Görev Opportunity ile ilişkilendirilmemiş.');
        System.assertEquals(testOpportunity.OwnerId, createdTask.OwnerId, 'Görev sahibi yanlış.');
        Date expectedDueDate = testOpportunity.CloseDate.addMonths(1);
        System.assertEquals(expectedDueDate, createdTask.ActivityDate, 'Görev tarihi yanlış.');
    }
}