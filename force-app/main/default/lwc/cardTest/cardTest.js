import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getContacts from '@salesforce/apex/CardTestController.getContacts';
import createSocios from '@salesforce/apex/CardTestController.createSocios';

export default class CardTest extends LightningElement {

    //Armazena o Id do registro caso o lwc esteja em um Aura component
    @api recId;

    //Armazena o Id do registro 
    @api recordId;

    //Variavel auxiliar renderiza ou não os itens
    showItens = false;
    contacts;
    
    //Acessa o método apex getContacts e retorna uma lista de contatos
    @wire(getContacts, {accountId: '$recId'})
    contatos ({error, data}){
        if(data){
            this.contacts = data;
            console.log("Dados recebidos entries: "+JSON.stringify(data));
            //console.log("Dados recebidos values: "+Object.values(data));
            if (this.contacts.length > 0){
                this.showItens = true;
            }

            else{
                let confirmButton = this.template.querySelector("lightning-button[data-my-id='confirm']");
                let selectAllButton = this.template.querySelector("lightning-button[data-my-id='selectAllId']");
                
                confirmButton.disabled = true;
                selectAllButton.disabled = true;

            }
        }
    }

    //Variavel que armazena o label do botão 'Selecionar todos/Limpar seleção'
    buttonSelectAllLabel = 'Selecionar Todos';

    //Variavel auxiliar para a função enableButton
    selectedItems = false;

    //Variavel auxiliar para a função selectAll
    selectAllItens = false;

    //Habilita botão 'confirmar' caso haja no minimo um item selecionado
    enableButton(){
        
        let checkboxes = this.template.querySelectorAll("lightning-input[data-my-id='inputCheckbox']");
        let element = this.template.querySelector("lightning-button[data-my-id='confirm']");
        let n = 0;

        for(var i = 0; i < checkboxes.length; i++){
            if(checkboxes[i].checked == true){
                this.selectedItems = true;
                n +=1;
            }
        }       

        if(this.selectedItems == true){
            
            element.disabled = false;
        }
        else{
            element.disabled = true;
            
        }
        
        if(n == checkboxes.length){
            this.buttonSelectAllLabel = 'Limpar Seleção'
            this.selectAllItens = true;
        }
        else if(n <= 0){
            this.buttonSelectAllLabel = 'Selecionar Todos'
            this.selectAllItens = false;
        }

        this.selectedItems = false;
    }

    //Pesquisa o termo utilizado
    searchTerm(event){
        let firstClass = this.template.querySelectorAll("div[data-my-id='cardId']");


        //Caso seja um termo nulo, branco ou só espaços
        if(this.isEmpty(event.target.value)){
            
            for(var i = 0; i < firstClass.length; i++){
                firstClass[i].hidden = false;
            }
        }
        
        //Caso seja termo válido
        else{
            for(var i = 0; i < firstClass.length; i++){

                let cards = firstClass[i].querySelectorAll("lightning-card");
                let content = cards[0].querySelectorAll("span[data-my-id='myContent']");
                let aux = false;

                for(var j = 0; j < content.length; j++){
                    if (content[j].innerText.toLowerCase().includes(event.target.value.toLowerCase())){
                        aux = true;
                    }
                }

                if(!cards[0].title.toLowerCase().includes(event.target.value.toLowerCase()) && !aux)
                    firstClass[i].hidden = true;
                else{
                    firstClass[i].hidden = false;
                }
            }
        }
    }

    //Retorna true se uma string é blank, null, ou se só tem espaços 
    isEmpty(str) {
        return (!str || 0 === str.length || (str.trim()).length === 0);
    }

    //limpa pesquisa (botão [x] do barra de busca)
    clearSearchBar(event){
        
        if(this.isEmpty(event.target.value)){

            let firstClass = this.template.querySelectorAll("div[data-my-id='cardId']");

            for(var i = 0; i < firstClass.length; i++){
                    firstClass[i].hidden = false;
            }

            this.enableButton();
        }
    }

    //Pega todos os itens selecionados
    createObjects(){

        let firstClass = this.template.querySelectorAll("div[data-my-id='cardId']");
        let checkboxes = [];

        for(var j=0; j < firstClass.length; j++){
            let aux = firstClass[j].querySelector("lightning-input");
            checkboxes.push(aux);
        }

        let idsList = [];
        
        for(var i=0; i < checkboxes.length; i++){
            
            if(checkboxes[i].checked == true){
                idsList.push(this.contacts[i].Id);
            }
        }

        //Chama o método apex e cria o objeto relacionado 'Sócio'
        createSocios({accountId: this.recId, contactsId: idsList})
            .then((result) => {
                
                eval("$A.get('e.force:refreshView').fire();");
                this.showToast(true, '');

                const closeQA = new CustomEvent('close');
                this.dispatchEvent(closeQA);
            })
            .catch((error) => {
                this.showToast(false, error);
            });    
    }

    //Seleciona ou desmarca todos os itens
    selectAll(){

        let firstClass    = this.template.querySelectorAll("div[data-my-id='cardId']");
        let confirmButton = this.template.querySelector("lightning-button[data-my-id='confirm']")

        //Seleciona todos os itens
        if(!this.selectAllItens){
            for(var i=0; i < firstClass.length; i++){
                if(!firstClass[i].hidden){
                    firstClass[i].querySelector("lightning-input").checked = true;
                }
            }

            confirmButton.disabled = false;
            this.selectAllItens = true;
            this.buttonSelectAllLabel = 'Limpar Seleção';
        }

        //Desmarca todos os itens
        else{
            for(var i=0; i < firstClass.length; i++){
                if(!firstClass[i].hidden){
                    firstClass[i].querySelector("lightning-input").checked = false;
                }
            }

            confirmButton.disabled = true;
            this.selectAllItens = false;
            this.buttonSelectAllLabel = 'Selecionar Todos';
        }
    }

    //Mostra mensagem de sucesso/erro ao criar sócios
    showToast(status, erro){
        if(status){
            const event = new ShowToastEvent({
                title: 'Sucesso',
                message: 'Sócios criados com sucesso.',
                variant: 'success',
            });

            this.dispatchEvent(event);
        }
        else{

            const event = new ShowToastEvent({
                title: 'Erro',
                message: erro.value,
                variant: 'error',
            });

            this.dispatchEvent(event);
        }
    }
}

