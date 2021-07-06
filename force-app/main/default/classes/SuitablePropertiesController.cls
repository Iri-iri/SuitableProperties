public with sharing class SuitablePropertiesController {

    private static final List<String> FIELDS_TO_SELECT = new List<String>{
            'Name',
            'Address_City__c',
            'Address_Country__c',
            'Address_State__c',
            'Address_Street__c',
            'Address_ZIP__c'
    };

    private static final Map<String, String> CONDITION_MAP = new Map<String, String>{
            'Address ZIP' => 'Address_ZIP__c = :accZip',
            'Address State' => 'Address_State__c = :accState'
    };

    private static Account currentAccountWithParams(Id parentId) {
        return [
                SELECT Id, Name, BillingState, BillingPostalCode
                FROM Account
                WHERE Id = :parentId
                WITH SECURITY_ENFORCED
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Property__c> getItemsListWithCondition(Id parentId, String condition) {

        Account acc = currentAccountWithParams(parentId);

        String accState = acc.BillingState;
        String accZip = acc.BillingPostalCode;

        List<String> conditions = new List<String>{
                'Account__c = :parentId'
        };

        conditions.add(CONDITION_MAP.get(condition));

        return Database.query(
                String.format(
                        'SELECT {0} FROM Property__c WHERE {1}',
                        new List<String>{
                                String.join(FIELDS_TO_SELECT, ', '),
                                String.join(conditions, ' AND ')
                        }
                )
        );


//        String queryString = 'SELECT Id, Name, Address_City__c, Address_Country__c, Address_State__c, Address_Street__c, Address_ZIP__c FROM Property__c WHERE Account__c = :parentId AND ';
//        if (condition == 'Address ZIP') {
//            queryString += 'Address_ZIP__c = :accZip';
//        } else {
//            queryString += 'Address_State__c =:accState';
//        }
//
//        return Database.query(queryString);
    }
}