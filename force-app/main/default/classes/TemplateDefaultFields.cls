public without sharing class TemplateDefaultFields {

    public interface FieldDefaults { 
        Map<String, Object> getFieldDefaults();
    }

    public class FinancialCoefficientDefaults implements FieldDefaults{
        public Map<String, Object> getFieldDefaults(){
            return new Map<String, Object>{
                'Coefficient__c' => 0.3
            };
        }
    }
    
    public class PackDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Pack - Teste',
				'ExternalId__c' => 'P001',
                'UnitMeasure__c' => 001
            };
        }
    }

    public class PaymentConditionDefaults implements FieldDefaults{
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'ExternalId__c' => '10'
            };
        }
    }

    public class AccountDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'name' => 'Account - Teste',
                'Address__c' => 'Address - Teste',
                'CPF__c' => '000.000.000-00',
                'CNPJ__c' => '00.000.000/0000-00',
                'ClientType__c' => 'Produtor',
                'Email__c' => 'teste@teste.com',
                'ExternalId__c' => 'ExternalId - Teste',
                'RG__c' => '00.000.000-0',
                'IE__c' => '000.000.000.000',
                'Telephone__c' => '(00)00000-0000',
                'Special__c' => false
            };
        }
    }

    public class CropCloseDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'name' => 'Data de Safra',
                'Parameter__c' => 20
            };
        }
    }
    
    public class InstallmentDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Price__c' => 100.00,
                'DueDate__c' => Date.today(),
                'CropDifference__c' => 10.00,
                'PercentageInstallment__c' => 5
            };
        }
    }

    public class CompanyDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Inquima',
                'ExternalId__c' => '10'
            };
        }
    }

    public class DepositDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Inquima',
                'ExternalId__c' => '10',
                'Type__c' => 'Próprio'
            };
        }
    }

    public class UserDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'ExternalId__c' => '10' + Datetime.now(),
                'Username' => 'test' + Datetime.now().getTime() +'@test.com',
                'LastName' => 'inquima',
                'Email' => 'inquima@inquima.com',
                'Alias' => 'inquima',
                'CommunityNickname' => 'inquima',
                'TimeZoneSidKey' => 'America/Sao_Paulo',
                'LocaleSidKey' => 'pt_BR',
                'EmailEncodingKey' => 'ISO-8859-1',
                'LanguageLocaleKey' => 'pt_BR'
            };
        }
    }

    public class UsageDefaults implements FieldDefaults{
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'ExternalId__c' => '10',
                'Type__c' => 'Amostra'
            };
        }
    }

    public class OrderDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'EffectiveDate' => Date.today().addDays(2),
                'Status' => '1',
                'ClosingDate__c' => Date.today().addDays(4),
                'InstallmentQuantity__c' => '2',
                'IntegrationStatus__c' => '2',
                'LastDeliveryDate__c' => Date.today().addDays(5)
            };
        }
    }

    public class OrderItemDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'DeliveryDate__c' => Date.today(),
                'Discount__c' => 50.00,
                'EndDate' => Date.today() + 10,
                'Description' => 'Description',
                'Quantity' => 10,
                'ServiceDate' => Date.today() + 10,
                'Status__c' => 'Ativo',
                'MovementType__c' => 'Venda',
                'TotalDiscount__c' => 15.00,
                'TotalPracticed__c' => 100.00,
                'TotalSuggested__c' => 100.00,
                'UnitPrice' => 100.00,
                'UnitPriceCustom__c' => 100.00
            };
        }
    }

    public class Product2Defaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'TA35',
                'ExternalId__c' => '10',
                'MaterialType__c' => 'Acabado',
                'Pack__c' => 'Pack - Teste',
                'Segment__c' => 'Segment - Teste'
            };
        }
    }

    public class RegionalDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Regional - Teste',
                'ExternalId__c' => 'RT'
            };
        }
    }

    public class StateDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'State - Teste',
                'Initials__c' => 'ST'
            };
        }
    }

    public class CountryDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Country - Teste',
                'Initials__c' => 'CT'
            };
        }
    }

    public class ProductTypeDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'ProductType - Teste',
                'ExternalId__c' => '001',
                'PrimaryUnit__c' => 'Litros',
                'Segment__c' => 'Sementes'
            };
        }
    }

    public class NegotiationInputDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Released'
            };
        }
    }

    public class Pricebook2Defaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'Pricebook2 - Teste',
                'ClientType__c' => 'Sementeiro',
                'ExpirationDate__c' => Date.today(),
                'ExternalId__c' => 'Pricebook2'
            };
        }
    }

    public class PricebookEntryDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'UnitPrice' => 100,
                'MinimumPrice__c' => 100,
                'ExternalId__c' => 'PricebookEntry'
            };
        }
    }

    public class LeadTimeDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'LeadTime - Teste',
                'ExternalId__c' => 'LeadTime',
                'Time__c' => 40,
                'OriginState__c' => ''
            };
        }
    }

    public class InvoiceDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'NFTest',
                'ExternalId__c' => 'NFTest',
                'SAPEmitDate__c' => Date.today()
            };
        }
    }

    public class InvoiceItemDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'NFITest',
                'ExternalId__c' => 'NFITest'
            };
        }
    }

    public class ReturnInvoiceDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'RNFTest',
                'ExternalId__c' => 'RNFTest'
            };
        }
    }

    public class ReturnInvoiceItemDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object>{
                'Name' => 'RNFITest',
                'ExternalId__c' => 'RNFITest'
            };
        }
    }
}