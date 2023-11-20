public class NewOrUpdateAccountHandler {
    public static void createOppforAccount(List<Account> accList){
        
        List<Opportunity>newOpp=new List<Opportunity>();
        
        for(Account w :accList){
            if(w.Opportunities==null || w.Opportunities.isEmpty()){
                
             Opportunity opp=new Opportunity();
                
            opp.Name=w.Name+' Opportunity';
            opp.StageName='Prospecting';
            opp.CloseDate=System.today().addMonths(1);
           opp.AccountId=w.Id;
            newOpp.add(opp);
            }  
            }        
        if(!newOpp.isEmpty()){
            insert newOpp;
        }
    }
}