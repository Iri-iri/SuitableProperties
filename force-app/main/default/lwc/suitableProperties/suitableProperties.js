import {LightningElement, api, wire, track} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

import getItemsListWithCondition from '@salesforce/apex/SuitablePropertiesController.getItemsListWithCondition';

const DEFAULT_COLUMNS = [
    {label: 'Name', fieldName: 'Name', type: 'string'},
    {label: 'ZIP', fieldName: 'Address_ZIP__c', type: 'string'},
    {label: 'Country', fieldName: 'Address_Country__c', type: 'string'},
    {label: 'City', fieldName: 'Address_City__c', type: 'string'},
    {label: 'State', fieldName: 'Address_State__c', type: 'string'},
    {label: 'Street', fieldName: 'Address_Street__c', type: 'string'}
];

export default class SuitableProperties extends NavigationMixin(LightningElement) {
    @api condition;
    @api recordId;

    @track data = undefined;
    @track error;
    columns = DEFAULT_COLUMNS;

    isLoading = true;


    @wire(getItemsListWithCondition, {parentId: '$recordId', condition: '$condition'})
    wiredItems({error, data}) {
        if (data) {
            this.data = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
        this.isLoading = false;
    }


    createProperty() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Property__c',
                actionName: 'new'
            },
        });
    }
    
}