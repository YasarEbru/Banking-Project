public class LeadSourceToManual implements Database.Batchable<sObject> ,Database.Stateful, Schedulable {
    public integer count =0;
    public Database.QueryLocator start(Database.BatchableContext lsm){
        return Database.getQueryLocator('SELECT Id,Name,LeadSource FROM Lead WHERE LeadSource=null');
    }
    public void execute(Database.BatchableContext lsm , List<Lead>leadList){
        for(Lead w:leadList){
            if(w.LeadSource==null){
           w.LeadSource='Manual';
                count++;
            }
        }
        update leadList;
        System.debug(count +' record has been updated');
        
    }
    public void finish(Database.BatchableContext lsm){
        System.debug('Batch finished :' + count +'record has ben updated.');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        //to Addresses
        List<String> toEmails = new List<String>{'ebruyas28@gmail.com'};
        email.setToAddresses(toEmails);
        //subject2
        email.setSubject('Daily Lead Source Update');
        // body
        email.setPlainTextBody('Hello,' + '\n'
                               + 'The Lead Source value of the records whose Lead Source is empty has been updated to Manual' + '\n'
                               +'The Batch has completed processing all records :'+count+'\n'
                               +  'Regards ');
        List<Messaging.SingleEmailMessage> listMails = new List<Messaging.SingleEmailMessage>();
        listMails.add(email);
        messaging.sendEmail(listMails);
    }
    public void execute (SchedulableContext m){
        LeadSourceToManual daily =new LeadSourceToManual();
        Database.executeBatch(daily);
    }
    
    /*Anonymous Windows Kodlari
    LeadSourceToManual abc=new LeadSourceToManual();
    Database.executeBatch(abc);
    LeadSourceToManual abc=new LeadSourceToManual();
    String cronExp='0 30 23 ? * * ;
    System.schedule('Lead Source to Manual Notify Scheduler' , cronExp ,daily)
    */
    
    
}