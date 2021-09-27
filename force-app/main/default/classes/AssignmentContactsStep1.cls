/**
 * Created by eshemetov on 27/09/2021.
 */

public with sharing class AssignmentContactsStep1 implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        Set<fycer__ContactAssignmentRule__c> fields =  new  Set<fycer__ContactAssignmentRule__c>(
            [SELECT fycer__Field_API_Name__c FROM  fycer__ContactAssignmentRule__c]
        );

        String queue = 'SELECT';
        for (fycer__ContactAssignmentRule__c fieldItem : fields) {
            queue += ' ' + fieldItem.fycer__Field_API_Name__c + ',';
        }

        queue = queue.removeEnd(',');
        return Database.getQueryLocator(queue + ' FROM Contact');
    }

    public void execute(Database.BatchableContext context, Contact[] contacts) {
        Database.executeBatch(new AssignmentContactsStep2(contacts));
    }

    public void finish(Database.BatchableContext context) {

    }
}