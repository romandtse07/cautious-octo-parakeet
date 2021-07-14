global with sharing class QuoteRemoter {

    public String quoteName { get; set; }
    public static List<SBQQ__QuoteLine__c> quoteLines { get; set; }
    public QuoteRemoter() { } // empty constructor
    
    @RemoteAction
    global static List<SBQQ__QuoteLine__c> getQuoteLines(String quoteName) {
        // need to fix for subquery if it comes to this
        quoteLines = [SELECT Name, SBQQ__Product__c
            FROM SBQQ__QuoteLine__c
            WHERE SBQQ__Quote__c = :quoteName];
        return quoteLines;
    }
}
