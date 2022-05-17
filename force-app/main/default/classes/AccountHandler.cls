public without sharing class AccountHandler extends TriggerHandler {
    
    public AccountHandler(System.TriggerOperation operation, List<Account> newRecordList, List<Account> oldRecordList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
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

    public override void beforeUpdate(){}

    public override void afterUpdate(){
        AccountHelper.criaHistoricoConta((Map<Id, Account>) newMap, (Map<Id, Account>) oldMap);
    }

    public override void beforeDelete(){}

    public override void afterDelete(){}
}
