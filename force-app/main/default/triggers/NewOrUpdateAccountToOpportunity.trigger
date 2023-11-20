trigger NewOrUpdateAccountToOpportunity on Account(after insert,after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
       NewOrUpdateAccountHandler.createOppforAccount(Trigger.new); 
    }
 
}