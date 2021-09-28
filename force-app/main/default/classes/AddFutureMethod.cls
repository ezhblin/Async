/**
 * Created by eshemetov on 28/09/2021.
 */

public with sharing class AddFutureMethod {

    static Contact[] contacts = new Contact[]{};

    public addFutureMethod() {
        String searchKey = '%a%';
        contacts.addAll([SELECT LastName FROM Contact WHERE FirstName LIKE :searchKey]);
    }

    @Future
    public static void processRecords() {

        for (Contact contactItem : contacts) {
            contactItem.LastName += ' Valid';
        }

        update contacts;
    }
}