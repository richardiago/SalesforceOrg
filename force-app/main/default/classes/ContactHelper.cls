public without sharing class ContactHelper {
    public ContactHelper() {}

    //Só permite alterar o email caso a alteração seja feita pelo Ligthning Web Component "Alteração de Email" (repeatEmail)
    public static void verificaAlteracaoEmail(List<Contact> newRecordsList, Map<Id, Contact> oldRecordsMap){

        for(Contact ct : newRecordsList){
            if(ct.Email != oldRecordsMap.get(ct.Id).Email && ct.Email_Changed_by_Component__c == true){
                ct.Email_Changed_by_Component__c = false;
            }
            else if(ct.Email != oldRecordsMap.get(ct.Id).Email && ct.Email_Changed_by_Component__c == false){
                ct.addError('Só é possível alterar o email do contato pelo componente "Alteração de Email"');
            }
        }
    }
}
