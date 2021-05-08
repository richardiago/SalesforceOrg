public with sharing class AlunoHelper {
    public AlunoHelper() {}

    public static void defineCasaAluno(Map<Id, Aluno__c> newRecordsMap){

        Set<Id> alunosIds = newRecordsMap.keySet();
        PotterIntegration.SortingHatHouse(alunosIds);
    }
}
