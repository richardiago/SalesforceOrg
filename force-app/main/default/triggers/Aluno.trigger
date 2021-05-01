trigger Aluno on Aluno__c (after insert) {

    AlunoTriggerHandler handler = new AlunoTriggerHandler(true);

    handler.oldRecordsList = Trigger.old;
    handler.newRecordsList = Trigger.new;
    handler.oldRecordsMap  = Trigger.oldMap;
    handler.newRecordsMap  = Trigger.newMap;

    switch on Trigger.operationType{
        when AFTER_INSERT {
            handler.onAfterInsert();
        }
    }
}