trigger CaseTriggerGoat on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
    caseTriggerHandlerGoat.UpdateParentId(Trigger.new);
    }
}