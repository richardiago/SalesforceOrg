import { LightningElement, api } from 'lwc';

export default class RecordFormStaticContact extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    emailCampo2="";
}