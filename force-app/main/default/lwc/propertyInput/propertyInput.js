import {LightningElement} from 'lwc';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

import PROPERTY_OBJECT from '@salesforce/schema/Property__c';


export default class propertyInput extends NavigationMixin(LightningElement) {

    propertyObject = PROPERTY_OBJECT;

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Property created",
            variant: "success"
        });
        this.dispatchEvent(evt);

        // this[NavigationMixin.Navigate]({
        //     type: 'standard__objectPage',
        //     attributes: {
        //         objectApiName: 'Property__c',
        //         actionName: 'home'
        //     }
        // });
        // }

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Property__c',
                actionName: 'view'
            }
        });
    }



    onCancelEvent(event) {
        event.preventDefault();

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Property__c',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            }
        });

    }
}