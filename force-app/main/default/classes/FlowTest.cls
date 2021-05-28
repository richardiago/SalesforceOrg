global with sharing class FlowTest {

   @InvocableMethod
   public static void getAccountIds(List<Id> accountId) {
       
       Account account = [SELECT Id, Name FROM Account WHERE Id IN: accountId LIMIT 1];

       System.debug('Account Name: '+account.Name);
       account.Name = account.Name + 'Teste flow de tela';
       update account;
   }
}
