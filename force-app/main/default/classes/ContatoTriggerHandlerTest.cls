@isTest
public class ContatoTriggerHandlerTest {
    
    @isTest
    public static void verificaAlteracaoEmailComponenteTest(){

        //Cria conta
        Account conta = new Account(Name='Conta Teste');
        insert conta;

        //Cria contato
        Contact contato = new Contact(AccountId= conta.Id, FirstName= 'Contato', LastName= 'Teste', Email= 'contato@teste.com', Email_Changed_by_Component__c = true);
        insert contato;

        //Faz update do campo Email
        contato.Email = 'teste@contato.com';
        update contato;

        //Select do contato
        Contact newContato = [SELECT Id, Email, Email_Changed_by_Component__c FROM Contact WHERE Id =: contato.Id];

        //Assert
        System.assertEquals('teste@contato.com', newContato.Email);
        System.assertEquals(false, newContato.Email_Changed_by_Component__c);
    }

    @isTest
    public static void verificaAlteracaoEmailRegistroTest(){

        //Cria conta
        Account conta = new Account(Name='Conta Teste');
        insert conta;

        //Cria contato
        Contact contato = new Contact(AccountId= conta.Id, FirstName= 'Contato', LastName= 'Teste', Email= 'contato@teste.com');
        insert contato;

        //Faz update do campo Email
        contato.Email = 'teste@contato.com';

        try{
            update contato;
        } catch (Exception e){
            System.assert(e.getMessage().contains('Só é possível alterar o email do contato pelo componente "Alteração de Email"'));
            
        }
    }
} 
