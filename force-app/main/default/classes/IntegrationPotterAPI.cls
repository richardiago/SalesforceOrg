@RestResource(urlMapping='/Aluno/*')
global with sharing class IntegrationPotterAPI {
    
    @HttpGet
    global static Aluno__c getAluno(){

        RestRequest request = RestContext.request;

        String alunoId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        Aluno__c result =  [SELECT Id, Name, Casa_de_Hogwarts__c
                        FROM Aluno__c
                        WHERE Id = :alunoId];
        
        return result;
    }

    @HttpPost
    global static String createAluno(String nome){

        Aluno__c a = new Aluno__c(Name = nome);
        insert a;

        return a.Id;
    }
    
}
