public class OpportunityTriggerHandler {
    public Static void updateNewTaskForWonOpp(List<Opportunity>oppList , Map<Id,Opportunity> oppOldMap){
        
    List<Task>taskList= new List<Task>();
       
        for(Opportunity opp :oppList){
            if(opp.StageName=='Closed Won' && oppOldMap.get(opp.Id).StageName != 'Closed Won'){
                Task newT=new Task(Subject='Follow Up Task',
                                  WhatId=opp.Id,
                                  OwnerId=opp.OwnerId,
                                  ActivityDate=opp.CloseDate.addMonths(1));
                taskList.add(newT);
                if(String.isBlank(opp.AccountId)){
                    opp.AccountId.addError('Closed won opportunity should be associated with a specific Account');
                }
            }
        }
        if(taskList.size()>0){
            insert taskList;
        }
        
                                                  
                                                  
        
    }
}