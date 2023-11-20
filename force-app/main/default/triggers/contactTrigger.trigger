trigger contactTrigger on Contact (after insert ,after update , after delete ,after undelete) {
    switch on Trigger.operationType{
        when AFTER_INSERT {
            contactTriggerHandler.accountActiveContacts(Trigger.new);
        }
        when AFTER_UNDELETE {
           contactTriggerHandler.accountActiveContacts(Trigger.new);
           
        }
        when AFTER_DELETE{
            contactTriggerHandler.accountActiveContacts(Trigger.old);
        }
        when AFTER_UPDATE {
            contactTriggerHandler.updateActiveContacts(Trigger.new,Trigger.oldMap);
        }
    }

}