public without sharing class AlunoHandler extends TriggerHandler {
    
    public AlunoHandler(System.TriggerOperation operation, List<Aluno__c> newRecordList, List<Aluno__c> oldRecordList, Map<Id, Aluno__c> newMap, Map<Id, Aluno__c> oldMap) {
        super(operation, newRecordList, oldRecordList, newMap, oldMap);
    }

    private static Boolean runTrigger;

    static {
        runTrigger = true;
    }

    public static Boolean isTriggerEnabled(){
        return runTrigger;
    }

    public static Boolean enableTrigger(){
        return runTrigger = true;
    }

    public static Boolean disableTrigger(){
        return runTrigger = false;
    }

    public override void beforeInsert(){}

    public override void afterInsert(){
        AlunoHelper.defineCasaAluno((Map<Id, Aluno__c>) newMap);
    }

    public override void beforeUpdate(){}

    public override void afterUpdate(){}

    public override void beforeDelete(){}

    public override void afterDelete(){}
}
