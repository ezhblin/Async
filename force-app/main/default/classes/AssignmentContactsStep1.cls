/**
 * Created by eshemetov on 27/09/2021.
 */

public with sharing class AssignmentContactsStep1 implements Database.Batchable<SObject> {
    private static Contact[] contactsAll = new Contact[]{};

    public Database.QueryLocator start(Database.BatchableContext context) {
        fycer__ContactAssignmentRule__c[] fields = [SELECT fycer__Field_API_Name__c FROM  fycer__ContactAssignmentRule__c];
        Set<String> uniqueFields =  new Set<String>();

        for (fycer__ContactAssignmentRule__c fieldItem : fields) {
            uniqueFields.add((String) fieldItem.fycer__Field_API_Name__c);
        }


        String queue = 'SELECT AccountId,';
        for (String fieldItem : uniqueFields) {
            if (fieldItem != 'AccountId') {
                queue += ' ' + fieldItem + ',';
            }
        }

        queue = queue.removeEnd(',');
        return Database.getQueryLocator(queue + ' FROM Contact');
    }

    public void execute(Database.BatchableContext context, Contact[] contacts) {
        contactsAll.addAll(contacts);
    }

    public void finish(Database.BatchableContext context) {
        Database.executeBatch(new AssignmentContactsStep2(contactsAll));
    }
}