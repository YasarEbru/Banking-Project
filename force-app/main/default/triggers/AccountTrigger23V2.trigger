trigger AccountTrigger23V2 on Account(after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
            AccountTrigger23V2Handler.createOppForAccount(Trigger.newMap);
    }
}