import { LightningElement, api } from 'lwc';

//Apex methods
import getAssetRecords from '@salesforce/apex/AssistScreenController.getAssetRecords';
import sendInformation from '@salesforce/apex/AssistScreenController.sendInformation';

const columns = [
    { label: 'Produto', fieldName: 'productName', hideDefaultActions: true},
    { label: 'Número de Série', fieldName: 'serialNumber', hideDefaultActions: true},
    { label: 'Data da compra', fieldName: 'purchaseDate', hideDefaultActions: true, type: 'date-local', typeAttributes:{ month: '2-digit', day: '2-digit'}},
];

export default class AssistScreen extends LightningElement {

    //Id do registro
    @api recordId;

    //Variaveis auxiliares de renderização condicional
    showSpinner            = true;
    showLoadingDataMessage = true;
    showSendingDataMessage = false;
    showItems              = false;
    showNoItemsMessage     = false;
    showErrorMessage       = false;
    showSuccessMessage     = false;
    
    //Dados da tabela
    columns = columns;
    data;

    connectedCallback() {
        this.loadVariable();
    }

    async loadVariable(){
        await this.recordId;
        this.getAssetRecords();
    }

    enableButton(event){
        
        let element = this.template.querySelector("lightning-button");
        element.disabled = false;
    }

    sendCase(event){

        this.showItems = false;
        this.showSendingDataMessage = true;
        this.showSpinner = true
    }

    getAssetRecords(){

        getAssetRecords({caseId: this.recordId})
        .then((result) => {

            result = JSON.parse(result);
            
            this.showSpinner = false;
            this.showLoadingDataMessage = false;

            //Nenhum registro
            if(result.length == 0){
                this.showNoItemsMessage = true;
            }
            //Pelo menos um registro
            else{
                this.data = result;
                this.showItems = true;
            }
        })
    }

    sendInformation(){

        this.showItems = false;
        this.showSendingDataMessage = true;

        var rows = this.template.querySelector('lightning-datatable').getSelectedRows(); 

        sendInformation({caseId: this.recordId, assetId: rows[0].id})
        .then((result) => {

            

            if(result){
                this.showSendingDataMessage = false;
                this.showSuccessMessage = true;
            }
            else{
                this.showSendingDataMessage = false;
                this.showErrorMessage = true;
            }
        })
    }
}