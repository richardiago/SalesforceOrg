import { LightningElement, api} from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent'; //Mensagens de Sucesso e erro
import { updateRecord } from 'lightning/uiRecordApi'; //Editar registro

export default class RepeatEmail extends LightningElement {

    //Pega o Id do registro
    @api recordId;
    
    //Campos de email usados no html
    emailCampo1;
    emailCampo2;
    
    //Campo de email do objeto contato
    email;

    //Variavel auxiliar
    aux = false;

    //Atualiza o campo de email do objeto
    updateField(event){
        this.email = event.target.value; 
    }

    // Faz o update no registro, limpas os campos e 
    // desabilita o botão
    updateContactEmail() {

        let record = {
            fields : {
                Id: this.recordId,
                Email: this.email,
                Email_Changed_by_Component__c: true,
            }, 
        }

        updateRecord(record).then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Atualização de email",
                    message: "Email atualizado com sucesso",
                    variant: 'success',
                }),

            );
            var btSave = (this.template.querySelector('lightning-button'));
            btSave.disabled = true;
            this.emailCampo1 = '';
            this.emailCampo2 = '';
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Atualização de email",
                    message: "Não foi possível atualizar o email. Verifique o email digitado ou contate o Administrador do Sistema",
                    variant: 'error',
                }),
            );
        });
    }
    
    // Evita que o usuário use atalho de "colar"
    clearClipboard(event){
        event.preventDefault(); 
    }

    // Faz a comparação dos campos e desabilita o botão 
    // caso os campos tenha valores diferentes
    compareFields(){

        var input1 = (this.template.querySelector('[data-id="email1"]'));
        this.emailCampo1 = input1.value;
        
        var input2 = (this.template.querySelector('[data-id="email2"]'));
        this.emailCampo2 = input2.value;
    
        var btSave = (this.template.querySelector('lightning-button'));

        if(this.emailCampo2 !== this.emailCampo1){
            btSave.disabled = true;
            input2.setCustomValidity("Emails diferentes");
        }
        else if(this.emailCampo2.length == 0 || this.emailCampo1.length == 0){
            btSave.disabled = true;
        }
        else{
            btSave.disabled = false;
            input2.setCustomValidity("");
        }
        input2.reportValidity();
    }

    // Verifica se o evento é é dispardo pelo 1º campo de email
    // Em caso afirmativo E seja primeira vez nada é feito
    // Caso contrário, é feita a comparação dos dois campos
    compare(event){

        var inputId= event.target.name;

        if(inputId === "email1" && this.aux === false){
            this.aux = true;
        }
        else {
            this.compareFields();
        }
    }
}