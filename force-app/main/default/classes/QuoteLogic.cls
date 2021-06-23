public with sharing class QuoteLogic {

    static Blob getQuoteFiles(String service, Decimal margin) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rando-file-server.herokuapp.com');
        req.setTimeout(60000);
        req.setMethod('GET');

        HttpResponse res = h.send(req);
        Blob file_attachment = res.getBodyAsBlob();
        return file_attachment;
    }

    @AuraEnabled
    public static Void createQuoteLine(String parentQuoteId, String service, Decimal margin) {
        Blob file = getQuoteFiles(service, margin);
        Proto_A_Quote_Line__c newQuotedService = new Proto_A_Quote_Line__c();
        newQuotedService.Name = service;
        newQuotedService.Service_Name__c = service;
        newQuotedService.Margin__c = margin;
        newQuotedService.Proto_A_Quote__c = parentQuoteId;
        insert newQuotedService;
        Attachment attach = new Attachment(
            Name = service + '.xlsx',
            Body = file,
            ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            ParentId = newQuotedService.Id
        );
        insert attach;
    }

    @AuraEnabled
    public static String createNewQuote(String quoteName){
        Proto_A_Quote__c newQuote = new Proto_A_Quote__c();
        newQuote.name = quoteName;
        insert newQuote;
        return newQuote.Id;
    }
}
