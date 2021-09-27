/**
 * Created 26.09.2021.
 */

public with sharing class AssignmentContactsStep2 implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator(
            'SELECT Name, fycer__ContactsLimit__c' +
                '(SELECT ' +
                    'fycer__ContactAssignmentRule__r.fycer__Field_API_Name__c, ' +
                    'fycer__ContactAssignmentRule__r.fycer__Operator__c, ' +
                    'fycer__ContactAssignmentRule__r.fycer__Field_Value__c ' +
                    'FROM ' +
                    'fycer__AccountRules__r) ' +
            'FROM Account'
        );
    }

    private Contact[] contactsForAssignment;

    public AssignmentContactsStep2(Contact[] contacts) {
        this.contactsForAssignment = contacts;
    }

    public void execute(Database.BatchableContext context, Account[] accounts) {
        for (Contact contactItem : contactsForAssignment) {
            if (contactItem.AccountId == null) {
                assignAccount(contactItem, accounts);
            } else {
                checkRules(contactItem, accounts);
            }
        }
    }

    private void assignAccount(Contact contact, Account[] accounts) {
        for (Account accountItem : accounts) {
            if (accountItem.fycer__ContactsLimit__c < 5) {
                Integer rulesFalse = accountItem.fycer__AccountRules__r.size();
                for (fycer__AccountRule__c rule : accountItem.fycer__AccountRules__r) {
                    if (compare(contact, rule)) {
                        rulesFalse --;
                    }
                }

                if (rulesFalse == 0) {
                    contact.AccountId = accountItem.Id;
                    accountItem.fycer__ContactsLimit__c ++;
                    break;
                }
            }
        }
    }

    private void checkRules(Contact contact, Account[] accounts) {
        for (Account accountItem : accounts) {
            if (accountItem.Id == contact.AccountId) {
                Integer rulesFalse = accountItem.fycer__AccountRules__r.size();
                for (fycer__AccountRule__c rule : accountItem.fycer__AccountRules__r) {
                    if (compare(contact, rule)) {
                        rulesFalse --;
                    }
                }

                if (rulesFalse > 0) {
                    contact.AccountId = null;
                    accountItem.fycer__ContactsLimit__c --;
                    assignAccount(contact, accounts);
                    break;
                }
            }
        }
    }

    private Boolean compare(Contact contact, fycer__AccountRule__c rule) {
        String operator = rule.fycer__ContactAssignmentRule__r.fycer__Operator__c;
        String b = rule.fycer__ContactAssignmentRule__r.fycer__Field_Value__c;
        String a = (String) contact.get(rule.fycer__ContactAssignmentRule__r.fycer__Field_API_Name__c);
        if (operator == '=') {
            return a == b;
        } else if (operator == '<') {
            return a < b;
        } else if (operator == '>') {
            return a > b;
        } else {
            return a != b;
        }
    }


    public void finish(Database.BatchableContext context) {
        update contactsForAssignment;
    }
}