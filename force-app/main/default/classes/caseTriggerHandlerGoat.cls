public class caseTriggerHandlerGoat{
    public static void UpdateParentId(List<Case> newCaseTriggered){
         Set<String> newOrigins = new Set<String>();
    for (Case newCase : newCaseTriggered) {
        newOrigins.add(newCase.Origin);
        newOrigins.add (newCase.AccountId);
    }
    // Aynı origin'e sahip eski case'leri bulma
    List<Case> oldCases = [SELECT Id, Origin, ParentId, AccountId FROM Case WHERE Origin IN :newOrigins AND AccountId IN :newOrigins ORDER BY CreatedDate DESC LIMIT 1];
    // Eşleşen eski case'leri yeni case'in Parent Case'i olarak güncelleme
    List<Case> casesToUpdate = new List<Case>();
    for (Case oldCase : oldCases) {
        for (Case newCase : newCaseTriggered) {
            if (oldCase.Origin == newCase.Origin && oldCase.Id != newCase.Id) {
                newCase.ParentId = oldCase.Id;
                casesToUpdate.add(oldCase);
            }
        }
    }
    // Eski case'leri güncelleme
    update casesToUpdate;
    }
}