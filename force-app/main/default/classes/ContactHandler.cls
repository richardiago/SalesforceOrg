public with sharing class ContactHandler extends TriggerHandler {
    
    public ContactHandler(System.TriggerOperation operation, List<Contact> newRecordList, List<Contact> oldRecordList, Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
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

    public override void afterInsert(){}

    public override void beforeUpdate(){
        ContactHelper.verificaAlteracaoEmail((List<Contact>) newRecordList, (Map<Id, Contact>) oldMap);
    }

    public override void afterUpdate(){}

    public override void beforeDelete(){}

    public override void afterDelete(){}
}
