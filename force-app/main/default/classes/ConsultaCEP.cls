global without sharing class ConsultaCEP {
    
    @InvocableMethod(Label = 'Consulta API ViaCEP')
    public static List<AddressVo> consultaViaCep(List<String> cep){

        AddressVo add;

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://viacep.com.br/ws/' + cep[0] + '/json/');

        Http h = new Http();
        HttpResponse resp = h.send(request);

        if(resp.getStatusCode() ==  200){
            add = (ConsultaCEP.AddressVo) JSON.deserialize(resp.getBody(), ConsultaCEP.AddressVo.class);
            if(add.erro == null) add.erro = false;
        }
        else{
            add = (ConsultaCEP.AddressVo) JSON.deserialize(resp.getBody(), ConsultaCEP.AddressVo.class);
        }

        System.debug('Resposta: '+ JSON.serializePretty(add));
        return new List<AddressVo>{add};
    }

    global class AddressVo{

        @InvocableVariable
        global String cep;

        @InvocableVariable
        global String logradouro;

        @InvocableVariable
        global String complemento;

        @InvocableVariable
        global String bairro;

        @InvocableVariable
        global String localidade;

        @InvocableVariable
        global String uf;

        @InvocableVariable
        global String ibge;

        @InvocableVariable
        global String gia;

        @InvocableVariable
        global String ddd;

        @InvocableVariable
        global String siafi;

        @InvocableVariable
        global Boolean erro;
    }
}
