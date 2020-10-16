public class OpportunityTriggerHelper {
    public static List<Opportunity> setNameToAccountName(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : opportunities) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Account> accountById = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :accountIds]);

        for (Opportunity opp : opportunities) {
            opp.Name = accountById.get(opp.AccountId).Name;
        }
        return opportunities;
    }
}
