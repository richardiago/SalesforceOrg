public class AccountCSVGenerator {
    
    @InvocableMethod(label='Generate Account CSV File' category='Account' description='Generate CSV for account objects and send by email')
    public static void generateAccountCSVFile(List<String> emailList){

        String finalstr = generateCSV();
        sendEmail(finalstr, emailList);
    }

    public static String generateCSV(){

        List<Account> acclist = [SELECT Id, Name, CreatedDate, LastModifiedDate FROM Account];
        String header   = 'Record Id, Name , , Created Date, Modified Date \n';
        String finalstr = header;

        for(Account acc : acclist){

            String recordString = '"'+acc.id+'","'+acc.Name+'",,"'+acc.CreatedDate+'","'+acc.LastModifiedDate +'"\n';
            finalstr = finalstr + recordString;
        }

        return finalstr;
    }

    public static void sendEmail(String finalstr, List<String> emailList){

        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        Blob csvBlob = Blob.valueOf(finalstr);
        //String csvname = ;
        csvAttc.setFileName('Account.csv');
        csvAttc.setBody(csvBlob);

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String> {emailList[0]};
        //String subject =
        email.setSubject('Salesforce - Arquivo CSV das Contas');
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('Segue em anexo, o(s) arquivo(s) csv com as Contas. Obrigado por utilizar o Salesforce. Viva Ohana !!');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}