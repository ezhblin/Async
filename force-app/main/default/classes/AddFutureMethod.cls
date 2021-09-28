/**
 * Created by eshemetov on 28/09/2021.
 */

public with sharing class AddFutureMethod {

    @Future
    public static void processRecords(String contactsJSON) {
        Contact[] contacts = (Contact[]) JSON.deserialize(contactsJSON, Contact[].class);
        System.debug('String :' + contactsJSON);
        System.debug(contacts);
        for (Contact contactItem : contacts) {
            contactItem.LastName += ' Valid';
        }

        update contacts;
    }
}