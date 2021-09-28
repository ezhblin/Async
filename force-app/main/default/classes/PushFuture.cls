/**
 * Created by Doom on 28.09.2021.
 */

public with sharing class PushFuture {

    public static void startFuture() {
        String searchKey = '%a%';
        String objectJSON = JSON.serialize([SELECT LastName FROM Contact WHERE FirstName LIKE :searchKey]);
        System.debug('String start :' + objectJSON);
        AddFutureMethod.processRecords(objectJSON);
    }

}