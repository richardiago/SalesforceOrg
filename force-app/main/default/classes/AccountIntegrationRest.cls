@RestResource(urlMapping='/Account/*')
global with sharing class AccountIntegrationRest {
    
    @HttpPost
    global static ID createAccount(String name){

        Account newAccount = new Account(Name=name);
        insert newAccount;
        return newAccount.Id;
    }
}
