@isTest
global with sharing class BulkApiContactTest implements HttpCalloutMock{

    @isTest
    public static void bulkCreate(){
        
        Test.setMock(HttpCalloutMock.class, new BulkApiContactTest()); 

        RestRequest request = new RestRequest();
        request.requestUri = URL.getOrgDomainUrl().toExternalForm()+'/services/apexrest/Contact';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof('12345');
        RestContext.request = request;

        BulkApiContact.insertContact(); 
        request.requestBody = Blob.valueof('');

        BulkApiContact.insertContact();

        BulkApiContact.bulkCreateJob(Blob.valueof('12345'));
        BulkApiContact.loadData(Blob.valueof('12345'), '12345');
        BulkApiContact.closeJob('12345');
    }
    
    global HTTPResponse respond(HTTPRequest request){

        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"teste": ["teste", "teste", "teste", "teste", "teste"]}');
        response.setStatusCode(200);
        return response; 
    }
}
