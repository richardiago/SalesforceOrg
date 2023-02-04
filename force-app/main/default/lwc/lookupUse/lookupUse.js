import { LightningElement, api, track } from 'lwc';

export default class LookupUse extends LightningElement {

    @track recordList = {
		accountId: null,
		contactId: null,
		standardContactId: null,
		orderId: null,
		orderItemId: null
	};


    @api placeholder = 'Digite o nome da conta';
    @track fieldsToSearch = ['Name', 'CNPJ__c'];
    @track optionsToShow = { title: 'Name'};

    changeOrderItem(event) {
		const { record } = event.detail;
		console.log('changeOrderItem record =>', JSON.parse(JSON.stringify(record)));

		this.recordList.accountId = record.Id;
	}

    clearOrderItem() {
		console.log('clearOrderItem');
		this.recordList.accountId = null;
	}


}