public with sharing class QuoteLogic {

    static Blob getQuoteFiles(String service, Float margin) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rando-file-server.herokuapp.com');
        req.setTimeout(60000);
        req.setMethod('GET');

        HttpResponse res = h.send(req);
        Blob file_attachment = res.getBodyAsBlob();
        return file_attachment;
    }

    public static Void createQuoteLine(String parentQuoteId, String service, Float margin) {
        Proto_A_Quote_Line__c newQuotedService = new Proto_A_Quote_Line__c();
        newQuotedService.Name = service;
        newQuotedService.Service = service;
        newQuotedService.Margin = margin;
        newQuotedService.Proto_A_Quote_Line__c = parentQuoteId;
        insert newQuotedService;
    }

    public static String createNewQuote(String quoteName){
        Proto_A_Quote__c newQuote = new Proto_A_Quote__c();
        newQuote.name = quoteName;
        insert newQuote;
        return newQuote.Id;
    }
}
