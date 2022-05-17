@RestResource(urlMapping='/Contact')
global without sharing class BulkApiContact {
    
    @HttpPost
    global static void insertContact(){

        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;

        Blob body = request.requestBody;

        if (body != null && body.size() > 0){

            if(!Test.isRunningTest()){

                Map<String, Object> response = bulkCreateJob(body);
                
                res.responseBody = Blob.valueOf(JSON.serialize(response));
                res.statusCode = 200;

                IntegrationUtils.WSLog('Bulk API Contact', 'Inbound', JSON.serialize(request), JSON.serialize(response), false);

            }
            
        }
        else {
            if(!Test.isRunningTest()){

                res.responseBody = Blob.valueOf('Bad request. Verify your body request please.');
                res.statusCode = 200;

                IntegrationUtils.WSLog('Bulk API Contact', 'Inbound', JSON.serialize(request), JSON.serialize(res.responseBody), true);
            }
        }             
        
    }

    //Create the bulk job and returns the job id
    public static Map<String, Object>  bulkCreateJob(Blob dataToBulkify){

        //Request to create the job
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm()+'/services/data/v50.0/jobs/ingest');
        request.setHeader('content-type', 'application/json');
        request.setHeader('Authorization' ,'Bearer '+ userInfo.getSessionId());

        String body = '{ '+
                        '"externalIdFieldName": "ExternalId__c",'+  
                        '"lineEnding": "CRLF",'+ 
                        '"operation": "upsert",'+ 
                        '"object": "Contact",'+ 
                        '"contentType": "CSV"'+
                      '}';
        
        request.setBody(body);
        Http h = new Http();

        HttpResponse resp = h.send(request);

        if(resp.getStatusCode() < = 299){
            Map<String, Object> respMap = (Map<String, Object>) Json.deserializeUntyped(resp.getBody());
            String jobId = (String)respMap.get('id');

            String response = loadData(dataToBulkify, jobId);
            return respMap;
        }

        Map<String, Object> respMap = new Map<String, Object>();

        return respMap;
    }

    //load data (csv file) to the job, return jobId 
    public static String loadData(Blob dataToBulkify, String jobId){

        HttpRequest request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm()+'/services/data/v50.0/jobs/ingest/'+jobId+'/batches');
        request.setHeader('content-type', 'text/csv');
        request.setHeader('Authorization', 'Bearer '+ userInfo.getSessionId());
        request.setBodyAsBlob(dataToBulkify);

        Http h = new Http();
        HttpResponse resp = h.send(request);

        if(resp.getStatusCode() <= 299){
            String response = closeJob(jobId);
            return response;
        }

        return JSON.serialize('Error when loading data');
    }

    //close the job, return jobId
    public static String closeJob(String jobId){

        HttpRequest request = new HttpRequest();
        request.setMethod('PATCH');
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm()+'/services/data/v50.0/jobs/ingest/'+jobId);
        request.setHeader('content-type', 'application/json');
        request.setHeader('Authorization', 'Bearer '+ userInfo.getSessionId());
        request.setBody('{ "state" : "UploadComplete" }');

        Http h = new Http();
        HttpResponse resp = h.send(request);

        if(resp.getStatusCode() <= 299){
            return jobId;
        }

        return JSON.serialize('There was an error. Please contact your admin.');
    }
}
