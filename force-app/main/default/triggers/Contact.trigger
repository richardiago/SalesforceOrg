trigger Contact on Contact (before update) {

    ContactTriggerHandler handler = new ContactTriggerHandler(true);

    handler.oldRecordsList = Trigger.old;
    handler.newRecordsList = Trigger.new;
    handler.oldRecordsMap  = Trigger.oldMap;
    handler.newRecordsMap  = Trigger.newMap;

    switch on Trigger.operationType{
        when BEFORE_UPDATE {
            handler.onBeforeUpdate();
        }
    }
}