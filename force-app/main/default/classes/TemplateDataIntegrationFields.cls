global without sharing class TemplateDataIntegrationFields {

    public interface FieldData {
        List<String> getRequiredFields();
        String getFieldKey();
        String getFieldId();
        SObject serialize(Map<String, Id> lookups);
    }
    
    public interface FieldDataChild {
        List<String> getRequiredFields();
        String getFieldKey();
        String getFieldExternal();
        SObject serialize(Map<String, String> lookups);
        String getParentKey();
    }

    global class LeadINData implements FieldData{
        
        public String  name;
        public String  email;
        public String  status;
        public String  cellphone;
        public String  company;
        
        public Lead serialize(Map<String, Id> lookups){
            return new Lead(
                Lastname		        = this.name,
                Email					= this.email,
                Status					= this.status,
                MobilePhone				= this.cellphone,
                Company					= this.company
            );
        }
        
        public List<String> getRequiredFields(){
            return new List<String>{
                'LastName',
                'Company'
            };
        }

        public String getFieldKey(){
            return 'Id';
        }
        
        public String getFieldId() {
            return 'Id';
        }
    }
    
    global virtual class Response {
        public String  idSalesforce;
        public String  externalCode;
        public String  errorMessage;
        public Boolean status;
        public String  sObjectType;
        
        public void success(String idSalesforce, String externalCode, String sObjectType){
            this.idSalesforce = idSalesforce;
            this.externalCode = externalCode;
            this.status       = true;
            this.SObjectType  = sObjectType;
        }
        
        public void error(String externalCode, String errorMessage, String sObjectType){
            this.externalCode = externalCode;
            this.status       = false;
            this.errorMessage = errorMessage;
            this.SObjectType  = sObjectType;
        }

        public void error(String idSalesforce, String externalCode, String errorMessage, String sObjectType){
            this.idSalesforce = idSalesforce;
            this.externalCode = externalCode;
            this.status       = false;
            this.errorMessage = errorMessage;
            this.SObjectType  = sObjectType;
        }
    }
    
    global class ResponseParent extends Response {
        public List<TemplateDataIntegrationFields.Response> items;
    }

}