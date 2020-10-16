/**
 * Opportunity trigger with update logic inside trigger.
 */
trigger Opportunity on Opportunity(before insert, before update, after insert, after update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : Trigger.New) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Account> accountById = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :accountIds]);

        for (Opportunity opp : Trigger.New) {
            opp.Name = accountById.get(opp.AccountId).Name;
        }
    }

}
