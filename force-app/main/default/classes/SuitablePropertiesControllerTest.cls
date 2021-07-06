/**
 * Created by ilevkovich on 5/27/2021.
 */

@IsTest class SuitablePropertiesControllerTest {


    @IsTest
    static void testGetItemsListWithCondition(){

        Account acc1 = new Account(Name = 'Account1', BillingState = 'Florida', BillingPostalCode='220045' );
        insert acc1;

        String testConditionZip = 'Address ZIP';
        String testConditionState = 'Address State';

        List<Property__c> testListPropertyItems = new List<Property__c>();

        Property__c prop1 = new Property__c(Address_State__c ='Florida', Address_ZIP__c ='220045', Account__c = acc1.Id);
        testListPropertyItems.add(prop1);

        Property__c prop2 = new Property__c(Address_State__c ='Florida', Address_ZIP__c ='278789', Account__c = acc1.Id);
        testListPropertyItems.add(prop2);

        Property__c prop3 = new Property__c(Address_State__c ='Florida', Address_ZIP__c ='225697', Account__c = acc1.Id);
        testListPropertyItems.add(prop3);

        Property__c prop4 = new Property__c(Address_State__c ='UK', Address_ZIP__c ='220045', Account__c = acc1.Id);
        testListPropertyItems.add(prop4);

        insert testListPropertyItems;

        Integer testListItemsConditionZip = (SuitablePropertiesController.getItemsListWithCondition(acc1.Id, testConditionZip)).size();
        Integer testListItemsConditionState = (SuitablePropertiesController.getItemsListWithCondition(acc1.Id, testConditionState)).size();


        System.assertEquals(2, testListItemsConditionZip);
        System.assertEquals(3, testListItemsConditionState);

    }

}