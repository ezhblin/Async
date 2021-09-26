public with sharing class SecondJob implements Queueable{
    List<Contact> contacts = new List<Contact>();
    
    public SecondJob(List<Contact> contacts) {
        this.contacts = contacts;
    }
    
    public void execute(QueueableContext context) {
        for (Contact contactItem : contacts) {
            contactItem.LastName = 'SecondJob';
        }

        insert contacts;
        System.scheduleBatch(new NewTitle(), 'new title for jobs', 20);
    }
}
