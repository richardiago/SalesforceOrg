import { LightningElement, wire, track, api } from 'lwc';
import getProductList from '@salesforce/apex/addProductToOpportunityController.getProductList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [{label : "Name", fieldName: "Name"},
                    {label : "Código do produto", fieldName: "ProductCode"},
                    {label : "Família", fieldName: "Family"}];

export default class AddProductToOpportunity extends LightningElement {

    @wire(getProductList) products;
    columns = columns;

    @api recordId;

    @track quantScreen = false;
    @track selectedRows;

    enableButton(event){
        const nSelectedRows = event.detail.selectedRows;
        let element = this.template.querySelector("lightning-button");

        if(nSelectedRows.length >= 1){
            
            element.disabled = false;
        }
        else{
            element.disabled = true;
        }
    }

    quantProducts(event){
        this.selectedRows = this.template.querySelector('lightning-datatable').getSelectedRows();
        this.quantScreen = true;        
    }

    removeRow(event){
        if(this.selectedRows.length >= 2){
            this.selectedRows = this.selectedRows.filter(function (element) {
                return element.Id !== event.target.accessKey;
            })
        }
    }

    backToBegin(event){
        this.quantScreen = false;
    }

    handleSubmit(){

        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isVal = isVal && element.reportValidity();
        });

        if(isVal){
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                element.submit();
            });
    
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sucesso',
                    message: 'Produtos adicionados com sucesso',
                    variant: 'success',
                }),
            );

            this.quantScreen = false;
            eval("$A.get('e.force:refreshView').fire();");
        } else{

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Erro ao adicionar o produto',
                    message: 'Preencha todos os campos',
                    variant: 'error',
                }),
            );
        }


        
    }
}