trigger caseTrigger on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        caseTriggerHandler.updateCaseWithParentId (Trigger.new);
    }
}