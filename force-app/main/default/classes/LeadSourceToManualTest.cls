@isTest
public class LeadSourceToManualTest {
    @isTest
    static void testBatchJob() {
        // Create test data - Lead records with null LeadSource
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            Lead lead = new Lead();
                lead.FirstName = 'New Lead' + i;
                lead.LastName = 'New Lead' + i;
                lead.LeadSource = null;
                lead.Company = 'Cotton';
            testLeads.add(lead);
        }
        insert testLeads;
        // Start the batch job
        Test.startTest();
        LeadSourceToManual batchJob = new LeadSourceToManual();
        Database.executeBatch(batchJob);
        Test.stopTest();
        // Verify that Lead records were updated
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testLeads];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Manual', lead.LeadSource);
           
        }
        // Verify that the email notification is sent
        List<EmailMessage> sentEmails = [SELECT Subject FROM EmailMessage WHERE Subject = 'Daily Lead Source Update'];
        System.assertEquals(1, sentEmails.size());
        //SchedulableContext
        String jobId = System.schedule('daily', '0 30 23 ? * *', new LeadSourceToManual());
    }
}