public with sharing class QuoteLogic {

    static void quoteFileAttach(String quoteLineId, String fileName, Blob file){
        //maybe add searching later
        ContentVersion version = new ContentVersion();
        version.ContentLocation = 'S';
        version.PathOnClient = fileName;
        version.Title = fileName;
        version.versionData = file;
        insert version;

        Id versionDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE id =:version.Id].ContentDocumentId;
        ContentDocumentLink versionLink = new ContentDocumentLink();
        versionLink.ContentDocumentId = versionDoc;
        versionLink.LinkedEntityId = quoteLineId;
        versionLink.shareType = 'I';
        insert versionLink;
    }

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
        // Attachment attach = new Attachment(
        //     Name = service + '.xlsx',
        //     Body = file,
        //     ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        //     ParentId = newQuotedService.Id
        // );
        // insert attach;
        DateTime today = System.today();
        String todayFormatted = today.format('yyyy-MM-dd');
        quoteFileAttach(newQuotedService.id, 
            service + '_' + todayFormatted + '.xlsx', 
            file);
    }

    @AuraEnabled
    public static String createNewQuote(String quoteName){
        Proto_A_Quote__c newQuote = new Proto_A_Quote__c();
        newQuote.name = quoteName;
        insert newQuote;
        return newQuote.Id;
    }
}
