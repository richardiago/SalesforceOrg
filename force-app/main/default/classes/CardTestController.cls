public without sharing class CardTestController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId){

        return [SELECT Id, Name, Title, Email, Phone FROM Contact WHERE AccountId =: accountId];
    }

    @AuraEnabled
    public static void createSocios(String accountId, List<String> contactsId){
        System.debug('Conta recebida: '+accountId);
        System.debug('contatos recebidos: '+contactsId);

        List<Socios__c> sociosList = new List<Socios__c>();

        for (String contact : contactsId){
            sociosList.add(new Socios__c(ContaAssociada__c = accountId, ContatoSocio__c = contact));
        }

        try{
            insert sociosList;  
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}
