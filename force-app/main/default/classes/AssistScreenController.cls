public without sharing class AssistScreenController {
    
    @AuraEnabled
    public static String getAssetRecords(Id caseId){

        List<AssetVO> assetList = new List<AssetVO>();
        Case caseRecord = [SELECT AccountId FROM Case WHERE Id =: caseId];

        try{
            for(Asset asset : [SELECT Id, Product2.Name, SerialNumber, PurchaseDate FROM Asset WHERE AccountId =: caseRecord.AccountId]){
                assetList.add(new AssetVO(asset));
            }
        }
        catch(Exception e){}

        return JSON.serializePretty(assetList);
    }

    @AuraEnabled
    public static Boolean sendInformation(Id caseId, Id assetId){

        /*Case caseRecord = [SELECT RecordTypeId, CaseNumber, Priority, CaseType__c, CaseReason__c, CreatedDate, Description, PurchaseSupportAccount__r.CNPJ__c,
                            Contact.Name, Contact.DocumentNumber__c, Contact.Phone, Contact.MobilePhone, Contact.Email, Contact.MailingPostalCode,
                            Contact.MailingStreet, Contact.AddressNumber__c, Contact.Complement__c, Contact.District__c, Contact.MailingCity,
                            Contact.MailingStateCode, (select KnowledgeArticleVersion.Title from CaseArticles order by CreatedDate limit 1),
                            (SELECT Id, Title, ContentDocumentId FROM AttachedContentDocuments)  
                           FROM Case WHERE Id =: caseId];

        Asset assetRecord = [SELECT SerialNumber, ProductCode FROM Asset WHERE Id =: assetId];

        CaseInformationVO caseInfo = new CaseInformationVO(caseRecord, assetRecord);*/

        return false;

    }

    public static Boolean isBlank(String value){
        return String.isBlank(value);
    }

    public class AssetVO{

        public String id;
        public String productName;
        public Date purchaseDate;
        public String serialNumber;

        public AssetVO(Asset asset){

            this.id           = asset.Id;
            this.productName  = asset.Product2.Name;
            this.purchaseDate = asset.PurchaseDate;
            this.serialNumber = asset.SerialNumber;
        }
    }

    // public class CaseInformationVO{

    //     public String tipoAtendimento;
    //     public String numeroOcorrencia;
    //     public String prioridadeOcorrencia;
    //     public String tipoOcorrencia;
    //     public String descricaoTipoOcorrencia;
    //     public String defeitoAlegado;
    //     public String dataHoraAbertura;
    //     public String numeroSerieProduto;
    //     public String codigoProduto;
    //     public String observacao;
    //     public String cnpjAutorizadaReclamacao;
    //     public String nomeContato;
    //     public String numeroDocumento;
    //     public String telefone;
    //     public String celular;
    //     public String email;
    //     public String CEP;
    //     public String logradouro;
    //     public String numero;
    //     public String complemento;
    //     public String bairro;
    //     public String nomeCidade;
    //     public List<AttachmentVO> anexos = new List<AttachmentVO>();

    //     public CaseInformationVO(Case caseRecord, Asset assetRecord){

    //         this.tipoAtendimento          = isBlank(caseRecord.RecordTypeId)  ? '' : caseRecord.RecordTypeId;
    //         this.numeroOcorrencia         = isBlank(caseRecord.CaseNumber)    ? '' : caseRecord.CaseNumber;
    //         this.prioridadeOcorrencia     = isBlank(caseRecord.Priority)      ? '' : caseRecord.Priority;
    //         this.tipoOcorrencia           = isBlank(caseRecord.CaseType__c)   ? '' : caseRecord.CaseType__c;
    //         this.descricaoTipoOcorrencia  = isBlank(caseRecord.CaseReason__c) ? '' : caseRecord.CaseReason__c;
    //         this.defeitoAlegado           = caseRecord.CaseArticles.isEmpty() ? '' : caseRecord.CaseArticles[0].KnowledgeArticleVersion.Title;
    //         //this.dataHoraAbertura         = ;
    //         this.numeroSerieProduto       = isBlank(assetRecord.SerialNumber) ? '' : assetRecord.SerialNumber;
    //         this.codigoProduto            = isBlank(assetRecord.ProductCode)  ? '' : assetRecord.ProductCode; 
    //         this.observacao               = isBlank(caseRecord.Description)   ? '' : caseRecord.Description;
    //         this.cnpjAutorizadaReclamacao = isBlank(caseRecord.PurchaseSupportAccount__r.CNPJ__c) ? '' : caseRecord.PurchaseSupportAccount__r.CNPJ__c;
    //         this.nomeContato              = isBlank(caseRecord.Contact.Name)              ? '' : caseRecord.Contact.Name;
    //         this.numeroDocumento          = isBlank(caseRecord.Contact.DocumentNumber__c) ? '' : caseRecord.Contact.DocumentNumber__c; 
    //         this.telefone                 = isBlank(caseRecord.Contact.Phone)             ? '' : caseRecord.Contact.Phone;
    //         this.celular                  = isBlank(caseRecord.Contact.MobilePhone)       ? '' : caseRecord.Contact.MobilePhone;
    //         this.email                    = isBlank(caseRecord.Contact.Email)             ? '' : caseRecord.Contact.Email;
    //         this.CEP                      = isBlank(caseRecord.Contact.MailingPostalCode) ? '' : caseRecord.Contact.MailingPostalCode;
    //         this.logradouro               = isBlank(caseRecord.Contact.MailingStreet)     ? '' : caseRecord.Contact.MailingStreet;
    //         this.numero                   = isBlank(caseRecord.Contact.AddressNumber__c)  ? '' : caseRecord.Contact.AddressNumber__c;
    //         this.complemento              = isBlank(caseRecord.Contact.Complement__c)     ? '' : caseRecord.Contact.Complement__c;
    //         this.bairro                   = isBlank(caseRecord.Contact.District__c)       ? '' : caseRecord.Contact.District__c;
    //         this.nomeCidade               = isBlank(caseRecord.Contact.MailingCity)       ? '' : caseRecord.Contact.MailingCity;
    //         this.UF                       = isBlank(caseRecord.Contact.MailingStateCode)  ? '' : caseRecord.Contact.MailingStateCode;

    //         for(AttachedContentDocument acd : caseRecord.AttachedContentDocuments){
    //             anexos.add(acd.Title, acd.ContentDocumentId);
    //         }
    //     }
    // }

    // public class AttachmentVO{
        
    //     public String nomeArquivo;
    //     public String url;

    //     public AttachmentVO(String fileTitle, String fileURL){
    //         this.nomeArquivo = fileTitle;
    //         this.url =  URL.getSalesforceBaseUrl().toExternalForm() + '/' + fileURL;
    //     }
    // }
}
