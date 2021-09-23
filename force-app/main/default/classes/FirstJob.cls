public with sharing class FirstJob implements Queueable{
    public void execute(QueueableContext context) {
        List<Contact> jobs = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            jobs.add(new Contact(FirstName = 'FirstJob'));
        }

        System.enqueueJob(new SecondJob(jobs));
    }
}
