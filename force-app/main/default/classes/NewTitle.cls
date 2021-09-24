public with sharing class NewTitle implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT Title FROM Contact WHERE FirstName = "FirstJob" AND LastName = "SecondJob"');
    }
  
    public void execute(Database.BatchableContext context, List<Contact> jobs) {
        for (Contact jobsItem : jobs) {
            
        }
    }
  
    public void finish(Database.BatchableContext context) {

    }
}
