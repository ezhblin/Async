/**
 * Created by eshemetov on 24/09/2021.
 */

public with sharing class ScheduledJob implements Schedulable{
    public void execute(SchedulableContext context){
        System.enqueueJob(new FirstJob());
    }
}