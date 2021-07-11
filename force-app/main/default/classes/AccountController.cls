public with sharing class AccountController {
    @AuraEnabled(Cacheable=true)
    public static Account[] getDefaultSearch() {
        return [
            SELECT Id, Name, BillingCity
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> searchAccounts(String searchTerm) {
        String search = searchTerm.toLowerCase().trim();

        search = '%' + search + '%';
        Account[] accounts =  [
            SELECT Id, Name, BillingCity
            FROM Account
            WHERE Name LIKE :search
            ORDER BY Name
            LIMIT 10
        ];
        
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        String accountIcon = 'standard:account';
        for (Account account : accounts) {
            String subtitle = account.BillingCity == null ? 'Account' : 'Account • ' + account.BillingCity;
            results.add(new LookupSearchResult(account.Id, 'Account', accountIcon, account.Name, subtitle));
        }

        return results;
    }
}