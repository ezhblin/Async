public with sharing class FirstJob implements Queueable{
    public void execute(QueueableContext context) {
        Contact[] jobs = new Contact[]{};
        for (Integer i = 0; i < 200; i++) {
            jobs.add(new Contact(FirstName = 'FirstJob'));
        }

        System.enqueueJob(new SecondJob(jobs));
    }
}