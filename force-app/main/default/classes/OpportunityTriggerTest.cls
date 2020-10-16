@IsTest
public class OpportunityTriggerTest {
    @IsTest
    static void testSetAccountNameAsOpportunityName() {
        String accountName = 'MyTestAccount';

        Test.startTest();
        Account acc = new Account(Name = accountName);
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'MyTestOpp',
            StageName = 'Prospecting',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30)
        );
        insert opp;
        Test.stopTest();

        Opportunity oppAfterInsert = [SELECT Name FROM Opportunity WHERE Id = :opp.Id LIMIT 1];
        System.assertEquals(accountName, oppAfterInsert.Name, 'Opportunity should have same name as Account');
    }
}
