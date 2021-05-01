trigger Conta on Account (after update) {

    AccountTriggerHandler handler = new AccountTriggerHandler(true);

    handler.oldRecordsList = Trigger.old;
    handler.newRecordsList = Trigger.new;
    handler.oldRecordsMap  = Trigger.oldMap;
    handler.newRecordsMap  = Trigger.newMap;

    switch on Trigger.operationType{
        when AFTER_UPDATE {
            handler.onAfterUpdate();
        }
    }
}