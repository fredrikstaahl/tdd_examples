@IsTest
public class OpportunityTriggerHelperTest {
    @IsTest
    static void testSetNameToAccountName() {
        String accountName = 'MyTestAccount';

        Account acc = new Account(Name = accountName);
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'MyTestOpp',
            StageName = 'Prospecting',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30)
        );

        Opportunity oppAfterUpdate = OpportunityTriggerHelper.setNameToAccountName(new List<Opportunity>{ opp })[0];
        System.assertEquals(accountName, oppAfterUpdate.Name, 'Opportunity should have same name as Account');
    }
}
