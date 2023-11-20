public class caseTriggerHandler {
    public static void updateCaseWithParentId(List<Case>newCases){
        Set<Id> SetAccount=new Set<Id>();
        List<Case>caseList=new List<Case>();
        Map <Id,List<Case>> accountToCase = new Map<Id ,List<Case>>();
        
        for(Case c :newCases){
            if(c.AccountId!=null){
                SetAccount.add(c.AccountId);
            }
            List<Account>accountList=[SELECT Id,(SELECT Origin ,ParentId,AccountId FROM Cases ORDER BY CreatedDate DESC)
                                     FROM Account WHERE Id IN :SetAccount];
            for(Account a: accountList){
                accountToCase.put(a.Id, a.Cases);
            }
            for(Case p : newCases){
                if(p.AccountId !=null){
                    for(Case oldCase :accountToCase.get(p.AccountId)){
                        if(p.Origin==oldCase.Origin && (p.Id!=oldCase.Id)){
                            p.ParentId=oldCase.Id;
                            caseList.add(p);
                            break;
                        }
                    }
                }
            }
        }
    }
}