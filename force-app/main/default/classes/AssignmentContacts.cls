/**
 * Created 26.09.2021.
 */

public with sharing class AssignmentContacts implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT Id, AccountId FROM Contact');
    }

    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        for (Contact contactItem : contacts) {
            contactItem.Title = 'Async Apex';
        }
        update contacts;
    }

    public void finish(Database.BatchableContext context) {

    }
}