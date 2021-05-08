trigger AlunoTrigger on Aluno__c (before insert, after insert, before update, after update, before delete, after delete) {
    AlunoHandler handler = new AlunoHandler(
        Trigger.operationType,
        Trigger.new, 
        Trigger.old,
        Trigger.newMap, 
        Trigger.oldMap
    );
    
    if (AlunoHandler.isTriggerEnabled())
        handler.execute();
}