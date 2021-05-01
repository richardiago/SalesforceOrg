trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete) {
    AccountHandler handler = new AccountHandler(
        Trigger.operationType,
        Trigger.new, 
        Trigger.old,
        Trigger.newMap, 
        Trigger.oldMap
    );
    
    if (AccountHandler.isTriggerEnabled())
        handler.execute();
}