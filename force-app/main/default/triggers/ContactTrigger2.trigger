trigger ContactTrigger2 on Contact (after insert,after update ,after delete ,after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert ||Trigger.isUpdate || Trigger.isUndelete){
            contactTriggerHandler2.updateNumberOfContacts(Trigger.new);
        }
        if(Trigger.isAfter && Trigger.isDelete){
            contactTriggerHandler2.deleteNumberOfContacts(Trigger.old);
        }
    }
}