public without sharing class addProductToOpportunityController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductList() {
        return [SELECT Id, Name, ProductCode, Family FROM Product2];
    }
}
