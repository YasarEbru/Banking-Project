public class AccountTrigger23V2Handler {
    public static void createOppForAccount(Map<Id, Account> accNewMap){
    List<Opportunity> oppList = new List<Opportunity>();
    for (Account elma : [SELECT Id, Name,
                     	(SELECT Id FROM Opportunities)
                     	FROM Account
                     	WHERE Id IN :accNewMap.keySet()]) {
    	if (elma.Opportunities.isEmpty()){
        	oppList.add(new Opportunity(Name=elma.Name + ' Opportunity',
                        				StageName='Prospecting',
                                   		CloseDate=System.today().addMonths(1),
                                   		AccountId=elma.Id));
        }
    }
        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }  
}