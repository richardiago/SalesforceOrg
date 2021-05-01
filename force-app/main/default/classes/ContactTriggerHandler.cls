public class ContactTriggerHandler {

    private Boolean isExecuting = false;
    public List<Contact> oldRecordsList = null;
    public List<Contact> newRecordsList = null;
    public Map<Id, Contact> oldRecordsMap = null;
    public Map<Id, Contact> newRecordsMap = null;


    public ContactTriggerHandler(Boolean isExecuting) {
        this.isExecuting = isExecuting;
    }

    public void onBeforeUpdate(){
        verificaAlteracaoEmail(newRecordsList, oldRecordsMap);
    }

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
