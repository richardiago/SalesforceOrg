import { LightningElement } from 'lwc';

const columns = [
    { label: 'Item do Pedido', fieldName: 'orderItem', hideDefaultActions: true},
    { label: 'EAN', fieldName: 'EAN', hideDefaultActions: true},
    { label: 'Quantidade Solicitada', fieldName: 'requestedQuantity', hideDefaultActions: true},
    { label: 'Quantidade Atendida', fieldName: 'servedQuantity', hideDefaultActions: true},
    { label: 'Motivo', fieldName: 'reason', hideDefaultActions: true},
];

const data = [
{
        codPedido : 1321313,
        listaItems : [{
            id: 'a',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'b',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'c',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'd',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        }]    
},
{
        codPedido : 1321314,
        listaItems : [{
            id: 'a',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'b',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'c',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'd',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'e',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'f',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'g',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'h',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'i',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'j',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'k',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'l',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        }]
},
{
        codPedido : 1321315,
        listaItems : [{
            id: 'a',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        },
        {
            id: 'b',
            orderItem: 'Cloudhub',
            EAN: 1233,
            requestedQuantity: 25000,
            servedQuantity: 'jrogers@cloudhub.com',
            reason: 'Não sei'
        }]
}

]

export default class SearchScreen extends LightningElement {

    showData = false;
    columns = columns;
    data = data;

    //Show the data if exists
    showDataTemplate(){

        if(this.data.length > 0){
            this.showData = true;
        }
        else {
            this.showData = false;
        }
    }
    
    //Resize the div that involves the datatable according with the number of rows
    changeSize(event){
        
        let datatable = event.target.querySelector("lightning-datatable");
        
        let datatableDiv = event.target.querySelector("div[data-my-id='divDatatable']");
        
        let listSize = datatable.data.length;
        let divHeight = 0;

        if(listSize >= 10){
            divHeight = 300;
        }
        else{
            divHeight = 30 + (listSize * 29.9);
        }
        datatableDiv.style = "height: "+divHeight+"px;";
    }


    //Enable/Disable 'Limpar' button
    showCleanButton(){

        //'Limpar' button
        let cleanButton = this.template.querySelector("lightning-button[data-my-id='cleanButton']");

        //Fields to be verified
        let orderAccount = this.template.querySelector("lightning-input-field[data-my-id='orderAccount']");
        let orderDate = this.template.querySelector("lightning-input[data-my-id='orderDate']");
        let orderNumber = this.template.querySelector("lightning-input[data-my-id='orderNumber']");

        if(this.isEmpty(orderAccount.value) && this.isEmpty(orderDate.value) && this.isEmpty(orderNumber.value)){
            cleanButton.disabled = true;
        }
        else {
            cleanButton.disabled = false;
        }
    }

    //Returns true if the string is blank, null or made by only spaces 
    isEmpty(str) {
        return (!str || 0 === str.length || (str.trim()).length === 0);
    }

    //Clean the fields
    cleanFields(){

        //'Limpar' button
        let cleanButton = this.template.querySelector("lightning-button[data-my-id='cleanButton']");

        //Fields
        let orderAccount = this.template.querySelector("lightning-input-field[data-my-id='orderAccount']");
        let orderDate = this.template.querySelector("lightning-input[data-my-id='orderDate']");
        let orderNumber = this.template.querySelector("lightning-input[data-my-id='orderNumber']");

        orderAccount.value = null;
        orderDate.value = null;
        orderNumber.value = null;

        cleanButton.disabled = true;
    }
}