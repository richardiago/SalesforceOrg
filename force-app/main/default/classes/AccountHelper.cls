public without sharing class AccountHelper {
    public AccountHelper() {}

    public static void criaHistoricoConta(Map<Id, Account> newRecordsMap, Map<Id, Account> oldRecordsMap){

        Map<String, String> fieldsNameTofieldsLabel = new Map<String, String>();
        Map<Account, List<String>> accountToChangedFields = new Map<Account, List<String>>();
        List<AccountHistory__c> accountHistoryToInsert = new List<AccountHistory__c>();
        

        //Todos os campos do objeto 'Account'
        SObjectType objToken = Schema.getGlobalDescribe().get('Account');
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap(); 

        Set<String> fieldSet = fields.keySet();
        for(String s : fieldSet){

            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            fieldsNameTofieldsLabel.put(selectedField.getName(), selectedField.getLabel());
        }

        fieldsNameTofieldsLabel.remove('LastModifiedById');
        fieldsNameTofieldsLabel.remove('LastModifiedDate');
        fieldsNameTofieldsLabel.remove('SystemModstamp');

        //Verifica quais campos da conta sofreram alteração
        for(Account acc : newRecordsMap.values()){

            accountToChangedFields.put(acc, new List<String>());

            for(String field : fieldsNameTofieldsLabel.keySet()){
                
                if(newRecordsMap.get(acc.Id).get(field) != oldRecordsMap.get(acc.Id).get(field)){
                    accountToChangedFields.get(acc).add(field);
                }
            }
        }

        //Cria novos registros do objeto 'AccountHistory__c'
        for(Account acc: accountToChangedFields.keySet()){
            accountHistoryToInsert.addAll(createAccountHistoryRecord(oldRecordsMap.get(acc.Id), newRecordsMap.get(acc.Id), accountToChangedFields.get(acc), fieldsNameTofieldsLabel));
        }

        insert accountHistoryToInsert;
    }

    public static List<AccountHistory__c> createAccountHistoryRecord(Account oldAcc, Account newAcc, List<String> changedFields, Map<String, String> fieldsNameTofieldsLabel){

        System.debug('Campos a serem alterados: '+changedFields);
        List<AccountHistory__c> accHistList = new List<AccountHistory__c>();
        
        for(String field : changedFields){

            AccountHistory__c accHist = new AccountHistory__c();
            accHist.Account__c = newAcc.Id;
            accHist.CampoAlterado__c = fieldsNameTofieldsLabel.get(field);
            accHist.ValorAnterior__c = (String) oldAcc.get(field);
            accHist.ValorAtual__c = (String) newAcc.get(field);

            accHistList.add(accHist);
        }

        return accHistList;
    }
}
