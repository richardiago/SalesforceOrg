public class AlunoTriggerHandler {
    
    private Boolean isExecuting = false;
    public List<Aluno__c> oldRecordsList = null;
    public List<Aluno__c> newRecordsList = null;
    public Map<Id, Aluno__c> oldRecordsMap = null;
    public Map<Id, Aluno__c> newRecordsMap = null;

    public AlunoTriggerHandler(Boolean isExecuting) {
        this.isExecuting = isExecuting;
    }

    public void onAfterInsert(){
        defineCasaAluno(this.newRecordsMap);
    }

    public static void defineCasaAluno(Map<Id, Aluno__c> newRecordsMap){

        Set<Id> alunosIds = newRecordsMap.keySet();
        PotterIntegration.SortingHatHouse(alunosIds);
    }
}
