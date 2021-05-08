trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete) {
    ContactHandler handler = new ContactHandler(
        Trigger.operationType,
        Trigger.new, 
        Trigger.old,
        Trigger.newMap, 
        Trigger.oldMap
    );
    
    if (ContactHandler.isTriggerEnabled())
        handler.execute();
}