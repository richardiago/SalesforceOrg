public with sharing class AlunoHelper {
    public AlunoHelper() {}

    public static void defineCasaAluno(Map<Id, Aluno__c> newRecordsMap){
        SortingHatHouse(newRecordsMap.keySet());
    }

    @Future(callout=true)
    public static void SortingHatHouse(Set<Id> alunosId){

        List<Aluno__c> alunosToUpdate = new List<Aluno__c>();
        List<Log_Integracao__c> logsToInsert = new List<Log_Integracao__c>();

        Potter_Api__mdt potterApi = [SELECT Base_URL__c, 
                                                Character_Routes__c, 
                                                House_Routes__c, 
                                                Key__c, 
                                                Sorting_Hat_Route__c, 
                                                Spell_Routes__c
                                            FROM Potter_Api__mdt LIMIT 1];

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(potterApi.Base_URL__c + potterApi.Sorting_Hat_Route__c);
        request.setMethod('GET');

        for(Id aId : alunosId){

            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200){

                Aluno__c aluno = new Aluno__c(Id=aId);
                aluno.Casa_de_Hogwarts__c = response.getBody().remove('"');
                alunosToUpdate.add(aluno);

                //Cria o log de integração
                logsToInsert.add(new Log_Integracao__c(Tipo__c= 'Consulta', Status__c='SUCCESS', Response__c= 'Casa sorteada: '+response.getBody().remove('"')+'\nId do aluno: '+aId));
            }
            else{
                //Cria o log de integração
                logsToInsert.add(new Log_Integracao__c(Tipo__c= 'Consulta', Status__c='FAIL', Response__c= response.getBody().remove('"')+' Id do aluno: '+aId));
            }

            if(!alunosToUpdate.isEmpty()){
                update alunosToUpdate;
            }
    
            if(!logsToInsert.isEmpty()){
                insert logsToInsert;
            }
        }
        
    }
}
