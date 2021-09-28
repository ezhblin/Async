/**
 * Created by eshemetov on 27/09/2021.
 */

@IsTest
private class AssignmentContactsStep1Test {
    @IsTest
    static void testBehavior() {
        Test.startTest();
        Database.executeBatch(new AssignmentContactsStep1());
        Test.stopTest();
        System.assertEquals(49, [SELECT Name FROM Contact WHERE AccountId = NULL].size());
    }

    @TestSetup
    static void fillTestData() {
        SObject[] testData = new SObject[]{};
        Contact[] contacts = new Contact[]{};
        Account[] accounts = new Account[]{};
        fycer__ContactAssignmentRule__c[] rules = new fycer__ContactAssignmentRule__c[]{};


        for (Integer i = 0; i < 99; i++) {
            accounts.add(new Account(Name = 'Test' + i));
            rules.add(new fycer__ContactAssignmentRule__c(
                    fycer__Field_API_Name__c = 'LastName',
                    fycer__Field_Value__c = 'test',
                    fycer__Operator__c = '='
            ));
            contacts.add(new Contact(FirstName = 'Test' + i, LastName = 'test'));
            contacts.add(new Contact(FirstName = 'Test2' + i, LastName = 'test'));
        }
        testData.addAll(contacts);
        testData.addAll(accounts);
        testData.addAll(rules);

        insert testData;

        Contact badContact = new Contact();

        fycer__AccountRule__c[] accountRule = new fycer__AccountRule__c[]{};
        for (Integer i = 0; i < 30; i++) {
            if (i == 0) {
                badContact.FirstName = 'Test';
                badContact.LastName = 'badass';
                badContact.AccountId = accounts[i].Id;
            }
            accountRule.add(new fycer__AccountRule__c(fycer__Account__c = accounts[i].Id, fycer__ContactAssignmentRule__c = rules[i].Id));
        }

        insert badContact;
        insert accountRule;

    }
}